require "pg"
require "crecto"
require "kemal"

require "./repo"
require "./race_stats/*"

ws "/teams" do |socket|
  SocketManager.add_listener(socket)
  socket.on_close do
    SocketManager.remove_listener(socket)
  end
end

get "/" do
  _all_runs = Repo.all(Run, Query.order_by("schedule_number ASC"), preload: [:team, :runner, :game])
  runs_by_teams = _all_runs.group_by{ |r| r.team }

  render "src/views/overview.html.ecr"
end

get "/runner/:name" do |context|
  runner = Repo.get_by!(Runner, name: context.params.url["name"])
  runs = Repo.all(Run, Query.where(runner_id: runner.id).order_by("schedule_number ASC"), preload: [:team, :game])
  render "src/views/runner_screen.html.ecr"
end



before_all("/api/") { |env| env.response.content_type = "application/json" }

RACE_START_TIME = Time.new(2017, 7, 9, 17, 0, 0)

def calculate_start_time(run : Run)
  if run.schedule_number == 1
    return RACE_START_TIME
  else
    runs_for_team = Repo.all(Run, Query.where(team_id: run.team_id).order_by("schedule_number ASC")).as(Array(Run))
    finished_runs = runs_for_team.select{ |r| r.finished? }

    estimated_start = RACE_START_TIME
    finished_runs.each do |r|
      estimated_start += Time::Span.from(r.elapsed_time, Time::Span::TicksPerSecond)
    end

    current_run = runs_for_team[run.team.current_run.not_nil! - 1]
    estimated_start += Time::Span.from(current_run.estimate.not_nil!, Time::Span::TicksPerSecond)
    estimated_start
  end
end

get "/api/coming_up" do |env|
  next_runs = Repo.all(Run, Query.where(start_time: nil).order_by("schedule_number ASC"), preload: [:team, :runner, :game])
  next_runs = next_runs.uniq{ |r| r.team_id }

  JSON.build do |json|
    json.array do
      next_runs.each do |run|
        json.object do
          json.field "runner", run.runner.name
          json.field "game", run.game.name
          json.field "team", run.team.name
          json.field "start_time", calculate_start_time(run).epoch
        end
      end
    end
  end
end

previously_displayed_run = nil

get "/api/on_screen" do |env|
  runs = Repo.all(Run, Query.where("start_time IS NOT NULL AND finish_time IS NULL"), preload: [:runner, :team, :game])
  if runs.empty?
    "no runs to display"
  else
    run_to_display = runs.sample
    until run_to_display != previously_displayed_run
      run_to_display = runs.sample
    end

    previously_displayed_run = run_to_display

    {
      "channel"   =>  ["gamesdonequick", "superiorwarbringer"].sample,
      "runner"    =>  run_to_display.runner.name,
      "game"      =>  run_to_display.game.name,
      "team"      =>  run_to_display.team.name,
      "estimate"  =>  run_to_display.estimate
    }.to_json
  end
end


ws "/runner" do |socket|
  RunnerSocket.new(socket)
end


Kemal.run
