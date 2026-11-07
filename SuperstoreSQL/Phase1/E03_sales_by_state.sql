SELECT
	country_region,
	state,
	SUM(profit) as "Profit",
	SUM(sales) AS "Sales"
FROM orders
GROUP BY country_region, state
ORDER BY country_region, state;