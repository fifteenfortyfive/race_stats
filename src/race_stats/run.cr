class Run < Crecto::Model
  schema "runs" do
    field :schedule_number, Int32
    field :estimate, Int64
    field :start_time, Time
    field :finish_time, Time
    field :progress, Int32
    field :splits, String
    field :current_split, Int32

    belongs_to :team, Team
    belongs_to :runner, Runner
    belongs_to :game, Game
  end

  def initialize(runner : Runner, game : Game, @schedule_number, @estimate)
    self.runner = runner
    self.team_id = runner.team_id
    self.game = game
  end

  def splits_json
    @splits_json ||= JSON.parse(self.splits.not_nil!)
  end

  def elapsed_time(as_of=Time.new)
    if start = start_time
      (as_of - start).total_seconds
    else
      0
    end
  end

  def finished?
    !!finish_time
  end

  # Returns true if the run has started, but not yet finished.
  def in_progress?
    !!start_time && !finish_time
  end

  def to_h
    {
      id: id,
      schedule_number: schedule_number,
      estimate: estimate,
      start_time: start_time,
      finish_time: finish_time,
      elapsed_time: elapsed_time,
      progress: progress,
      in_progress: in_progress?,
      finished: finished?,
      splits: splits_json,
      current_split: current_split
    }
  end

  def to_json
    to_h.to_json
  end

  def to_json(io : IO)
    io << to_json
  end
end
