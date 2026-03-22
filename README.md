# Pareto Analysis: Customer Revenue Insights

## Objective
Analyze customer revenue distribution to identify high value customers and uncover business opportunities across markets.

---

## Key Insights

- **80% of revenue comes from 57% of customers**  
  Revenue is highly concentrated among a subset of customers.

- **Top customers generate x3 more revenue per customer than the rest**  
  Significant value gap between customer segments.

- **Spain and the UK have fewer customers but higher revenue per customer than the US**  
  Smaller markets can outperform larger ones in customer value.

- **France leads in both total revenue and average revenue per customer**  
  Indicates a strong and well optimized market.

---

## Business Recommendations

- **Prioritize retention of top customers**  
  Since 80% of revenue depends on this group, reducing churn is critical for revenue stability.

- **Investigate high-value markets (Spain, UK)**  
  Analyze customer behavior, product mix, and pricing strategies to understand what drives higher revenue per customer.

- **Use France as a benchmark market**  
  Identify successful patterns (customer segments, offerings, pricing) and replicate them in other regions.

- **Shift strategy from volume to value**  
  Focus on high-value customer segments instead of scaling customer count alone.

- **Adopt market-specific strategies**  
  Different countries show different value patterns, suggesting that a one-size-fits-all approach may not be optimal.

---

## Tools Used

- **SQL (BigQuery)**  
  - CTEs
  - Window functions  
  - Pareto analysis logic

- **Power BI**  
  - Interactive dashboard  
  - Data visualization (Pareto chart, segmentation, country comparison, detailed data table)

---

## How to Reproduce This Project

### 1. Download the Dataset
- Navigate to the `Dataset/` folder
- Use:
  - `Raw_Dataset/pet_shop_sales.csv` (raw data)
  - or pre-processed files in `Dashboard_Dataset/`

---

### 2. Run SQL Queries (BigQuery)

- Open BigQuery
- Upload the dataset or create a table from CSV
- Run queries in the `SQL/` folder in order:

  1. `CTE_Headline_Insight.sql`
  2. `CTE_Top_Customer_List.sql`
  3. `CTE_Segement_Comparison.sql`
  4. `CTE_Country_Concentration.sql`

---

### 3. Open Power BI Dashboard

- Open file:
 - `Dashboard/Pareto_Dashboard.pbix`
 
- If needed:
- Reconnect data source to your local CSV files
- Refresh data

---

### 4. Explore the Dashboard

The dashboard includes:
- Pareto analysis (revenue concentration)
- Customer segmentation
- Country-level comparison
- Detailed data table
---

## Notes

- The dataset used is a simplified sample for demonstration purposes
- All transformations are done using SQL (no manual preprocessing)