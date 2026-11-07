-- Chart E02: Sales & Profit by Category
-- Which category brings in the most sales, and is it also the most profitable?
-- Office Supplies bring in the most sales, but technology gives us a higher profit. The profit margin for Office supplies and Technology is close - 17.22 and 17.45 respectively
-- The average order value for office supplies is the lowest. While for technology it is the highest
SELECT
	category,
	ROUND(SUM(sales), 2) as total_sales,
	ROUND(SUM(profit), 2) as total_profit,
	round(100*(SUM(profit)/SUM(sales)), 2) AS "Profit Margin Percentage",
	round(SUM(sales)/COUNT(DISTINCT order_id), 2) AS "Average Order Value"
FROM orders
GROUP BY category
ORDER BY total_sales;