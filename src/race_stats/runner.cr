class Runner < Crecto::Model
  schema "runners" do
    field :name, String

    has_many :runs, Run
    belongs_to :team, Team
  end
end
