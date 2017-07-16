class Teams {
  constructor(container, template) {
    let base_uri = ((window.location.protocol === "https:") ? "wss://" : "ws://") + window.location.host;
    this.socket = new WebSocket(base_uri + "/teams");

    this.socket.onmessage = function(event) {
      var msg = JSON.parse(event.data);

      switch(msg.type) {
        case "teams_update":
          for(let team_name in msg.teams) {
            let team = msg.teams[team_name];
            let element = container.querySelector(`.team#team${team.team_id}`);
            // If the team does not currently exist in the layout, create one
            // and add it to the DOM.
            if(element == null) {
              element = document.importNode(template.content, true).querySelector('.team');
              element.id = `team${team.team_id}`;
              container.appendChild(element);
            }

            let current_run = team.runs[team.current_run] || team.runs[team.runs.length-1];
            element.querySelector('header .meta .name').innerText = team_name;
            element.querySelector('header .meta .current-game').innerText = current_run.game;
            element.querySelector('header .meta .current-runner').innerText = current_run.runner;

            let time_element = element.querySelector('header .current-run .time');
            time_element.innerText = moment.duration(current_run.time, 'seconds').format("hh:mm:ss", { trim: false });
            if(current_run.in_progress) {
              time_element.classList.add('updated-timer');
            } else {
              time_element.classList.remove('updated-timer');
            }
            element.querySelector('header .current-run .progress .progress-current').innerText = current_run.progress;
            element.querySelector('header .current-run .progress .progress-target').innerText = current_run.progress_target;

            for(let run_number in team.runs) {
              let run = team.runs[run_number];
              element.querySelector(`footer .games-table .game.${run.game_id} .game-time`).innerText = moment.duration(run.time, 'seconds').format("h:mm:ss", { trim: false });
              if(run.finished) {
                element.querySelector(`footer .games-table .game.${run.game_id}`).classList.add('finished');
              } else {
                element.querySelector(`footer .games-table .game.${run.game_id}`).classList.remove('finished');
              }
            }
          }

          break;
      }
    };
  }
}
