SELECT
	TO_CHAR(DATE_TRUNC('month', order_date), 'FMMONTH YYYY') AS MONTH,
	SUM(sales) AS Sales
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date);
/*
Running Total of Sales Over Time:
- CTE (salesOverTime): Aggregates total sales for each month.
- DATE_TRUNC('month', ...): Groups orders by month and year.
- TO_CHAR(): Formats dates as readable month-year labels.
- SUM(Sales) OVER (ORDER BY month_date): Calculates cumulative
  sales by adding each month's sales to all previous months.
- GROUP BY combines individual orders into monthly totals.
- OVER() calculates a running total across those monthly rows
- without collapsing them into fewer rows.- Running total continues across years without resetting.
*/

WITH salesOverTime AS (
	SELECT
		TO_CHAR(DATE_TRUNC('month', order_date), 'FMMONTH YYYY') AS MONTH,
		DATE_TRUNC('month', order_date) AS month_date,
		SUM(sales) as Sales
	FROM orders
	GROUP BY DATE_TRUNC('month', order_date), month_date
)
SELECT
	MONTH,
	SUM(Sales) OVER (ORDER BY month_date)
FROM salesOverTime;