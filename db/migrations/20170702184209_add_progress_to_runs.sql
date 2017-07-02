-- +micrate Up
ALTER TABLE runs
  ADD progress INTEGER NOT NULL DEFAULT 0;

-- +micrate Down
ALTER TABLE runs
  DROP progress;
