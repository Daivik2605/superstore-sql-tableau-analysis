SELECT
	region,
	SUM(Profit) as Profit,
	SUM(Sales) AS Sales
FROM orders
GROUP BY region
Order by Sales;