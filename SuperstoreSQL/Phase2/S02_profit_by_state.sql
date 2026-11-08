SELECT
	state,
	SUM(profit) AS Profit,
	SUM(sales) AS Sales
FROM orders
WHERE country_region = 'United States'
GROUP BY state;

