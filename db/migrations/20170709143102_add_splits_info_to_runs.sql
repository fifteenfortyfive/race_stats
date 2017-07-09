-- +micrate Up
ALTER TABLE runs
  ADD splits TEXT;

ALTER TABLE games
  ADD default_splits TEXT;


-- +micrate Down
ALTER TABLE runs
  DROP splits;


ALTER TABLE games
  DROP default_splits;
