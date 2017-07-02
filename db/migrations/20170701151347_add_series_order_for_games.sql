-- +micrate Up
ALTER TABLE games
  ADD sequence_number INTEGER;


-- +micrate Down
ALTER TABLE games
  DROP sequence_number;
