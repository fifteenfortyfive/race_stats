class ComingUp {
  constructor(container, template) {
    this.container = container;
    this.template = template.content;

    // A list of Run objects for runs that are coming up next. These are iterated
    // in the "Coming Up" ticker at the bottom of the layout.
    this.coming_up_list = [];

    this.update_coming_up_list();
    // Update the "coming up" list once per minute
    setInterval(this.update_coming_up_list.bind(this), 60*1000);
    // Shift the "Coming Up" ticker every 10 seconds.
    setInterval(this.iterate.bind(this), 10 * 1000);
  }

  update_coming_up_list() {
    let self = this;
    nanoajax.ajax({ url: '/api/coming_up', method: 'GET' }, function(code, response) {
      let json_response = JSON.parse(response);
      let new_runs_list = [];
      json_response.forEach(function(run) {
        run.start_time = moment.unix(run.start_time);
        new_runs_list.push(run);
      });

      // Replace the coming_up_list entirely.
      self.coming_up_list = new_runs_list;

      self.iterate();
    });
  }

  // Return the list of `schedule-element`s currently in the DOM.
  currently_displayed() {
    return Array.from(this.container.querySelectorAll(".schedule-element"));
  }

  // Create and return a new schedule element from the given run.
  create_element(run) {
    var element = document.importNode(this.template, true);
    element.querySelector(".game-name").innerText = run.game;
    element.querySelector(".runner-name").innerText = run.runner;
    element.querySelector(".team-name").innerText = run.team;
    element.querySelector(".start-time").innerText = run.start_time.fromNow();

    return element;
  }

  // This will remove the first `schedule-element` from the DOM after the
  // animation completes.
  iterate() {
    let self = this;
    // If too few runs remain to display, re-add the current list of runs.
    if(self.currently_displayed().length <= 3) {
      self.coming_up_list.forEach(function(run) {
        let element = self.create_element(run);
        self.container.appendChild(element);
      });
    }

    self.animate_out();
  }

  // Animate moving to the next run.
  animate_out() {
    let self = this;
    // Pop the front of the list to fade out the most recent run.
    let run_to_pop = self.container.querySelectorAll(".schedule-element")[0];

    if(run_to_pop) {
      // Fade out the existing nodes
      run_to_pop.classList.add("fade");
      self.container.classList.add("tickerSlideLeft");
      setTimeout(function() {
        run_to_pop.remove();
        self.container.classList.remove("tickerSlideLeft");
      }, 1200);
    }
  }
};
