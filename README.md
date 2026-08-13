# customer_churn_analysis
# 📊 Customer Churn & Revenue Loss Analytics Engine

![Python](https://img.shields.io/badge/Python-3.11+-blue.svg)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15.0-blue.svg)
![Tableau](https://img.shields.io/badge/Tableau-Public-orange.svg)

An end-to-end business intelligence pipeline analyzing **7,043 customer accounts** to identify churn drivers, map **$139.1K in Monthly Recurring Revenue (MRR) loss**, and isolate targeted customer retention cohorts.

---

## 🔗 Interactive Dashboard
👉 **[View Live Tableau Public Dashboard] https://public.tableau.com/app/profile/akhil.cheeransanthosh/viz/customerchurndashbaord/Dashboard2?publish=yes

---

## 💡 Executive Summary & Business Insights

* **Overall Churn Metric:** Baseline churn rate sits at **26.54%**, representing **$139,130.85 in lost MRR** every month.
* **The "Churn Cliff":** Customers on **Month-to-month contracts in their first 6 months (0–6 Mos)** account for **$49.6K in monthly revenue loss alone** (55.2% cohort churn rate).
* **Product Friction:** **Fiber Optic subscribers without Tech Support** represent the highest absolute churn volume, indicating potential service expectation gaps or price sensitivity.
* **Product Stickiness:** Cross-selling add-on services drastically increases retention—customers subscribing to **7+ add-on products exhibit churn rates under 12%**, compared to 32%+ for single-service users.

---

## 🛠️ Technical Pipeline Architecture

```text
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│ Python (Pandas) │ ──> │ PostgreSQL (SQL) │ ──> │ Tableau Public  │
│ Clean & Feature │     │ Business Queries │     │   Executive     │
│   Engineering   │     │  & Window Funcs  │     │   Dashboard     │
└─────────────────┘     └──────────────────┘     └─────────────────┘
```

### 1. Data Prep & Feature Engineering (`notebooks/01_data_cleaning_eda.ipynb`)
* Fixed **11 hidden string whitespace nulls** in `TotalCharges` and converted column from `str` to `float64`.
* Standardized 21 column headers to database-friendly `snake_case`.
* Engineered 3 analytical features:
  * `tenure_cohort`: Discrete tenure windows (`0-6 Mos`, `6-12 Mos`, etc.).
  * `service_count`: Composite product stickiness score (`0` to `8`).
  * `risk_segment`: Operational risk classification (`High Risk`, `Medium Risk`, `Low Risk`).

### 2. Database Analytics (`sql/churn_queries.sql`)
* Created temporary **Common Table Expressions (CTEs)** to aggregate lost MRR across tenure cohorts.
* Utilized **Window Functions (`DENSE_RANK()`)** to identify top 10 highest-value active accounts at immediate churn risk.

---

## 📂 Repository Setup & Execution

1. **Clone Repository:**
   ```bash
   git clone [https://github.com/YOUR_USERNAME/customer-churn-analytics.git](https://github.com/YOUR_USERNAME/customer-churn-analytics.git)
   cd customer-churn-analytics
   ```

2. **Install Dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

3. **Run Pipeline:**
   * Execute Jupyter Notebook: `notebooks/01_data_cleaning_eda.ipynb`
   * Load SQL script into PostgreSQL: `sql/churn_queries.sql`
