CREATE TABLE "user" (
    user_id CHAR(64) PRIMARY KEY,
    name    TEXT     NOT NULL,
    credit  TEXT     DEFAULT 0,

);


CREATE TABLE hash_text (
    hash CHAR(64) PRIMARY KEY,
    text TEXT
);