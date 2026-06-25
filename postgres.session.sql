CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

select * from retail_sales;

select count(TRANSACTIONS_ID)  from retail_sales;

select  * from retail_sales where transactions_id is NULL ;


SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;



DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;



select count(*) as total_sales from retail_sales;

select count(DISTINCT Customer_id) as total_customers from retail_sales;

select count(DISTINCT category) as total_categories from retail_sales;



--1
select  * from retail_sales where sale_date = '2022-11-05';

--2
select * from retail_sales where category = 'Clothing' and quantity >= 4 and sale_date between '2022-11-01' and '2022-11-30';

--3
select sum(total_sale) as total_sales_amount, category from retail_sales group by category; 

--4
select round(avg(age), 2) as average_age from retail_sales where category = 'Beauty';

--5
select * from rettail_sales where total_sale > 1000;

--5
select count(transactions_id) as total_transaction, category, gender from retail_sales group by gender, category ;

--7
select  extract (YEAR from sale_date) as year, extract (MONTH from sale_date) as month, avg(total_sale) as average_sale from retail_sales group by 1,2 order by 1,2;


select year, month, avg_sale
from 
(    
    select 
        extract(year from sale_date) as year,
        extract(month from sale_date) as month,
        avg(total_sale) as avg_sale,
        rank() over(partition by extract(year from sale_date) 
                    order by avg(total_sale) desc) as rank
    from retail_sales
    group by 1, 2
) as ranked_sales
where rank = 1;

--8
select customer_id, sum(total_sale) as total_sale from retail_sales group by customer_id order by total_sale desc limit 5;

--9
select count(distinct customer_id) as customers, count(quantity) as total_quantity, category from retail_sales group by category;

--10
with hour_based_sales
as
(
select *,
    case
        when extract(hour from sale_time) < 12 then 'Morning'
        when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
        else 'Evening'
    end as shift
from retail_sales
)

select shift,count(*) as total_orders from hour_based_sales group by shift;