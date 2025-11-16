-- Select all the rows and colums 
SELECT * 
FROM   sales.case.study;

---------------------------------------------------------------------------------------------------------------------
-- DATE

-- Check if more one sale occured in a single date
SELECT Date,
       COUNT(*) AS  Row_Count  
FROM sales.case.study
GROUP BY date;
--HAVING  COUNT(*) > 1;

-- Convert date using date functions 
SELECT 
       TRY_TO_DATE(date,'DD/MM/YYYY') AS Date,
  --FROM sales.case.study;

--Get month from the Date 
   --SELECT 
       MONTHNAME(TRY_TO_DATE(date,'DD/MM/YYYY')) AS month,
   --FROM sales.case.study;

--Get day from the Date
   --SELECT 
       DAYNAME(TRY_TO_DATE(date,'DD/MM/YYYY')) AS day,
       sales,
       cost_of_sales,
       quantity_sold,
  --FROM sales.case.study;

---------------------------------------------------------------------------------------------------------------------
-- Daily unit price
--SELECT 
      (sales)/QUANTITY_SOLD AS unit_price,
--FROM sales.case.study;

-- Average unit price
--SELECT 
      --AVG((sales))/QUANTITY_SOLD)  AS avg_unit_price,
--FROM sales.case.study;

-- Gross profit%
--SELECT
       (sales) - (cost_of_sales) / (sales)* 100 AS gross_profit_pct,
--FROM sales.case.study;

--Unit gross profit
--SELECT 
      ((sales - cost_of_sales) / quantity_sold) AS unit_gross_profit
FROM sales.case.study;
---------------------------------------------------------------------------------------------------------------------
-- Final Code


WITH cleaned_sales AS (

    SELECT 
        TRY_TO_DATE(date,'DD/MM/YYYY') AS date,
        YEAR(TRY_TO_DATE(date,'DD/MM/YYYY')) AS year,
        MONTHNAME(TRY_TO_DATE(date,'DD/MM/YYYY')) AS month,
        DAYNAME(TRY_TO_DATE(date,'DD/MM/YYYY')) AS day,

        CASE 
            WHEN DAYNAME(TRY_TO_DATE(date,'DD/MM/YYYY')) IN ('Sat','Sun') 
            THEN 'Wekeend'
            ELSE 'Weekday'
        END AS day_classification,

        ROUND(sales) AS sales,
        ROUND(cost_of_sales) AS cost_of_sales,
        quantity_sold,

        ROUND(sales / quantity_sold) AS unit_price,

        ROUND(((sales - cost_of_sales) / sales) * 100,2) AS gross_profit_pct,

        ROUND((sales - cost_of_sales) / quantity_sold,2) AS unit_gross_profit

    FROM sales.case.study
)

SELECT *
FROM cleaned_sales
ORDER BY date;
