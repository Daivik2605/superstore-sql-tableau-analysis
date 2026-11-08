SELECT
	state,
	SUM(profit) AS Profit
FROM orders
GROUP BY state;