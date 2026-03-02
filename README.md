# 👥 HR Attrition Analysis — SQL + Power BI

> **Business question:** What drives employee attrition — and which segments are highest risk?

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-blue?logo=postgresql)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow?logo=powerbi)
![Dataset](https://img.shields.io/badge/dataset-IBM%20HR%20Analytics-lightgrey)
![Status](https://img.shields.io/badge/status-completed-brightgreen)

---

## 📌 Project Overview

Employee attrition is one of the most costly HR challenges — replacing a single employee can cost **50–200% of their annual salary**.

This project analyzes the **IBM HR Analytics dataset** (1,470 employees) to identify the key drivers of attrition and provide actionable retention recommendations.

**Analysis approach:** SQL for data extraction & KPI computation → Power BI for interactive dashboards → PDF report for stakeholders.

---

## 🔑 Key Findings

| Factor | Finding |
|--------|---------|
| **Overall attrition rate** | ~16% (237 of 1,470 employees) |
| **Highest risk department** | Sales — highest attrition share |
| **Age group** | 25–35 most likely to leave |
| **Overtime** | Employees working overtime: significantly higher attrition |
| **Job satisfaction** | Low satisfaction (1–2) → 3x higher attrition vs high (3–4) |
| **Years at company** | Spike at 1 year — early-tenure risk |

---

## 💡 Recommendations

1. **Target Sales department** — investigate workload, compensation, growth path
2. **Reduce overtime dependency** — high overtime is a strong attrition predictor
3. **30/60/90-day onboarding program** — address the 1-year tenure spike
4. **Job satisfaction surveys** — early detection for low-satisfaction employees
5. **Career path clarity for 25–35 age group** — growth opportunities reduce churn

---

## 📊 Dashboard (Power BI)

Interactive dashboard covering:
- Overall attrition rate & trend
- Attrition by department, age, job role
- Overtime vs attrition correlation
- Job satisfaction breakdown

📄 Full analysis: [`Report HR attrition.pdf`](./Report%20HR%20attrition.pdf)

---

## 📁 Project Structure
```
hr-attrition-analysis/
├── hrattrition.sql                      # SQL queries — EDA & KPI analysis
├── HR Analytics Dashboard.pbix          # Power BI dashboard
├── Report HR attrition.pdf              # Full analysis report
├── WA_Fn-UseC_-HR-Employee-Attrition.csv # Source dataset (IBM)
└── README.md
```

---

## ⚙️ How to Run
```bash
# 1. Load dataset into PostgreSQL
# Import WA_Fn-UseC_-HR-Employee-Attrition.csv

# 2. Run SQL analysis
psql -U your_user -d your_db -f hrattrition.sql

# 3. Open dashboard
# Open HR Analytics Dashboard.pbix in Power BI Desktop
```

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| SQL (PostgreSQL) | Data extraction, cleaning, KPI queries |
| Power BI | Interactive dashboard |
| IBM HR Dataset | 1,470 employees, 35 features |

---

## 👤 Author

**Farruxbek Valijonov** — Analytics Engineer  
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin)](https://www.linkedin.com/in/farrux-valijonov)
[![GitHub](https://img.shields.io/badge/GitHub-farrux05--ai-black?logo=github)](https://github.com/farrux05-ai)
