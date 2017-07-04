require "pg"
require "crecto"
require "kemal"

require "./repo"
require "./race_stats/*"


get "/" do
  _all_runs = Repo.all(Run, Query.order_by("schedule_number ASC"), preload: [:team, :runner, :game])
  runs_by_teams = _all_runs.group_by{ |r| r.team }

  render "src/views/overview.html.ecr"
end

get "/runner" do
  render "src/views/runner_screen.html.ecr"
end


get "/api/coming_up" do |env|
  env.response.content_type = "application/json"

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
  env.response.content_type = "application/json"

  {
    "channel"   =>  ["gamesdonequick", "KrisMarqz", "notvanni"].sample,
    "runner"    =>  "ConklesToTheMax",
    "game"      =>  "Kazooie",
    "team"      =>  "The Happy Little Speed Runners",
    "estimate"  =>  "13500"
  }.to_json
end


Kemal.run
