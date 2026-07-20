-- ============================================================
-- CALL CENTER PERFORMANCE TRACKER
-- Author: Nittin Kumar
-- Tool: MySQL Workbench 8.0
-- Description: Business analysis queries on call center data
-- ============================================================

-- STEP 1: Create Database and Table
-- ============================================================

CREATE DATABASE IF NOT EXISTS call_center_db;
USE call_center_db;

DROP TABLE IF EXISTS call_logs;

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

-- After creating table, import call_center_data.csv using:
-- Table Data Import Wizard in MySQL Workbench (right-click table > Import Wizard)


-- ============================================================
-- QUERY 1: Overall Call Volume & Outcome Summary
-- Business Question: How are calls distributed by outcome?
-- ============================================================

SELECT
    call_outcome,
    COUNT(*)                                    AS total_calls,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS outcome_percentage
FROM call_logs
GROUP BY call_outcome
ORDER BY total_calls DESC;


-- ============================================================
-- QUERY 2: Agent-Level KPI Scorecard
-- Business Question: Which agents are top/bottom performers?
-- ============================================================

SELECT
    agent_id,
    agent_name,
    team,
    COUNT(*)                                            AS total_calls,
    ROUND(AVG(aht_seconds) / 60, 2)                    AS avg_aht_minutes,
    ROUND(AVG(csat_score), 2)                          AS avg_csat,
    SUM(CASE WHEN fcr = 'Yes' THEN 1 ELSE 0 END)       AS fcr_count,
    ROUND(SUM(CASE WHEN fcr = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fcr_rate_pct,
    SUM(CASE WHEN attendance = 'Absent' THEN 1 ELSE 0 END) AS absent_days
FROM call_logs
GROUP BY agent_id, agent_name, team
ORDER BY avg_csat DESC;


-- ============================================================
-- QUERY 3: Monthly Call Trend
-- Business Question: How does call volume change month over month?
-- ============================================================

SELECT
    DATE_FORMAT(call_date, '%Y-%m')             AS month,
    COUNT(*)                                    AS total_calls,
    SUM(CASE WHEN call_outcome = 'Resolved'  THEN 1 ELSE 0 END) AS resolved,
    SUM(CASE WHEN call_outcome = 'Escalated' THEN 1 ELSE 0 END) AS escalated,
    SUM(CASE WHEN call_outcome = 'Abandoned' THEN 1 ELSE 0 END) AS abandoned,
    ROUND(AVG(csat_score), 2)                  AS avg_csat
FROM call_logs
GROUP BY DATE_FORMAT(call_date, '%Y-%m')
ORDER BY month;


-- ============================================================
-- QUERY 4: Team Performance Comparison
-- Business Question: Which team has the best performance metrics?
-- ============================================================

SELECT
    team,
    COUNT(*)                                            AS total_calls,
    ROUND(AVG(aht_seconds) / 60, 2)                    AS avg_aht_minutes,
    ROUND(AVG(csat_score), 2)                          AS avg_csat,
    ROUND(SUM(CASE WHEN fcr = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fcr_rate_pct,
    ROUND(SUM(CASE WHEN call_outcome = 'Escalated' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS escalation_rate_pct
FROM call_logs
GROUP BY team
ORDER BY avg_csat DESC;


-- ============================================================
-- QUERY 5: CSAT Score Distribution
-- Business Question: What % of customers are highly satisfied (4-5)?
-- ============================================================

SELECT
    csat_score,
    COUNT(*)                                            AS total_responses,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM call_logs
WHERE csat_score IS NOT NULL AND csat_score != ''
GROUP BY csat_score
ORDER BY csat_score DESC;


-- ============================================================
-- QUERY 6: Attendance Impact on Performance
-- Business Question: Does attendance affect agent CSAT and FCR?
-- ============================================================

SELECT
    attendance,
    COUNT(*)                                            AS total_records,
    ROUND(AVG(csat_score), 2)                          AS avg_csat,
    ROUND(AVG(aht_seconds) / 60, 2)                    AS avg_aht_minutes,
    ROUND(SUM(CASE WHEN fcr = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fcr_rate_pct
FROM call_logs
GROUP BY attendance
ORDER BY avg_csat DESC;


-- ============================================================
-- QUERY 7 (BONUS): Top 3 Agents per Team by CSAT
-- Business Question: Who are the star performers in each team?
-- ============================================================

WITH agent_csat AS (
    SELECT
        team,
        agent_name,
        ROUND(AVG(csat_score), 2)  AS avg_csat,
        COUNT(*)                    AS total_calls,
        RANK() OVER (PARTITION BY team ORDER BY AVG(csat_score) DESC) AS rnk
    FROM call_logs
    WHERE csat_score IS NOT NULL AND csat_score != ''
    GROUP BY team, agent_name
)
SELECT team, agent_name, avg_csat, total_calls
FROM agent_csat
WHERE rnk <= 3
ORDER BY team, rnk;
