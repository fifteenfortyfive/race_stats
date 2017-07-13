class LogEvent < Crecto::Model
  created_at_field nil
  updated_at_field nil

  schema "event_logs" do
    field :occurred_at, Time
    field :type, String
    field :message, String
    field :reference_id, Int32
    field :reference_type, String
  end


  REFERENCE_TYPES = {
    "Game" => Game,
    "Run" => Run,
    "Runner" => Runner,
    "Team" => Team
  }

  def reference
    Repo.get(REFERENCE_TYPES[reference_type], reference_id)
  end

  def reference=(object : Crecto::Model)
    self.reference_id = object.id
    self.reference_type = object.class.name
  end


  def self.log(type : String, message : String, reference)
    event = self.new
    event.occurred_at = Time.now
    event.type = type
    event.message = message
    event.reference = reference
    Repo.insert(event)
    event
  end
end
