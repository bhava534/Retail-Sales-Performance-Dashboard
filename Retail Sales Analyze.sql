Create database Retail_Project;
USE Retail_Project;

## Create a sales table
CREATE table Sales (
order_id int,
order_date date,
store_id int,
product_id int,
customer_id int,
quantity int,
revenue decimal(10,2)
);

## Create a stores table
create table stores (products
store_id int,
city varchar(50),
region varchar(50)
);

## Create a products table
create table Products (
product_id int,
category varchar(50),
sub_category varchar(50)
);

select * from Sales;
select * from Products;
select * from stores;

## total revenue
select sum(revenue) as Total_Revenue from Sales;

## Revenue by store id
select store_id, sum(revenue) as total_Revenue
from Sales
group by store_id;

## Revenue by product
select product_id, sum(revenue) as total_Revenue
from Sales
group by product_id;

## Top 5 products by revenue
select product_id, sum(revenue) as total_revenue
from Sales
group by product_id
order by total_revenue desc
limit 5;

## Revenue by store names
select s.city, s.region, sum(sa.revenue) as total_revenue from sales sa
join stores s on sa.store_id = s.store_id
group by s.city,s.region
order by total_revenue desc;

## revenue by product name
select p.category, p.sub_category, sum(sa.revenue) as total_revenue from sales sa
join Products p on sa.product_id = p.product_id
group by p.category,p.sub_category
order by total_revenue desc;

## Which stores are growing and which are declining
select store_id, date_format(order_date,'%Y-%m') as month,
sum(revenue) as monthly_revenue from sales
group by store_id, month
order by store_id, month;

## monthly revenue of store id 1 and 2
select store_id, date_format(order_date,'%Y-%m') as month,
sum(revenue) as monthly_revenue from sales
where store_id in (1,2) and date_format(order_date,'%Y-%m') = '2024-01'
group by store_id, month;

## Which city has highest revenue
select s.city, sum(sa.revenue) as total_revenue
from Sales sa
join stores s on sa.store_id=s.store_id
group by s.city
order by total_revenue desc;

## which region has highest revenue
SELECT
s.region,
SUM(sa.revenue) AS total_revenue
FROM sales sa
JOIN stores s
ON sa.store_id = s.store_id
GROUP BY s.region
ORDER BY total_revenue DESC;

SELECT
sa.order_date,
s.city,
s.region,
p.category, p.sub_category,
sa.revenue
FROM Sales sa
JOIN stores s ON sa.store_id = s.store_id
JOIN Products p ON sa.product_id = p.product_id;


