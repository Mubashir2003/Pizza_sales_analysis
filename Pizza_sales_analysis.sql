--  Question :1
-- Retrieve the total number of orders placed
select count(order_id) as total_orders from orders
 -- Question : 2
 -- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(orders_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    orders_details
        JOIN
    pizzas ON pizzas.pizza_id = orders_details.pizza_id

-- Qusetion :3
-- Identify the highest-priced pizza.
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1

-- Question : 4
-- Identify the most common pizza size ordered.
SELECT 
    pizzas.size,
    COUNT(orders_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC

-- Question :5
SELECT 
    pizza_types.name, SUM(orders_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5

-- Question:6
-- Join the necessary tables to find the total quantity of each pizza category ordered.
select pizza_types.category , 
sum(orders_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by quantity desc

-- question :7
-- Determine the distribution of orders by hour of the day.
select hour(order_time) as hours , count(order_id) as order_count
from orders
group by hour(order_time)

-- Question:8
-- Join relevant tables to find the category-wise distribution of pizzas.
select category , count(name) from pizza_types 
group by category

-- Question:9
-- Group the orders by date and calculate the average number of pizzas ordered per day.
select round(avg(quantity) , 0) as avg_pizzas_ordered_per_day
 from
(select orders.order_date , sum(orders_details.quantity)  as quantity
from orders join orders_details
on orders.order_id = orders_details.order_id
group by orders.order_date) as order_quantity

-- Question : 10
-- Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name , 
sum(orders_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3


