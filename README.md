# Retail Sales Analysis Through SQL

Project Overview

## Retail Sales SQL Analysis Project
This project showcases my SQL learning journey through the analysis of a retail sales dataset. The goal was to strengthen my understanding of SQL by performing data exploration, data cleaning, aggregation, and business-oriented analysis using real-world scenarios.

Using a retail sales dataset and a collection of business questions, I applied SQL techniques to explore sales performance, customer behavior, and product trends. Through this project, I practiced key SQL concepts including filtering, aggregation, grouping, joins, window functions, Common Table Expressions (CTEs), and ranking functions.

This project represents my practical application of SQL skills and my progress toward becoming a data analyst/data scientist.

> **Note:** The dataset and practice questions used in this project were provided by Zero Analyst. Full acknowledgment is provided in the Acknowledgments section below.



## Objectives

* Develop practical SQL skills by working with a retail sales dataset and solving real-world business problems.
* Perform data exploration and validation to better understand the structure, quality, and characteristics of the dataset.
* Apply SQL concepts such as filtering, aggregation, grouping, sorting, subqueries, Common Table Expressions (CTEs), and window functions.
* Analyze sales performance across different time periods, product categories, and customer segments.
* Extract meaningful business insights from retail transaction data using SQL queries.
* Strengthen problem-solving abilities by answering analytical questions commonly encountered in data analyst roles.
* Build a portfolio-ready project that demonstrates proficiency in SQL and data analysis techniques.

1. Database Setup
```sql
create table retail_sales
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
```
2. Data Exploration & Cleaning
Analyzing the whole database and dropping column and rows with NULL values. 
```sql
select * from retail_sales;
```
```sql
select * from retail_sales
where 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```
```sql
delete from retail_sales
where 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```  
3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
```sql
select  * from retail_sales where sale_date = '2022-11-05';
```
2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
```sql
select * from retail_sales where category = 'Clothing' and quantity >= 4 and sale_date between '2022-11-01' and '2022-11-30';
```
3.Write a SQL query to calculate the total sales (total_sale) for each category.:
```sql
select sum(total_sale) as total_sales_amount, category from retail_sales group by category; 
```
4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
```sql
select round(avg(age), 2) as average_age from retail_sales where category = 'Beauty';
```
5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
```sql
select * from rettail_sales where total_sale > 1000;
```
6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
```sql
select count(transactions_id) as total_transaction, category, gender from retail_sales group by gender, category ;
```
7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
```sql
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
```
8.Write a SQL query to find the top 5 customers based on the highest total sales:
```sql
select customer_id, sum(total_sale) as total_sale from retail_sales group by customer_id order by total_sale desc limit 5;
```
9.Write a SQL query to find the number of unique customers who purchased items from each category.:
```sql
select count(distinct customer_id) as customers, count(quantity) as total_quantity, category from retail_sales group by category;
```
10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
```sql
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
```

## Findings

* Successfully explored and analyzed retail sales data using SQL queries.
* Identified sales patterns across different product categories and customer demographics.
* Analyzed monthly sales performance to determine high-performing periods and seasonal trends.
* Used aggregation and ranking functions to identify top customers and best-performing sales periods.
* Applied SQL techniques such as filtering, grouping, window functions, and Common Table Expressions (CTEs) to solve business-focused analytical questions.
* Gained practical experience in transforming raw transactional data into meaningful business insights.

## Reports

### Sales Performance Analysis

* Evaluated sales activity across different categories and time periods.
* Analyzed average sales, transaction counts, and category-level performance.

### Customer Analysis

* Examined customer purchasing behavior and spending patterns.
* Identified high-value customers and customer distribution across categories.

### Time-Based Analysis

* Investigated sales trends by month and sales shifts (Morning, Afternoon, and Evening).
* Compared performance across different periods to identify patterns in customer activity.

## Conclusion

This project allowed me to apply core SQL concepts in a practical business scenario using retail sales data. Throughout the analysis, I strengthened my understanding of data exploration, aggregation, filtering, window functions, and Common Table Expressions (CTEs).

By working through real-world analytical questions, I developed a stronger foundation in SQL and gained experience extracting actionable insights from transactional data. This project represents an important step in my journey toward becoming a data analyst and building industry-relevant analytical skills.

## Special Note

 You may notice that some queries use a mix of uppercase and lowercase SQL keywords. While the formatting may not always be consistent, all queries were written and tested as part of my hands-on practice and learning process.

If you find any mistakes, bugs, or opportunities for improvement, please feel free to contact me or open an issue. Constructive feedback is always appreciated and helps me continue growing as a data analyst.

Thank you for checking out my project!

## Acknowledgments

Special thanks to [Zero Analyst](https://github.com/ZeroAnalyst) for providing the retail sales dataset and practice questions that inspired this project. All SQL solutions, analysis, documentation, and project implementation in this repository were completed independently as part of my learning journey.


