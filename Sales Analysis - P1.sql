-- 	SQL Retail Sales Analysis - P1

-- Create Table 

Drop table if exists retail_sales 

create table retail_sales(
transactions_id int,
sale_date Date,
sale_time Time,
customer_id	int,
gender varchar(15),
age	int,
category varchar(15),
quantiy int,
price_per_unit float,
cogs float,
total_sale float
);

select * from retail_sales
limit 10

select count(*) from retail_sales

select * from retail_sales
where transactions_id is null  

select * from retail_sales
where sale_time is null 

-- (Data Cleaning)
select * from retail_sales
where 
      transactions_id is null 
	  or
	  sale_time is null 
	  or
	  sale_date is null
	  or 
	  gender is null
	  or
	  age is null
	  or
	  category is null
	  or
	  quantiy is null
	  or
	  price_per_unit is null
	  or
	  cogs is null
	  or
	  total_sale is null;
	   

delete from retail_sales
where 
      transactions_id is null 
	  or
	  sale_time is null 
	  or
	  sale_date is null
	  or 
	  gender is null
	  or
	  age is null
	  or
	  category is null
	  or
	  quantiy is null
	  or
	  price_per_unit is null
	  or
	  cogs is null
	  or
	  total_sale is null;

select * from retail_sales

-- (Data Exploration) 

-- How many Sales we have?

select count(*) as total_number_sale from retail_sales 

-- How many unique Customers we have?

select count(distinct customer_id) as total_sale from retail_sales

-- How many Category we have?

select count(distinct category) from retail_sales

-- (Data Analysis And Business key problems and answers)

-- Write a SQL Query to retrieve(show) all Columns for sales made on '2022-11-05'

select * from retail_sales
where sale_date='2022-11-05'

-- Write a SQL Query to retrieve all transaction where the category is 'Clothing' and the quantity_sold is more than 4 in the 
--  month of Nov-2022?

select * from retail_sales
where category='Clothing' and quantiy>=4 and sale_date<='2022-11-30';

-- Write a SQL query to calculate the total sales (total_sale) and total orders for each category

select category,
sum(total_sale) as total_sale,
count(*) as total_orders
from retail_sales
group by category

--Write a SQL query to find the average ag of customers who purchased items from the 'Beauty'category

select round(Avg(age),2) as Avg_age
from retail_sales
where category='Beauty'

-- Write a SQL query to find all transactions where the total_sale is greter than 1000

select * from retail_sales
where total_sale>1000

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

select category,
count(transactions_id) as total_num_transaction_id,gender
from retail_sales
group by category,gender
order by 1;

-- Write a SQL query to Calculate the average sale for each month. find out best selling month in each year

select 
      extract (year from sale_date) as year,
	  extract(month from sale_date) as month,
	  Avg(total_sale) as Avg_sale,
rank () over(partition by extract(year from sale_date)order by Avg(total_sale) desc)
from retail_sales
group by 1,2;

-- only best selling month and year rank 1 
select 
      year_,
	  month_,
	  Avg_sales
from
(
select 
    extract(year from sale_date) as year_,
    extract(month from sale_date) as month_,
	Avg(total_sale) as Avg_sales,
	rank() over(partition by extract(year from sale_date) order by Avg(total_sale) desc )
from retail_sales
group by 1,2 
) as t1
where rank = 1

-- Write a SQL query to find the top 5 customers based on highest total sales

select * from retail_sales

select customer_id,
      sum(total_sale) as total_sale
from retail_sales 
group by 1 
order by 2 desc
limit 5

-- Write a SQL query to find the number of unique customers who purchased items form each category

select category,
count(distinct customer_id) as unique_customers
from retail_sales 
group by category;

--Write a SQL query to create each shift and number of orders (CTE use) (Exmple Morning <12, Afternoon between 12 and 17, Evening >1)
-- (CTE stand for common Table Expretion)

with hourly_sale
as
(
select *,
        case
	when extract (hour from sale_time)< 12 then 'Morning'
    when extract (hour from sale_time) between 12 and 17 then 'Afternoon'
	Else 'Evening'
end as Shift
from retail_sales
)
select 
      shift,
	  count(*) as total_orders
from hourly_sale
group  by shift;

-- End of Project


























		







	  








  
      

















	 



