-- +micrate Up
CREATE TABLE runners (
  id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  team_id INTEGER NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE games (
  id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  series VARCHAR(16) NOT NULL,
  -- progress_unit is the unit of completion for the game. For most games,
  -- this will be `%`. For mario games, it will be `Stars`, or `Shines`
  -- for Sunshine.
  progress_unit VARCHAR(16) NOT NULL,
  -- progress_max is the target completion for a game. For Spyro 1, this will
  -- be `100`. For SM64, this will be 120.
  progress_max INTEGER NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE teams (
  id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE runs (
  team_id INTEGER NOT NULL,
  runner_id INTEGER NOT NULL,
  game_id INTEGER NOT NULL,
  -- schedule_number is used for ordering runs on a team. A schedule_number
  -- of `6` means it is the 6th game the team will run.
  schedule_number INTEGER NOT NULL,
  -- Crecto doesn't directly support `timespan` types, so times are stored
  -- as an integer number of seconds.
  time INTEGER DEFAULT NULL,
  estimate INTEGER NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE SEQUENCE runners_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

ALTER SEQUENCE runners_id_seq OWNED BY runners.id;
ALTER TABLE ONLY runners ADD CONSTRAINT runners_pkey PRIMARY KEY (id);
ALTER TABLE ONLY runners ALTER COLUMN id SET DEFAULT nextval('runners_id_seq'::regclass);
CREATE UNIQUE INDEX runners_4ijlkjdf ON runners (id);

CREATE SEQUENCE games_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

ALTER SEQUENCE games_id_seq OWNED BY games.id;
ALTER TABLE ONLY games ADD CONSTRAINT games_pkey PRIMARY KEY (id);
ALTER TABLE ONLY games ALTER COLUMN id SET DEFAULT nextval('games_id_seq'::regclass);
CREATE UNIQUE INDEX games_4ijlkjdf ON games (id);

CREATE SEQUENCE teams_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

ALTER SEQUENCE teams_id_seq OWNED BY teams.id;
ALTER TABLE ONLY teams ADD CONSTRAINT teams_pkey PRIMARY KEY (id);
ALTER TABLE ONLY teams ALTER COLUMN id SET DEFAULT nextval('teams_id_seq'::regclass);
CREATE UNIQUE INDEX teams_4ijlkjdf ON teams (id);



-- +micrate Down
DROP TABLE runners;
DROP TABLE games;
DROP TABLE teams;
DROP TABLE runs;
