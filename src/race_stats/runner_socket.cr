require "http"

class RunnerSocket
  property socket

  def initialize(@socket : HTTP::WebSocket)
    @socket.on_message do |msg|
      handle_message(JSON.parse(msg))
    end
  end

  def handle_message(msg : JSON::Any)
    case msg["action"]
    when "start"
      run = Repo.get!(Run, msg["run_id"].to_s)
      run.start_time = Time.now
      Repo.update(run)

      @socket.send(run.to_json.to_s)
      # Update the stats screen as well to start this run's timer.
      SocketManager.update_listeners
      LogEvent.log("run_start", "run ##{run.id} started", run)

    when "finish"
      run = Repo.get!(Run, msg["run_id"].to_s)
      run.finish_time = Time.now
      Repo.update(run)
      team = Repo.get_association!(run, :team).as(Team)
      team.current_run = run.schedule_number.not_nil! + 1
      Repo.update(team)

      @socket.send(run.to_json.to_s)
      # Update the stats screen to show the new active run.
      SocketManager.update_listeners
      LogEvent.log("run_finish", "run ##{run.id} finished", run)

    when "reset"
      run = Repo.get!(Run, msg["run_id"].to_s)
      run.start_time = nil
      run.finish_time = nil
      run.progress = 0
      run.current_split = 0
      Repo.update(run)

      @socket.send(run.to_json.to_s)
      # Update the stats screen to show the new active run.
      SocketManager.update_listeners
      LogEvent.log("run_reset", "run ##{run.id} reset", run)

    when "set_as_current_run"
      run = Repo.get!(Run, msg["run_id"].to_s)
      team = Repo.get_association!(run, :team).as(Team)
      team.current_run = Math.min(run.schedule_number.not_nil!, 13)
      Repo.update(team)

      @socket.send(run.to_json.to_s)
      # Update the stats screen to show the new active run.
      SocketManager.update_listeners
      LogEvent.log("run_set_current", "run ##{run.id} set as current run", run)

    when "split"
      run = Repo.get!(Run, msg["run_id"].to_s, Query.preload(:game))
      run.current_split = Math.min(run.current_split.not_nil! + 1, run.splits_json.to_a.size)
      run.progress = ((run.current_split.not_nil!.to_f / run.splits_json.to_a.size) * run.game.progress_max.not_nil!).to_i
      puts run.current_split
      Repo.update(run)

      @socket.send(run.to_json.to_s)
      # Update the stats screen to show the new active run.
      SocketManager.update_listeners

    when "unsplit"
      run = Repo.get!(Run, msg["run_id"].to_s, Query.preload(:game))
      run.current_split = Math.max(run.current_split.not_nil! - 1, 0)
      run.progress = ((run.current_split.not_nil!.to_f / run.splits_json.to_a.size) * run.game.progress_max.not_nil!).to_i
      Repo.update(run)

      @socket.send(run.to_json.to_s)
      # Update the stats screen to show the new active run.
      SocketManager.update_listeners

    when "update_splits"
      run = Repo.get!(Run, msg["run_id"].to_s, Query.preload(:game))
      run.splits = msg["splits"].to_s.split(',').map(&.strip).to_json
      run.progress = ((run.current_split.not_nil!.to_f / run.splits_json.to_a.size) * run.game.progress_max.not_nil!).to_i
      Repo.update(run)

      @socket.send(run.to_json.to_s)
      SocketManager.update_listeners
      LogEvent.log("run_edited", "run ##{run.id} edited", run)

    when "ping"
      @socket.send("pong")
    end
  end
end
