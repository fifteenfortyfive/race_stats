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
      let old_video = self.on_screen;
      let new_video = JSON.parse(response);
      if(old_video != new_video) {
        self.transition_to(new_video);
      }
    });
  }

  // This will remove the first `schedule-element` from the DOM after the
  // animation completes.
  transition_to(new_video) {
    let self = this;
    let old_video = self.video_container.querySelector("iframe");
    // Create a new video frame to transition to.
    let video_frame = document.createElement('iframe');
    video_frame.src = `http://player.twitch.tv/?channel=${new_video.channel}&muted=true&controls=false`
    video_frame.width = "856";
    video_frame.height = "479";
    video_frame.allowfullscreen = "true";
    video_frame.classList.add("hidden");
    self.video_container.appendChild(video_frame);

    // Wait a while to let the player load before fading to it.
    setTimeout(function() {
      old_video.classList.remove("fadeIn");
      old_video.classList.add("animated");
      old_video.classList.add("fadeOut");
      video_frame.classList.add("animated");
      video_frame.classList.add("fadeIn");
      video_frame.classList.remove("hidden");

      setTimeout(function() {
        old_video.remove();
        // Update the `on_screen` reference after the transition has completed.
        self.on_screen = new_video;
      }, 1500);
    }, 4000);
  }
};
