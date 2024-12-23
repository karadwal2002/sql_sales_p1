--create tabel
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
			(
				transactions_id INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,
				customer_id INT,
				gender VARCHAR(15),
				age INT,
				category VARCHAR(25),
				quantiy INT,
				price_per_unit FLOAT,
				cogs FLOAT,
				total_sale FLOAT
			);
select * from retail_sales
limit 10

select 
	count(*)
from retail_sales

select * from retail_sales
where 
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	gender is null
	or
	category is null
	or
	quantiy is null
	or
	cogs is null
	or
	total_sale is null;

delete from retail_sales
where 
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	gender is null
	or
	category is null
	or
	quantiy is null
	or
	cogs is null
	or
	total_sale is null;

--Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'.

select*
from retail_Sales
where sale_date = '2022-11-05';

--Q2.  Write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold i smore than 30 in the month of nov-022.

select*
from retail_sales
where category = 'Clothing'
	and
	to_char(sale_date, 'yyyy-mm') = '2022-11'
	and
	quantiy >= 4

--Q3. Write a SQL query to calculate the total sales (total_sale) for each category.

select
		category,
		sum(total_sale) as net_sales,
		count (*) as total_orders
from retail_sales
group by 1

--Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select
round(avg (age),2) as avg_age
from retail_sales
where
category = 'Beauty'

--Q5. Write a query to find all the transactions where the total_sales is greater than 1000.

select * from retail_sales
where total_sale > 1000

--Q6. Write a Sql query to find the total number of transactions made by each gender inn each category.

select
		category,
		gender,
		count(*) as total_trans
from retail_sales
		group
		by category, 
			gender
order by 1

--Q7. Write a sql query to calculate the avg sales for each month. Find out the best selling month inn each year.
select 
		year,
		month,
		avg_sales
from
(
select
	extract (year from sale_date) as year,
	extract (month from sale_date) as month,
	avg(total_sale) as avg_sales,
	rank() over (partition by extract(year from sale_date) order by avg(total_Sale) desc) as rank
from retail_sales
group by 1, 2) as t1
where rank = 1

--Q10. Write a sql query to find the top 5 customers based on the highest total sales.
select
	customer_id,
	sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5

--Q9. Write a sql query to find the number of unique customers who purchased itmes from each category.

select
	category,
	count(distinct customer_id)
from retail_sales
group by category

--Q10. Write a sql query to create each shift and number of orders (eg - morning <= 12, afternoon between 12 and 17, evening >1).
with hourly_sales
as
(
select *,
	case
		when extract(hour from sale_time) < 12 then 'morning'
		when extract(hour from sale_time) between 12 and 17 then 'afternoon'
		else 'evening'
	end as shift
from retail_sales
)
select
	shift,
	count(*) as total_orders
from hourly_sales
group by shift

--end of the project

