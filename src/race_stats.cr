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

Kemal.run
