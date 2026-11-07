/*
This query calculates:
1. Total Sales
2. Total Profit
3. Total Discount
4. Total Quantity

The results are grouped by year.
*/

SELECT
	SUM(sales) AS Sales, 
	SUM(profit) AS Profit,
	SUM(discount) AS Discount,
	SUM(quantity) AS Quantity,
	TO_CHAR(DATE_TRUNC('year', order_date), 'YYYY') as "Year"
FROM orders
GROUP BY TO_CHAR(DATE_TRUNC('year', order_date), 'YYYY')
ORDER BY "Year";


/*
Year-over-Year (YoY) Growth:
Measures the percentage change compared to the previous year.
Formula: ((Current Year - Previous Year) / Previous Year) * 100
2023 returns NULL because no previous year's data exists.

SQL Functions:
- LAG(): Retrieves the previous year's value for comparison.
- NULLIF(x, 0): Prevents division by zero by returning NULL when x = 0.
- ::numeric: Converts integers to numeric values to avoid integer division.
- ROUND(x, 2): Rounds the calculated percentage to 2 decimal places.
Note: Positive YoY indicates growth; negative indicates decline.
SUM(Quantity) returned an integer so we vcase it to numeric to avoid integer division
*/
WITH yearly_data AS (
	SELECT
		SUM(sales) AS Sales, 
		SUM(profit) AS Profit,
		SUM(discount) AS Discount,
		SUM(quantity) AS Quantity,
		TO_CHAR(DATE_TRUNC('year', order_date), 'YYYY') as "Year"
	FROM orders
	GROUP BY TO_CHAR(DATE_TRUNC('year', order_date), 'YYYY')
	ORDER BY "Year"
)
SELECT
	"Year",
	ROUND(((Sales -LAG(Sales) OVER (ORDER BY "Year")) / LAG(Sales) OVER (ORDER BY "Year")) *100, 2) AS "YoY Sales%",
	ROUND(((Profit-LAG(Profit) OVER (ORDER BY "Year")) / LAG(Profit) OVER (ORDER BY "Year"))*100, 2) AS "YoY Profit%",
	ROUND((Discount - LAG(Discount) OVER (ORDER BY "Year")) / LAG(Discount) over (ORDER BY "Year") *100, 2) AS "YoY Discount%",
	ROUND((Quantity - LAG(Quantity) OVER (ORDER BY "Year"))::numeric/ NULLIF(LAG(Quantity) OVER (ORDER BY "Year"), 0)*100, 2) AS "Yoy Quantity%"
FROM 
	yearly_data;