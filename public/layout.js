// The "Coming Up" ticker at the bottom-left
let coming_up_container = document.querySelector("#coming_up_container .schedule-elements");
let coming_up_template = document.querySelector("#coming_up_element_template");
let coming_up = new ComingUp(coming_up_container, coming_up_template);

// The "On Screen" ticker and the video element
let on_screen_video_container = document.querySelector("#video_container");
let on_screen_description_container = document.querySelector("#on_screen_container");
let on_screen = new OnScreen(on_screen_video_container, on_screen_description_container);

// The team stats table on the right of the layout
let teams = new Teams(
  document.querySelector(".layout"),
  document.querySelector("#team_stats_template")
);
