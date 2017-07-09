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
    when "increment_progress"
      run = Repo.get!(Run, msg["run_id"].to_s)
      run.progress = run.progress.not_nil! + 1
      Repo.update(run)

      @socket.send(run.to_json.to_s)
      # Update the stats screen to show the new active run.
      SocketManager.update_listeners
    when "decrement_progress"
      run = Repo.get!(Run, msg["run_id"].to_s)
      run.progress = run.progress.not_nil! - 1
      Repo.update(run)

      @socket.send(run.to_json.to_s)
      # Update the stats screen to show the new active run.
      SocketManager.update_listeners
    end
  end
end
