function increment_timers() {
  [].forEach.call(document.querySelectorAll(".updated-timer"), function(timer) {
    previous_time = moment.duration(timer.innerText);
    timer.innerText = previous_time.add(1, 's').format("hh:mm:ss", { trim: false });
  });
}

setInterval(increment_timers, 1000);
