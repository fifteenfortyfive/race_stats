class Game < Crecto::Model
  schema "games" do
    field :name, String
    field :series, String
    field :progress_unit, String
    field :progress_max, Int32
    field :sequence_number, Int32

    has_many :runs, Run
  end

  # `progress_target` is the combination of `progress_max` and `progress_unit`
  def progress_target
    # Remove spaces for percentage units
    if progress_unit == "%"
      "#{progress_max}#{progress_unit}"
    else
      "#{progress_max} #{progress_unit}"
    end
  end
end
