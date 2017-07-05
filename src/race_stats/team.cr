class Team < Crecto::Model
  schema "teams" do
    field :name, String
    field :current_run, Int32

    has_many :runs, Run
    has_many :runners, Runner
  end
end
