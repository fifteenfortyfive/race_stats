-- +micrate Up
ALTER TABLE runs
  DROP time,
  ADD start_time INTEGER,
  ADD finish_time INTEGER;


-- +micrate Down
ALTER TABLE runs
  DROP start_time,
  DROP finish_time,
  ADD time INTEGER;
