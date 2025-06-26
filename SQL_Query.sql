show tables;

desc Sales;

select*from Sales;
select salesDate, Amount,Customes from Sales;

/*Total Sales Revenue by Product */

SELECT p.Product, SUM(s.Amount) AS Total_Revenue
FROM sales s
JOIN products p ON s.PID = p.PID
GROUP BY p.Product
ORDER BY Total_Revenue DESC;


/*Identifies which sales teams are the most successful */
SELECT sp.Team, SUM(s.Amount) AS Team_Revenue
FROM sales s
JOIN people sp ON s.SPID = sp.SPID
WHERE sp.Team IS NOT NULL AND sp.Team <> ''
GROUP BY sp.Team
ORDER BY Team_Revenue DESC
LIMIT 5;


/* monthly sales over time to spot trends or seasonality */
SELECT DATE_FORMAT(SaleDate, '%Y-%m') AS Month, SUM(Amount) AS Total_Monthly_Sales
FROM sales
GROUP BY Month
ORDER BY Month;

/*Finds products performing above the average sales level.*/
SELECT p.Product, SUM(s.Amount) AS Total_Sales
FROM sales s
JOIN products p ON s.PID = p.PID
GROUP BY p.Product
HAVING Total_Sales > (
    SELECT AVG(Amount) FROM sales
);
