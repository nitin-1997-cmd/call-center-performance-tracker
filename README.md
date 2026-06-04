# 📞 Call Center Performance Tracker

A end-to-end data analytics project analyzing call center operations using SQL, Excel, and Power BI.

---

## 📌 Project Overview

This project simulates a real-world call center analytics scenario where I analyzed 500 call records to uncover performance insights across agents, teams, and time periods.

The goal was to answer key business questions that a Call Center Manager or Business Analyst would ask daily:

- Which agents are performing best?
- What percentage of calls are being resolved?
- How does call volume trend month over month?
- Does attendance impact agent performance?

---

## 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| MySQL 8.0 | Data storage and SQL analysis |
| Excel | Data cleaning and dashboard |
| Power BI | Interactive visual dashboard |

---

## 📁 Project Structure

```
call-center-performance-tracker/
│
├── data/
│   └── call_center_data.csv        # Raw dataset (500 records)
│
├── sql/
│   └── analysis_queries.sql        # All 6 business analysis queries
│
├── excel/
│   └── call_center_dashboard.xlsx  # Excel dashboard with 3 charts
│
├── powerbi/
│   └── call_center_dashboard.pbix  # Interactive Power BI dashboard
│
└── README.md
```

---

## 📊 Dataset Description

The dataset contains 500 call records with the following columns:

| Column | Description |
|--------|-------------|
| call_id | Unique identifier for each call |
| call_date | Date of the call |
| agent_id | Unique agent code |
| agent_name | Name of the agent |
| team | Team the agent belongs to (A, B, C) |
| call_type | Inbound or Outbound |
| call_outcome | Resolved / Escalated / Callback / Abandoned |
| aht_seconds | Average Handle Time in seconds |
| csat_score | Customer Satisfaction Score (1-5) |
| fcr | First Call Resolution (Yes/No) |
| attendance | Present / Absent / Late |

---

## 🔍 SQL Analysis — Business Questions & Insights

### Query 1 — Call Outcome Summary
**Business Question:** How are calls distributed by outcome?

**Key Finding:** 58.6% of calls were Resolved, while 8.4% were Abandoned — indicating potential issues with wait times or IVR experience.

### Query 2 — Agent Performance Scorecard
**Business Question:** Which agents are top and bottom performers?

**Key Finding:** Amit Sharma was the top performer with highest CSAT of 4.03 and lowest handle time of 4.22 minutes. Neha Patel had the lowest CSAT of 3.41 — indicating a coaching opportunity.

### Query 3 — Monthly Call Trend
**Business Question:** How does call volume change month over month?

**Key Finding:** Call volume peaked in May and December suggesting seasonal patterns. September had the highest customer satisfaction score.

### Query 4 — Team Performance Comparison
**Business Question:** Which team delivers the best performance?

**Key Finding:** Team C had the highest CSAT score and lowest escalation rate — suggesting better training and stronger problem solving skills.

### Query 5 — CSAT Score Distribution
**Business Question:** How satisfied are customers overall?

**Key Finding:** 66.37% of customers rated 4 or 5 (satisfied to very satisfied). However 15.72% gave ratings of 1 or 2 — these unhappy customers need immediate attention.

### Query 6 — Attendance Impact on Performance
**Business Question:** Does attendance affect agent performance?

**Key Finding:** Present agents consistently showed higher CSAT scores compared to late or absent agents — confirming that attendance directly impacts service quality.

---

## 📈 Dashboards

### Excel Dashboard
- Call Outcome Distribution (Pie Chart)
- Monthly Call Volume Trend (Line Chart)
- Agent CSAT Comparison (Bar Chart)

### Power BI Dashboard
- Interactive dashboard with Team slicer
- All charts filter dynamically when a team is selected
- KPI Card showing total call volume

---

## 💡 Key Business Recommendations

1. **Reduce Abandoned Calls** — 8.4% abandonment rate needs investigation into wait times and IVR flow
2. **Coach Low Performers** — Agents with CSAT below 3.7 should receive targeted training
3. **Improve Attendance** — Attendance directly impacts CSAT — implement attendance incentives
4. **Replicate Team C's Approach** — Team C's best practices should be shared across Teams A and B

---

## 👤 Author

**Nittin Kumar**
- Aspiring Data Analyst | Business Analyst
- [LinkedIn](https://linkedin.com/in/nittinkumar)
- [GitHub](https://github.com/nittin-kumar-analyst)
