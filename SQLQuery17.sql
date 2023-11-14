/* SQL PROJECT */
-- BUSINESS INSIGHTS; improvement made from the company stakeholders?...
--producing top states that made sales profitable to get their annual income
--total annual revenue from above sales

--Query 1: Looking at the top 10 states that made income from their sales?
SELECT TOP 10 State, Category,[Product Name],Sales,Profit,SUM(Sales + Profit) as Total_Income
FROM Orders$
group by  State, Category,[Product Name],Sales,Profit
order by sales desc;

--Query 2: Applying ranks to each products
select [Product Name],Quantity, [Product ID],[Ship Mode],
RANK () OVER (ORDER BY [Product Name], Quantity, [Product ID],[Ship Mode]) AS RANKS
from Orders$
GROUP BY [Product Name],Quantity, [Product ID],[Ship Mode]
ORDER BY [Product Name] ASC;

--Query 3: calculate the total sales that was made in each month of the year?
with MonthlySales as(
SELECT [Customer ID],Sales, sum(sales/12) as MonthlySales
FROM Orders$
group by [Customer ID],Sales
)--order by sales desc
select sum(MonthlySales)as Total_Monthly_Income
from MonthlySales

--Query 4: identifying the date difference from order date to the shipping date
SELECT top 5 [Order Date], [Ship Date],
(SELECT DATEDIFF(DAYOFYEAR, 1,31))AS DAYDIFF,
(SELECT DATEDIFF(WEEKDAY, 1,4))AS WEEKDIFF,
(SELECT DATEDIFF(MONTH,1,31))AS MONTHDIFF,
(SELECT DATEDIFF(YEAR, '2014','2015'))AS YEARDIFF
FROM Orders$

--Query 5: calculate the sum of sales plus profit to get the annual revenue
--(using CTE)
with Total_Income as(
select [Customer ID],[Order Date], sum(sales + Profit) as Total_Income
from Orders$
Group by [Customer ID],[Order Date]
)
select sum (Total_Income) as Yearly_Revenue
from Total_Income

