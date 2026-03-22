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
),

threshold_row AS (
  SELECT
    MIN(customer_rank) AS threshold_rank
  FROM with_pct
  WHERE cum_sales_pct >= target_sales_pct
)

SELECT
  w.CustomerID,
  w.customer_rank,
  w.customer_revenue,
  ROUND(w.cum_revenue, 2) AS cum_revenue,
  ROUND(w.total_revenue, 2) AS total_revenue,
  ROUND(w.cum_sales_pct * 100, 2) AS cum_sales_pct,
  ROUND(w.cum_customer_pct * 100, 2) AS cum_customer_pct
FROM with_pct w
CROSS JOIN threshold_row t
WHERE w.customer_rank <= t.threshold_rank
ORDER BY w.customer_rank;