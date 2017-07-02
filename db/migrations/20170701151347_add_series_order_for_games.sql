-- +micrate Up
ALTER TABLE games
  ADD sequence_number INTEGER;


-- +micrate Down
ALTER TABLE games
  REMOVE sequence_number;
