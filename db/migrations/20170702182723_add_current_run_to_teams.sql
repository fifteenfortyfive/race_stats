-- +micrate Up
ALTER TABLE teams
  ADD current_run INTEGER;

-- +micrate Down
ALTER TABLE games
  DROP current_run;
