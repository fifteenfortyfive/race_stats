-- +micrate Up
ALTER TABLE runners
  ADD twitch_channel VARCHAR(64);

-- +micrate Down
ALTER TABLE runners
  DROP twitch_channel;
