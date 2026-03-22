-- NOTE:
-- Replace `pareto_project.pareto_dataset.sales` with your own BigQuery project and dataset

DECLARE target_sales_pct FLOAT64 DEFAULT 0.8;

WITH base_sales AS (
  SELECT
    CustomerID,
    Quantity * UnitPrice AS sales
  FROM `pareto_project.pareto_dataset.sales`
),

customer_sales AS (
  SELECT
    CustomerID,
    SUM(sales) AS customer_revenue
  FROM base_sales
  GROUP BY CustomerID
),

ranked AS (
  SELECT
    CustomerID,
    customer_revenue,
    ROW_NUMBER() OVER (ORDER BY customer_revenue DESC) AS customer_rank,
    COUNT(*) OVER () AS total_customers,
    SUM(customer_revenue) OVER (
      ORDER BY customer_revenue DESC
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cum_revenue,
    SUM(customer_revenue) OVER () AS total_revenue
  FROM customer_sales
),

with_pct AS (
  SELECT
    *,
    cum_revenue / total_revenue AS cum_sales_pct,
    customer_rank / total_customers AS cum_customer_pct
  FROM ranked
)

SELECT
  MIN(customer_rank) AS number_of_customers,
  MIN(total_customers) AS total_customers,
  MIN(cum_revenue) AS cum_revenue,
  MIN(total_revenue) AS total_revenue,
  target_sales_pct * 100 AS target_sales_pct,
  MIN(total_revenue * target_sales_pct) AS target_sales,
  MIN(cum_sales_pct * 100) AS cum_sales_pct,
  MIN(cum_customer_pct * 100) AS cum_customer_pct
FROM with_pct
WHERE cum_sales_pct >= target_sales_pct;