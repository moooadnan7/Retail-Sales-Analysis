-- Create New Database ;
create Database real_state;

-- Create New Table ;
create Table data_info2
           (
		   transactions_id int primary key,
		   sale_date date ,
		   sale_time date ,
		   customer_id int ,
		   gender varchar(15),
		   age int , 
		   category varchar(15) , 
		   quantiy int , 
		   price_per_unit float , 
		   cogs float , 
		   total_sale float ,
		   );

-- Select All ;
select * from data_info2;

select * from data_info2 
where transactions_id is null

-- check the rows that have null values ;
select * from data_info2
where
     transactions_id is null
or
     sale_date is null
or
     sale_time is null
or   
     customer_id is null
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
     total_sale is null


-- Delete all rows that have a null value ;
delete from data_info2
where
     transactions_id is null
or
     sale_date is null
or
     sale_time is null
or   
     customer_id is null
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
     total_sale is null

-- Get the total number of sales ;
select COUNT (*) as total_Sales from data_info2;

-- Get the total number of customers ;
select COUNT (distinct customer_id ) as total_Customer from data_info2;

-- Get the total number of categories ;
select COUNT (distinct category) as total_Category from data_info2;

-- Get the categories names ;
select  distinct category as Category from data_info2;

-- Get the data in specific date ; 
select * from data_info2 
where sale_date = '2022-11-05'

-- Get the data of category 'clothing' and quantity of sales is more than 3 and the tansaction was in november ;  
select * from data_info2 
where category = 'clothing' 
and
quantiy > 3 
and
month(sale_date) = 11

-- Get the category and total sales and number of orders of each category ;
select category ,
       sum(total_sale) as net_sales ,
	   count(*) as total_order
from data_info2 
group by category

-- Get the average of ages category is 'beauty'
select AVG(age) as age_average from data_info2  
where category = 'Beauty'


-- Get the data which total sales is more than 1000
select * from data_info2
where total_sale > 1000

-- Get the gender and category an number of tansaction for each category and gender ;
select gender,
       category,
       count(transactions_id) as transactions
from data_info2
group by gender,category

-- Get the average of sales for each months and years ;
select YEAR(sale_date) as years,
       month(sale_date) as months,
       AVG(total_sale)
from data_info2 
group by YEAR(sale_date),
         month(sale_date)  
order by 1,2

-- Get the top five customers who have most total sales ;
select TOP 5 customer_id , 
       sum(total_sale) as Sales
from data_info2
group by customer_id
order by 2 desc

-- Get the category and number of customers for each category ;
select category , 
       count(customer_id) as customer_number
from data_info2
group by category
order by 2