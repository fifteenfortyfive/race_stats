function create_action(text, action, run_id) {
  let element = document.createElement("button");
  element.innerText = text;
  element.setAttribute('data-action', action);
  element.setAttribute('data-run', run_id);
  return element;
}

class RunnerScreen {
  constructor(runner_container) {
    this.container = runner_container;
    this.container.addEventListener('click', this.intercept_click.bind(this));
    let base_uri = ((window.location.protocol === "https:") ? "wss://" : "ws://") + window.location.host;
    this.socket = new WebSocket(base_uri + "/runner");
    this.socket.onmessage = this.update_runs.bind(this);
  }

  intercept_click(e) {
    let target = e.target || e.srcElement;
    if (target.tagName === 'BUTTON') {
      let run_id = target.getAttribute('data-run');
      let action = target.getAttribute('data-action');

      this.socket.send(JSON.stringify({ action: action, run_id: run_id }));
      //tell the browser not to respond to the link click
      e.preventDefault();
    }
  }

  update_runs(runs) {
    function do_update(run) {
      let run_element = document.querySelector(`#run${run.id}`);
      // Update run actions
      let run_actions = run_element.querySelector(".run-actions");
      run_actions.innerHTML = '';
      if(!run.start_time) {
        run_actions.appendChild(create_action("Start run", 'start', run.id));
      }

      if(run.start_time && !run.finish_time) {
        run_actions.appendChild(create_action("Add progress", 'increment_progress', run.id));
        run_actions.appendChild(create_action("Remove progress", 'decrement_progress', run.id));
        run_actions.appendChild(create_action("Finish run", 'finish', run.id));
      }

      run_element.querySelector(".progress-current").innerText = run.progress;

      run_element.querySelector(".current-time").innerText = moment.duration(run.elapsed_time, 's').format("hh:mm:ss", { trim: false });
      if(run.in_progress) {
        run_element.querySelector(".current-time").classList.add('updated-timer');
      } else {
        run_element.querySelector(".current-time").classList.remove('updated-timer');
      }
    };

    if(runs instanceof MessageEvent) {
      console.log(JSON.parse(runs.data));
      do_update(JSON.parse(runs.data));
    } else if(Array.isArray(runs)) {
      runs.forEach(do_update);
    } else {
      do_update(runs);
    }
  }
};


