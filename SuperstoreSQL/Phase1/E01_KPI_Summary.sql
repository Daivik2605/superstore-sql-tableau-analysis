select 
	round(SUM(sales),2) AS "Total Sales",
	ROUND(SUM(profit), 2) AS "Total Profit",
	COUNT(DISTINCT order_id) as "Total Order",
	COUNT(DISTINCT cust_id) AS "Total Customers",
	SUM(quantity) AS "Total Quantity",
	round(100*(SUM(profit)/SUM(sales)), 2) AS "Profit Margin Percentage",
	round(SUM(sales)/COUNT(DISTINCT order_id), 2) AS "Average Order Value"
FROM orders;