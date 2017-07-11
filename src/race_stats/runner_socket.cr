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

    when "reset"
      run = Repo.get!(Run, msg["run_id"].to_s)
      run.start_time = nil
      run.finish_time = nil
      run.progress = 0
      run.current_split = 0
      Repo.update(run)
      team = Repo.get_association!(run, :team).as(Team)
      Repo.update(team)

      @socket.send(run.to_json.to_s)
      # Update the stats screen to show the new active run.
      SocketManager.update_listeners

    when "split"
      run = Repo.get!(Run, msg["run_id"].to_s, Query.preload(:game))
      run.current_split = Math.min(run.current_split.not_nil! + 1, run.splits_json.to_a.size)
      if run.game.progress_unit == "%"
        run.progress = ((run.current_split.not_nil!.to_f / run.splits_json.to_a.size) * 100).to_i
      else
        run.progress = run.current_split
      end
      puts run.current_split
      Repo.update(run)

      @socket.send(run.to_json.to_s)
      # Update the stats screen to show the new active run.
      SocketManager.update_listeners

    when "unsplit"
      run = Repo.get!(Run, msg["run_id"].to_s, Query.preload(:game))
      run.current_split = Math.max(run.current_split.not_nil! - 1, 0)
      if run.game.progress_unit == "%"
        run.progress = ((run.current_split.not_nil!.to_f / run.splits_json.to_a.size) * 100).to_i
      else
        run.progress = run.current_split
      end
      Repo.update(run)

      @socket.send(run.to_json.to_s)
      # Update the stats screen to show the new active run.
      SocketManager.update_listeners

    when "update_splits"
      run = Repo.get!(Run, msg["run_id"].to_s, Query.preload(:game))
      run.splits = msg["splits"].to_s.split(',').map(&.strip).to_json
      if run.game.progress_unit == "%"
        run.progress = ((run.current_split.not_nil!.to_f / run.splits_json.to_a.size) * 100).to_i
      else
        run.progress = run.current_split
      end
      Repo.update(run)

      @socket.send(run.to_json.to_s)
      SocketManager.update_listeners
    when "ping"
      @socket.send("pong")
    end
  end
end
