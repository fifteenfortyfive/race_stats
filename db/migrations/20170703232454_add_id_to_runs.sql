-- +micrate Up
CREATE SEQUENCE runs_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;


ALTER TABLE runs
  ADD id INTEGER NOT NULL PRIMARY KEY DEFAULT nextval('runs_id_seq');

ALTER SEQUENCE runs_id_seq OWNED BY runs.id;
CREATE UNIQUE INDEX runs_4ijlkjdf ON runs (id);

-- +micrate Down
ALTER TABLE runs
  DROP id;
