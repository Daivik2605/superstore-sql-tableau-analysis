SELECT
	TO_CHAR(DATE_TRUNC('month', order_date), 'FMMonth YYYY') AS "Month",
	SUM(Profit) as "Profit",
	SUM(Sales) AS "Sales"
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date);