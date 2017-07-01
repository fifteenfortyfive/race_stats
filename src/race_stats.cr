require "pg"
require "crecto"
require "kemal"

require "./repo"
require "./race_stats/*"


get "/" do
  render "src/views/overview.html.ecr"
end

get "/runner" do
  render "src/views/runner_screen.html.ecr"
end

Kemal.run
