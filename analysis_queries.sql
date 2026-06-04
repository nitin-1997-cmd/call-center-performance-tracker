CREATE DATABASE Call_center_db;
USE call_center_db;
CREATE TABLE call_logs (
    call_id       VARCHAR(10)  PRIMARY KEY,
    call_date     DATE,
    agent_id      VARCHAR(10),
    agent_name    VARCHAR(50),
    team          VARCHAR(20),
    call_type     VARCHAR(20),
    call_outcome  VARCHAR(20),
    aht_seconds   INT,
    csat_score    FLOAT,
    fcr           VARCHAR(5),
    attendance    VARCHAR(10)
);