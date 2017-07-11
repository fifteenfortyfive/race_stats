function create_action(text, action, run_id) {
  let element = document.createElement("button");
  element.innerText = text;
  element.setAttribute('data-action', action);
  element.setAttribute('data-run', run_id);
  return element;
};

let split_template = document.querySelector("#split_template");

function create_split_element(split, index) {
  let element = document.importNode(split_template.content, true).firstElementChild;
  element.setAttribute('data-index', 'index');
  element.innerText = split;
  return element;
};

class RunnerScreen {
  constructor(runner_container) {
    this.container = runner_container;
    this.container.addEventListener('click', this.intercept_click.bind(this));
    let base_uri = ((window.location.protocol === "https:") ? "wss://" : "ws://") + window.location.host;
    this.socket = new WebSocket(base_uri + "/runner");
    this.socket.onmessage = this.update_runs.bind(this);
    this.socket.onclose = function() { console.log("closed"); document.querySelector(".socket-connection-lost").classList.remove("hidden"); };
    let self = this;
    // Sockets on heroku die after 55 seconds, so keep it alive by pinging every 30 seconds.
    setInterval(function() {
      self.socket.send('{"action": "ping"}');
    }, 10*1000);
  }

  intercept_click(e) {
    let target = e.target || e.srcElement;
    if (target.tagName === 'BUTTON') {
      let run_id = target.getAttribute('data-run');
      let action = target.getAttribute('data-action');

      if(action == "update_splits") {
        this.socket.send(JSON.stringify({ action: action, run_id: run_id, splits: document.querySelector(`#splits_editor${run_id}`).value }));
      } else {
        this.socket.send(JSON.stringify({ action: action, run_id: run_id }));
      }

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
        if(run.current_split == run.splits.length) {
          run_actions.appendChild(create_action("Finish run", 'finish', run.id));
        } else {
          run_actions.appendChild(create_action("Split", 'split', run.id));
        }
        run_actions.appendChild(create_action("Unsplit", 'unsplit', run.id));
      }

      run_element.querySelector(".progress-current").innerText = run.progress;

      run_element.querySelector(".current-time").innerText = moment.duration(run.elapsed_time, 's').format("hh:mm:ss", { trim: false });
      if(run.in_progress) {
        run_element.querySelector(".current-time").classList.add('updated-timer');
      } else {
        run_element.querySelector(".current-time").classList.remove('updated-timer');
      }

      let splits_container = run_element.querySelector(".splits");
      splits_container.innerHTML = '';
      run.splits.forEach(function(split, index) {
        let split_element = create_split_element(split, index)
        if(index == run.current_split) {
          split_element.classList.add("active");
        }
        splits_container.appendChild(split_element);
      });
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


