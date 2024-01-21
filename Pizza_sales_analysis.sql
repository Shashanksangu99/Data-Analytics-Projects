Select * from pizza_sales;

#finding total sales 
Select sum(total_price) as total_sales from pizza_sales;

#finding average order value
Select (sum(total_price)/count(distinct order_id)) as avg_order_value from pizza_sales;

#finding total pizzas sold
Select sum(quantity) as Total_pizzas_sold from pizza_sales;

#calculate total number of orders
Select count(distinct order_id) as Number_of_orders from pizza_sales;

#Average Pizzas per order 
Select sum(quantity)/count(distinct order_id) as Avg_pizzas_per_order from pizza_sales;

#Pizzas ordered in every hour in a day
Select hour(order_time) as order_hour, sum(quantity) as Total_pizzas_sold_per_hour from pizza_sales
group by hour(order_time)
order by hour(order_time);

#Weekly trend of pizza orders
SELECT week(order_date) AS week_, YEAR(order_date) AS year_, COUNT(DISTINCT order_id) AS order_count
FROM pizza_sales
GROUP BY week(order_date), YEAR(order_date)
ORDER BY week(order_date), YEAR(order_date);

#Sales percentage of each category
Select pizza_category, format(sum(total_price)*100/ (Select sum(total_price) from pizza_sales),2) as Sales_percentage
from pizza_sales
group by pizza_category
order by sum(total_price)*100/ (Select sum(total_price) from pizza_sales);

#Sales percentage by pizza size
Select pizza_size, format(sum(total_price)*100/(Select sum(total_price) from pizza_sales),2) as Size_PCT
from pizza_sales
group by pizza_size
order by Size_PCT DESC; 

#Top 5 best sellers by revenue
select pizza_name, sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue desc
limit 5;

#Bottom 5 best sellers by revenue
select pizza_name, sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue asc
limit 5; 

#Top 5 best sellers by quantity
select pizza_name, sum(quantity) as total_quantity from pizza_sales
group by pizza_name
order by total_quantity desc
limit 5; 

#Bottom 5 best sellers by quantity
select pizza_name, sum(quantity) as total_quantity from pizza_sales
group by pizza_name
order by total_quantity Asc
limit 5; 

#Top 5 best sellers by total orders
select pizza_name, count(distinct order_id) as order_quantity from pizza_sales
group by pizza_name
order by order_quantity desc
limit 5; 

#Bottom 5 best sellers by total orders
select pizza_name, count(distinct order_id) as order_quantity from pizza_sales
group by pizza_name
order by order_quantity asc
limit 5;     









