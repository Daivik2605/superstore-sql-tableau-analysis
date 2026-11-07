/*
===========================================================
DATE_TRUNC() AND TO_CHAR() - POSTGRESQL DATE FUNCTIONS
===========================================================

1. DATE_TRUNC()

Purpose:
Truncates a date or timestamp to a specified time unit.
It resets smaller time components.

Syntax:
DATE_TRUNC('unit', date_column)

Examples:
DATE_TRUNC('year', order_date)
    -> 2024-08-15 becomes 2024-01-01 00:00:00

DATE_TRUNC('month', order_date)
    -> 2024-08-15 becomes 2024-08-01 00:00:00

DATE_TRUNC('day', order_date)
    -> 2024-08-15 becomes 2024-08-15 00:00:00

Common units: year, quarter, month, week, day, hour.

Use DATE_TRUNC() in GROUP BY to aggregate data
by calendar periods such as months or years.


2. TO_CHAR()

Purpose:
Converts a date, timestamp, or number into formatted TEXT.

Syntax:
TO_CHAR(date_expression, 'format')

Examples:
TO_CHAR(order_date, 'YYYY')
    -> 2024-08-15 becomes '2024'

TO_CHAR(order_date, 'FMMonth YYYY')
    -> 2024-08-15 becomes 'August 2024'

TO_CHAR(order_date, 'DD/MM/YYYY')
    -> 2024-08-15 becomes '15/08/2024'

Common format codes:
YYYY  = Four-digit year
MM    = Two-digit month number
DD    = Two-digit day
Month = Full month name
Mon   = Abbreviated month name
FM    = Suppresses padding spaces


3. COMBINING DATE_TRUNC() AND TO_CHAR()

TO_CHAR(DATE_TRUNC('month', order_date), 'FMMonth YYYY')

Step 1: DATE_TRUNC truncates the date to its month.
        2024-08-15 -> 2024-08-01 00:00:00

Step 2: TO_CHAR formats the result as text.
        2024-08-01 -> 'August 2024'

Important:
- DATE_TRUNC() returns a timestamp for a DATE input.
- TO_CHAR() returns TEXT.
- Use DATE_TRUNC() for grouping and chronological sorting.
- Use TO_CHAR() when you need readable labels.
- ORDER BY a TO_CHAR label may sort alphabetically,
  rather than chronologically.
===========================================================
*/

SELECT 
	TO_CHAR(DATE_TRUNC('year', order_date), 'YYYY') as "Year",
	SUM(profit) as "Profit",
	SUM(sales) as "Sales"
FROM 
	orders
GROUP BY DATE_TRUNC('year', order_date)
ORDER BY DATE_TRUNC('year', order_date);

SELECT 
	DATE_TRUNC('year', order_date)::date AS "Year",
	SUM(Profit),
	SUM(Sales)
FROM orders
GROUP BY DATE_TRUNC('year', order_date)
ORDER BY DATE_TRUNC('year', order_date);

SELECT 
	TO_CHAR(DATE_TRUNC('year', order_date), 'YYYY') AS "Year",
	SUM(Profit),
	SUM(Sales)
FROM orders
GROUP BY DATE_TRUNC('year', order_date)
ORDER BY DATE_TRUNC('year', order_date);
	