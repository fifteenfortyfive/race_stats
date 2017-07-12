// This is dumb, but it works for now :)
// July 14th at 9:00pm UTC
let epoch = "2017-07-14T21:00:00.000Z";
let race_start_time = moment.utc(epoch);

function attempt_timer_start() {
  if(moment() >= race_start_time) {
    document.querySelector(".race-info .timer .timer-time").classList.add("updated-timer");
    document.querySelector(".race-info .timer .timer-time").dataset.started_at = race_start_time.unix();
  } else {
    setTimeout(attempt_timer_start, 2000);
  }
}

attempt_timer_start();
