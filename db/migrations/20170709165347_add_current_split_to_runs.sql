-- +micrate Up
ALTER TABLE runs
  ADD current_split INTEGER NOT NULL DEFAULT 0;

-- +micrate Down
ALTER TABLE runs
  DROP current_split;
