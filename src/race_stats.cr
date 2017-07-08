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

get "/api/coming_up" do |env|
  upcoming_runs = Repo.all(Run, Query.order_by("schedule_number ASC"), preload: [:team, :runner, :game]).first(5)

  JSON.build do |json|
    json.array do
      upcoming_runs.each do |run|
        json.object do
          json.field "runner", run.runner.name
          json.field "game", run.game.name
          json.field "team", run.team.name
          json.field "estimate", run.estimate
        end
      end
    end
  end
end

get "/api/on_screen" do |env|
  {
    "channel"   =>  ["gamesdonequick", "superiorwarbringer"].sample,
    "runner"    =>  "ConklesToTheMax",
    "game"      =>  "Kazooie",
    "team"      =>  "The Happy Little Speed Runners",
    "estimate"  =>  "13500"
  }.to_json
end


post "/api/run/:id/start" do |context|
  run = Repo.get!(Run, context.params.url["id"])
  run.start_time = Time.now
  Repo.update(run)
end

post "/api/run/:id/finish" do |context|
  run = Repo.get!(Run, context.params.url["id"])
  run.finish_time = Time.now
  Repo.update(run)
end


Kemal.run
