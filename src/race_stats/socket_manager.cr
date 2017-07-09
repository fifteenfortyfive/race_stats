require "http"

require "pg"
require "crecto"
require "../repo"

module SocketManager
  extend self

  SOCKETS = [] of HTTP::WebSocket

  def add_listener(socket)
    SOCKETS.push(socket)
  end

  def remove_listener(socket)
    SOCKETS.delete(socket)
  end

  def update_listeners
    update_listeners(get_team_statuses)
  end

  def update_listeners(message : String)
    SOCKETS.each do |sock|
      sock.send(message)
    end
  end


  private def get_team_statuses
    runs_by_team = Repo.all(Run, Query.order_by("id ASC"), preload: [:team, :game, :runner]).group_by(&.team)

    JSON.build do |json|
      json.object do
        json.field :type, "teams_update"
        json.field :teams do
          json.object do
            runs_by_team.each do |team, runs|
              json.field team.name do
                json.object do
                  json.field :team_id, team.id
                  json.field :current_run, team.current_run
                  json.field :runs do
                    json.object do
                      runs.each do |run|
                        json.field run.schedule_number do
                          json.object do
                            json.field :game, run.game.name
                            json.field :game_id, run.game.name.not_nil!.downcase.gsub(' ', "")
                            json.field :runner, run.runner.name
                            json.field :time, run.elapsed_time
                            json.field :progress, run.progress
                            json.field :progress_target, run.game.progress_target
                            json.field :finished, run.finished?
                            json.field :in_progress, run.in_progress?
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end


#
spawn do
  loop do
    SocketManager.update_listeners()
    sleep(10)
  end
end
