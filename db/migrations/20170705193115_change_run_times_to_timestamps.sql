-- +micrate Up
ALTER TABLE runs
  DROP start_time,
  DROP finish_time,
  ADD start_time TIMESTAMP,
  ADD finish_time TIMESTAMP;

-- +micrate Down
ALTER TABLE runs
  DROP start_time,
  DROP finish_time,
  ADD start_time INTEGER,
  ADD finish_time INTEGER;
