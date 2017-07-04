let coming_up_container = document.querySelector("#coming_up_container .schedule-elements");
let coming_up_template = document.querySelector("#coming_up_element_template");

// A list of Run objects for runs that are coming up next. These are iterated
// in the "Coming Up" ticker at the bottom of the layout.
let coming_up_list = [];

function shift_displayed_runs() {
  let currently_displayed = coming_up_container.querySelectorAll(".schedule-element");

  // If too few runs remain to display, re-add the current list of runs.
  if(currently_displayed.length <= 3) {
    coming_up_list.forEach(function(run) {
      // Create a new node with the run's content, add it to the DOM, and
      // remember it in the currently-displayed list.
      var element = document.importNode(coming_up_template.content, true);
      element.querySelector(".game-name").innerText = run.game;
      element.querySelector(".runner-name").innerText = run.runner;
      element.querySelector(".team-name").innerText = run.team;
      element.querySelector(".start-time").innerText = run.estimate.fromNow();
      coming_up_container.appendChild(element);
    });
  }


  // Pop the front of the list to fade out the most recent run.
  let run_to_pop = coming_up_container.querySelectorAll(".schedule-element")[0];

  if(run_to_pop) {
    // Fade out the existing nodes
    run_to_pop.classList.add("fade");
    coming_up_container.classList.add("tickerSlideLeft");
    setTimeout(function() {
      run_to_pop.remove();
      coming_up_container.classList.remove("tickerSlideLeft");
    }, 1200);
  }
}


function update_coming_up_list() {
  nanoajax.ajax({ url: '/api/coming_up', method: 'GET' }, function(code, response) {
    let json_response = JSON.parse(response);
    let new_runs_list = [];
    json_response.forEach(function(run) {
      run.estimate = moment.unix(run.estimate);
      new_runs_list.push(run);
    });

    // Replace the coming_up_list entirely.
    coming_up_list = new_runs_list;

    shift_displayed_runs();
  });
};

update_coming_up_list();
// Update the "coming up" list once per minute
setInterval(update_coming_up_list, 60*1000);
// Shift the "Coming Up" ticker every 10 seconds.
setInterval(shift_displayed_runs, 10000);
