class Run < Crecto::Model
  schema "runs" do
    field :schedule_number, Int32
    field :estimate, Int64
    field :start_time, Time
    field :finish_time, Time
    field :progress, Int32

    belongs_to :team, Team
    belongs_to :runner, Runner
    belongs_to :game, Game
  end

  def initialize(runner : Runner, game : Game, @schedule_number, @estimate)
    self.runner = runner
    self.team_id = runner.team_id
    self.game = game
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
end
