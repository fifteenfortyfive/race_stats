class OnScreen {
  constructor(video_container, text_container) {
    this.video_container = video_container;
    this.text_container = text_container;

    // Check if a video transition should happen every minute.
    this.on_screen = null;
    this.attempt_transition();
    setInterval(this.attempt_transition.bind(this), 30*1000);
  }

  attempt_transition() {
    let self = this;
    nanoajax.ajax({ url: '/api/on_screen', method: 'GET' }, function(code, response) {
      let old_on_screen = self.on_screen;
      let new_on_screen = JSON.parse(response);
      if(old_on_screen != new_on_screen) {
        self.transition_to(new_on_screen);
      }
    });
  }

  // This will remove the first `schedule-element` from the DOM after the
  // animation completes.
  transition_to(new_on_screen) {
    let self = this;
    let old_video = self.video_container.querySelector("iframe");
    // Create a new video frame to transition to.
    let video_frame = document.createElement('iframe');
    video_frame.src = `http://player.twitch.tv/?channel=${new_on_screen.channel}&muted=true&controls=false`
    video_frame.width = "856";
    video_frame.height = "479";
    video_frame.allowfullscreen = "true";
    video_frame.classList.add("hidden");
    self.video_container.appendChild(video_frame);
    // Create a new description element to transition to
    let old_text = this.text_container.querySelector('.schedule-element');
    let new_text = old_text.cloneNode(true);

    // Wait a while to let the player load before fading to it.
    setTimeout(function() {
      old_video.classList.remove("fadeIn");
      old_video.classList.add("animated");
      old_video.classList.add("fadeOut");

      old_text.classList.remove("fadeIn");
      old_text.classList.add("animated");
      old_text.classList.add("fadeOut");


      setTimeout(function() {
        video_frame.classList.add("animated");
        video_frame.classList.add("fadeIn");
        video_frame.classList.remove("hidden");
        old_video.remove();

        new_text.querySelector('.runner-name').innerText = new_on_screen.runner;
        new_text.querySelector('.game-name').innerText = new_on_screen.game;
        new_text.querySelector('.team-name').innerText = new_on_screen.team;
        new_text.querySelector('.estimate-time').innerText = moment.duration(parseInt(new_on_screen.estimate), 's').format('hh:mm:ss');
        self.text_container.appendChild(new_text);
        new_text.classList.add("animated");
        new_text.classList.add("fadeIn");
        new_text.classList.remove("hidden");
        // Update the `on_screen` reference after the transition has completed.
        old_text.remove();
        self.on_screen = new_on_screen;
      }, 1500);
    }, 4000);
  }
};
