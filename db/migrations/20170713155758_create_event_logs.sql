-- +micrate Up
CREATE TABLE event_logs (
  occurred_at TIMESTAMP PRIMARY KEY,
  message TEXT NOT NULL,
  type VARCHAR(32),
  reference_id INTEGER,
  reference_type VARCHAR(32)
);


-- +micrate Down
DROP TABLE event_logs;
