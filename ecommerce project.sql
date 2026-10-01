
use ecommerce_project;

CREATE TABLE customers(
customer_id INT primary key,
customer_name VARCHAR(200),
email VARCHAR(200),
city VARCHAR(100),
registration_date VARCHAR(200));


INSERT INTO customers
(customer_id, customer_name, email, city, registration_date)
VALUES
(1, 'Asha', 'asha@gmail.com', 'Hyderabad', '2024-01-15'),
(2, 'Rahul', 'rahul@gmail.com', 'Bangalore', '2024-02-10'),
(3, 'Priya', 'priya@gmail.com', 'Chennai', '2024-03-05'),
(4, 'Arun', 'arun@gmail.com', 'Hyderabad', '2024-04-20'),
(5, 'Sneha', 'sneha@gmail.com', 'Mumbai', '2024-05-12'),
(6, 'Vikram', 'vikram@gmail.com', 'Pune', '2024-06-18'),
(7, 'Meena', 'meena@gmail.com', 'Delhi', '2024-07-22'),
(8, 'Kiran', 'kiran@gmail.com', 'Hyderabad', '2024-08-10');

select * from customers;

CREATE TABLE categories(
category_id INT primary key,
category_name varchar(50) not null unique);

INSERT INTO categories (category_id, category_name)
VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Home Appliances'),
(4, 'Books'),
(5, 'Beauty');

select *from categories;

CREATE TABLE products(
product_id int primary key,
product_name varchar(100) not null,
category_id int not null,
price decimal(10,2) not null,
stock int not null default 0,
FOREIGN KEY (category_id)
REFERENCES categories (category_id));

INSERT INTO products
(product_id, product_name, category_id, price, stock)
VALUES
(101, 'Laptop', 1, 65000, 20),
(102, 'Smartphone', 1, 30000, 35),
(103, 'Headphones', 1, 3000, 50),
(104, 'T-Shirt', 2, 800, 100),
(105, 'Jeans', 2, 1800, 60),
(106, 'Microwave Oven', 3, 12000, 15),
(107, 'Mixer Grinder', 3, 4500, 25),
(108, 'SQL Book', 4, 900, 40),
(109, 'Novel', 4, 500, 70),
(110, 'Face Cream', 5, 700, 80);
  
  select * from products;

CREATE TABLE orders( 
order_id int primary key,
customer_id int null,
order_date DATE not null,
order_status varchar(20) not null, 
foreign key (customer_id) 
references customers(customer_id));


INSERT INTO orders
(order_id, customer_id, order_date, order_status)
VALUES
(1001, 1, '2024-08-01', 'Delivered'),
(1002, 2, '2024-08-03', 'Delivered'),
(1003, 3, '2024-08-05', 'Pending'),
(1004, 1, '2024-08-10', 'Delivered'),
(1005, 4, '2024-08-12', 'Cancelled'),
(1006, 5, '2024-08-15', 'Delivered'),
(1007, 6, '2024-08-18', 'Pending'),
(1008, 7, '2024-08-20', 'Delivered'),
(1009, 8, '2024-08-22', 'Delivered'),
(1010, 3, '2024-08-25', 'Delivered');

select * from orders

CREATE TABLE order_items( 
order_item_id int primary key, 
order_id int not null, 
product_id int not null,
quantity int  not null,
unit_price decimal(10,2) not null, 
foreign key(order_id) 
references orders(order_id),
foreign key (product_id) references products(product_id));

INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 1001, 101, 1, 65000),
(2, 1001, 103, 2, 3000),
(3, 1002, 102, 1, 30000),
(4, 1002, 104, 2, 800),
(5, 1003, 108, 1, 900),
(6, 1004, 105, 1, 1800),
(7, 1004, 110, 2, 700),
(8, 1005, 106, 1, 12000),
(9, 1006, 107, 1, 4500),
(10, 1006, 109, 2, 500),
(11, 1007, 101, 1, 65000),
(12, 1008, 104, 3, 800),
(13, 1008, 110, 1, 700),
(14, 1009, 103, 1, 3000),
(15, 1009, 108, 2, 900),
(16, 1010, 102, 1, 30000),
(17, 1010, 105, 2, 1800);

select * from order_items;


CREATE TABLE payments( 
payment_id int primary key,
order_id int not null,
payment_date DATE not null, 
amount decimal(10,2) not null, 
payment_method varchar(100)not null, 
payment_status varchar(100)not null,
foreign key (order_id)
references orders(order_id));

INSERT INTO payments
(payment_id, order_id, payment_date, amount, payment_method, payment_status)
VALUES
(501, 1001, '2024-08-01', 71000, 'UPI', 'Paid'),
(502, 1002, '2024-08-03', 31600, 'Card', 'Paid'),
(503, 1003, '2024-08-05', 900, 'UPI', 'Pending'),
(504, 1004, '2024-08-10', 3200, 'Card', 'Paid'),
(505, 1005, '2024-08-12', 12000, 'UPI', 'Failed'),
(506, 1006, '2024-08-15', 5500, 'Cash', 'Paid'),
(507, 1007, '2024-08-18', 65000, 'Card', 'Pending'),
(508, 1008, '2024-08-20', 3100, 'UPI', 'Paid'),
(509, 1009, '2024-08-22', 4800, 'Card', 'Paid'),
(510, 1010, '2024-08-25', 33600, 'UPI', 'Paid');

select * from payments;

use ecommerce_project

select count(*) as orders_count from orders;

select sum(quantity) as total_products_sold
from order_items;

select sum(quantity *unit_price)/ count(distinct order_id) as average_order_value
from order_items;

SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id,
    c.customer_name
ORDER BY total_orders DESC;

SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spent DESC;

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_quantity_sold DESC;

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_revenue DESC;

SELECT
    c.category_id,
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS category_revenue
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY category_revenue DESC;

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


SELECT
    payment_status,
    COUNT(*) AS total_payments
FROM payments
GROUP BY payment_status
ORDER BY total_payments DESC;

SELECT
    payment_method,
    COUNT(*) AS total_payments,
    SUM(amount) AS total_amount
FROM payments
GROUP BY payment_method
ORDER BY total_payments DESC;

/* which customers are contibuting the most revune?*/

SELECT TOP 3
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spent DESC;

/*find the order that generated the highest total value*/
SELECT TOP 1
    o.order_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS order_value
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    o.order_id,
    c.customer_name
ORDER BY order_value DESC; -- it says which customer placed the highest-value order, and how much was that order worth?

/*find customers who have placed more than one order?*/
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC; -- this identifies customers who are repeat buyers.

/* how much revenue came from delivered oredrs only?*/
 SELECT
    SUM(oi.quantity * oi.unit_price) AS delivered_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'; -- it distinguish completed sales from orders that are still pending or cancelled.

/* find customers who have registered but never palced an order.*/
SELECT
    c.customer_id,
    c.customer_name,
    c.city
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL; --it identify the regitered customers who havent purchased anything yet, which are usefuk fro customer-engagement analysis.

/* which products are in the catalog but have never apperared in an order?*/
SELECT
    p.product_id,
    p.product_name,
    p.stock
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

/* Find customers whose tital spending is greater than the average customer spending*/
SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name
HAVING SUM(oi.quantity * oi.unit_price) >
(
    SELECT AVG(customer_total)
    FROM
    (
        SELECT
            o2.customer_id,
            SUM(oi2.quantity * oi2.unit_price) AS customer_total
        FROM orders o2
        JOIN order_items oi2
            ON o2.order_id = oi2.order_id
        GROUP BY o2.customer_id
    ) AS customer_spending
)
ORDER BY total_spent DESC;

/* rank customers from highest to lowest based in their total spending.*/
SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent,
    RANK() OVER (
        ORDER BY SUM(oi.quantity * oi.unit_price) DESC
    ) AS spending_rank
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY spending_rank;

/* rank customers from highest to lowest based on their total spending.*/
SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent,
    RANK() OVER (
        ORDER BY SUM(oi.quantity * oi.unit_price) DESC
    ) AS spending_rank
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY spending_rank;

/* claculate each category's total revenue and rank the catgoreis from highest to lowest revnue*/
SELECT
    c.category_id,
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(oi.quantity * oi.unit_price) DESC
    ) AS revenue_rank
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY revenue_rank;

/* calculate the total revune generated for each month */
SELECT
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date)
ORDER BY
    order_year,
    order_month;

/* show each month's delivered revenue along with the cumulative revenue up to that month.*/
WITH monthly_sales AS (
    SELECT
        YEAR(o.order_date) AS order_year,
        MONTH(o.order_date) AS order_month,
        SUM(oi.quantity * oi.unit_price) AS monthly_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        YEAR(o.order_date),
        MONTH(o.order_date)
)
SELECT
    order_year,
    order_month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (
        ORDER BY order_year, order_month
    ) AS cumulative_revenue
FROM monthly_sales
ORDER BY
    order_year,
    order_month;

/*now we will rank customers based on how many orders they placed.*/
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    RANK() OVER (
        ORDER BY COUNT(o.order_id) DESC
    ) AS order_rank
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY order_rank;

/* calculate the total spending by customers in each city*/
SELECT
    c.city,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.city
ORDER BY total_revenue DESC;

/*what is the average value of each customer's orders?*/
SELECT
    c.customer_id,
    c.customer_name,
    AVG(order_total) AS average_order_value
FROM customers c
JOIN (
    SELECT
        o.order_id,
        o.customer_id,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        o.order_id,
        o.customer_id
) AS order_totals
    ON c.customer_id = order_totals.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY average_order_value DESC;

/*Find how many different orders each product apperas in*/
SELECT
    p.product_id,
    p.product_name,
    COUNT(DISTINCT oi.order_id) AS number_of_orders
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY number_of_orders DESC;

/*Find the best-slling product by quantity within each category.*/

WITH product_sales AS (
    SELECT
        c.category_name,
        p.product_id,
        p.product_name,
        SUM(oi.quantity) AS total_quantity_sold
    FROM categories c
    JOIN products p
        ON c.category_id = p.category_id
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY
        c.category_name,
        p.product_id,
        p.product_name
),
ranked_products AS (
    SELECT
        category_name,
        product_id,
        product_name,
        total_quantity_sold,
        RANK() OVER (
            PARTITION BY category_name
            ORDER BY total_quantity_sold DESC
        ) AS product_rank
    FROM product_sales
)
SELECT
    category_name,
    product_id,
    product_name,
    total_quantity_sold
FROM ranked_products
WHERE product_rank = 1
ORDER BY category_name;

/*show each customer's total spending and what percentaeg of total customer revuew they contributed.*/
SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent,
    ROUND(
        SUM(oi.quantity * oi.unit_price) * 100.0
        / SUM(SUM(oi.quantity * oi.unit_price)) OVER (),
        2
    ) AS revenue_percentage
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spent DESC;

/*find each customer, find their most recent order date.*/
SELECT
    c.customer_id,
    c.customer_name,
    MAX(o.order_date) AS latest_order_date
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY latest_order_date DESC;

-- now we will find the first order date for each customer.
SELECT
    c.customer_id,
    c.customer_name,
    MIN(o.order_date) AS first_order_date
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY first_order_date;

---find the no of orders placed by  customers in each city.
SELECT
    c.city,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.city
ORDER BY total_orders DESC;

--find the total amount paid through each payment method, considering only succesful payments
SELECT
    p.payment_method,
    COUNT(p.payment_id) AS total_payments,
    SUM(p.amount) AS total_amount
FROM payments p
WHERE p.payment_status = 'Paid'
GROUP BY p.payment_method
ORDER BY total_amount DESC;

-- find orders where the recorded payment amount does not match the calulated order value.
SELECT
    o.order_id,
    SUM(oi.quantity * oi.unit_price) AS order_value,
    p.amount AS payment_amount
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY
    o.order_id,
    p.amount
HAVING SUM(oi.quantity * oi.unit_price) <> p.amount
ORDER BY o.order_id;

-- find orders that are still pending and show their paymen status and amount.
SELECT
    o.order_id,
    c.customer_name,
    o.order_date,
    o.order_status,
    p.payment_status,
    p.amount
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN payments p
    ON o.order_id = p.order_id
WHERE o.order_status = 'Pending'
ORDER BY o.order_date;

-- find all cancelled orders along with the customer name and order value.
SELECT
    o.order_id,
    c.customer_name,
    o.order_date,
    SUM(oi.quantity * oi.unit_price) AS order_value
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Cancelled'
GROUP BY
    o.order_id,
    c.customer_name,
    o.order_date
ORDER BY o.order_date;

-- calculate the total order value for each status: delivered, pending, and ccancelled.
SELECT
    o.order_status,
    SUM(oi.quantity * oi.unit_price) AS total_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    o.order_status
ORDER BY total_order_value DESC;

-- now we will identify customers who have placed atleast 2 orders and claculate their total spending.
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name
HAVING COUNT(DISTINCT o.order_id) >= 2
ORDER BY total_spent DESC;

--find the customers who has spent the most money in each city.
WITH customer_spending AS (
    SELECT
        c.city,
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.unit_price) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.city,
        c.customer_id,
        c.customer_name
),
ranked_customers AS (
    SELECT
        city,
        customer_id,
        customer_name,
        total_spent,
        RANK() OVER (
            PARTITION BY city
            ORDER BY total_spent DESC
        ) AS city_rank
    FROM customer_spending
)
SELECT
    city,
    customer_id,
    customer_name,
    total_spent
FROM ranked_customers
WHERE city_rank = 1
ORDER BY city;

--find cutomers whose total spending is greater than the average spending of all customers.
SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name
HAVING SUM(oi.quantity * oi.unit_price) >
(
    SELECT AVG(customer_total)
    FROM
    (
        SELECT
            o2.customer_id,
            SUM(oi2.quantity * oi2.unit_price) AS customer_total
        FROM orders o2
        JOIN order_items oi2
            ON o2.order_id = oi2.order_id
        GROUP BY o2.customer_id
    ) AS customer_spending
)
ORDER BY total_spent DESC;

-- rank all customers based on their spending from highest to lowest 
SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent,
    RANK() OVER (
        ORDER BY SUM(oi.quantity * oi.unit_price) DESC
    ) AS spending_rank
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY spending_rank;

/*find the top 3 customers who have spent the most money.*/
SELECT TOP 3
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spent DESC;

--find the order with the highest total value and show the customer who placed it.
SELECT TOP 1
    o.order_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS order_value
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    o.order_id,
    c.customer_name
ORDER BY order_value DESC;

--find all products that never appeared in any order.

SELECT
    p.product_id,
    p.product_name,
    p.stock
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL
ORDER BY p.product_id;
    
    --find customers who have never paced an order.
SELECT
    c.customer_id,
    c.customer_name,
    c.city
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
ORDER BY c.customer_id;

--find the top 3 products by revenuw within each product category. 
WITH product_revenue AS (
    SELECT
        c.category_name,
        p.product_id,
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM categories c
    JOIN products p
        ON c.category_id = p.category_id
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY
        c.category_name,
        p.product_id,
        p.product_name
),
ranked_products AS (
    SELECT
        category_name,
        product_id,
        product_name,
        total_revenue,
        RANK() OVER (
            PARTITION BY category_name
            ORDER BY total_revenue DESC
        ) AS revenue_rank
    FROM product_revenue
)
SELECT
    category_name,
    product_id,
    product_name,
    total_revenue,
    revenue_rank
FROM ranked_products
WHERE revenue_rank <= 3
ORDER BY
    category_name,
    revenue_rank;

-- calculate each customer's total spending and show their percentile among all customers. 
WITH product_revenue AS (
    SELECT
        c.category_name,
        p.product_id,
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM categories c
    JOIN products p
        ON c.category_id = p.category_id
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY
        c.category_name,
        p.product_id,
        p.product_name
),
ranked_products AS (
    SELECT
        category_name,
        product_id,
        product_name,
        total_revenue,
        RANK() OVER (
            PARTITION BY category_name
            ORDER BY total_revenue DESC
        ) AS revenue_rank
    FROM product_revenue
)
SELECT
    category_name,
    product_id,
    product_name,
    total_revenue,
    revenue_rank
FROM ranked_products
WHERE revenue_rank <= 3
ORDER BY
    category_name,
    revenue_rank;

    -- for each cutomer find their latest orders date and the previuos order date, then calculate the number of days between them.
    WITH customer_orders AS (
    SELECT
        c.customer_id,
        c.customer_name,
        o.order_id,
        o.order_date,
        LAG(o.order_date) OVER (
            PARTITION BY c.customer_id
            ORDER BY o.order_date
        ) AS previous_order_date
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
)
SELECT
    customer_id,
    customer_name,
    order_id,
    order_date,
    previous_order_date,
    DATEDIFF(
        DAY,
        previous_order_date,
        order_date
    ) AS days_between_orders
FROM customer_orders
WHERE previous_order_date IS NOT NULL
ORDER BY customer_id, order_date;

--classify customers into high, medium, and low spenders based on their total spending. 
SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent,
    CASE
        WHEN SUM(oi.quantity * oi.unit_price) >= 50000
            THEN 'High Spender'
        WHEN SUM(oi.quantity * oi.unit_price) >= 10000
            THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS customer_segment
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spent DESC;

--for each month, calculate the number of orders and the total revene generated.
SELECT
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date)
ORDER BY
    order_year,
    order_month;

  -- find the payment method with the highest number of successful paid transactions
  SELECT TOP 1
    payment_method,
    COUNT(*) AS total_paid_transactions,
    SUM(amount) AS total_paid_amount
FROM payments
WHERE payment_status = 'Paid'
GROUP BY payment_method
ORDER BY total_paid_transactions DESC;

--find products that have stock below 30 but have been ordered at least once.
SELECT
    p.product_id,
    p.product_name,
    p.stock,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.stock
HAVING
    p.stock < 30
    AND SUM(oi.quantity) > 0
ORDER BY
    total_quantity_sold DESC;

--calculate each category total revenue and its percentage contribution to overall revenue.
WITH category_sales AS (
    SELECT
        c.category_id,
        c.category_name,
        SUM(oi.quantity * oi.unit_price) AS category_revenue
    FROM categories c
    JOIN products p
        ON c.category_id = p.category_id
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY
        c.category_id,
        c.category_name
)
SELECT
    category_id,
    category_name,
    category_revenue,
    ROUND(
        category_revenue * 100.0
        / SUM(category_revenue) OVER (),
        2
    ) AS revenue_percentage
FROM category_sales
ORDER BY category_revenue DESC;

--find customers whose most recent order was more than 30 days before the latest order date in the databse.
WITH customer_last_order AS (
    SELECT
        c.customer_id,
        c.customer_name,
        MAX(o.order_date) AS last_order_date
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.customer_name
),
latest_date AS (
    SELECT MAX(order_date) AS latest_order_date
    FROM orders
)
SELECT
    clo.customer_id,
    clo.customer_name,
    clo.last_order_date,
    DATEDIFF(
        DAY,
        clo.last_order_date,
        ld.latest_order_date
    ) AS days_since_last_order
FROM customer_last_order clo
CROSS JOIN latest_date ld
WHERE DATEDIFF(
    DAY,
    clo.last_order_date,
    ld.latest_order_date
) > 30
ORDER BY days_since_last_order DESC;

--calculate the average order value for each order status.
WITH order_totals AS (
    SELECT
        o.order_id,
        o.order_status,
        SUM(oi.quantity * oi.unit_price) AS order_value
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        o.order_id,
        o.order_status
)
SELECT
    order_status,
    COUNT(*) AS total_orders,
    AVG(order_value) AS average_order_value
FROM order_totals
GROUP BY order_status
ORDER BY average_order_value DESC;

--find the product with the highest number of orders in each category.
WITH product_order_frequency AS (
    SELECT
        c.category_name,
        p.product_id,
        p.product_name,
        COUNT(DISTINCT oi.order_id) AS number_of_orders
    FROM categories c
    JOIN products p
        ON c.category_id = p.category_id
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY
        c.category_name,
        p.product_id,
        p.product_name
),
ranked_products AS (
    SELECT
        category_name,
        product_id,
        product_name,
        number_of_orders,
        RANK() OVER (
            PARTITION BY category_name
            ORDER BY number_of_orders DESC
        ) AS product_rank
    FROM product_order_frequency
)
SELECT
    category_name,
    product_id,
    product_name,
    number_of_orders
FROM ranked_products
WHERE product_rank = 1
ORDER BY category_name;

--create a final customer-level report showing each customer's total orders, total quantity purchased. total spending, and order value.
WITH customer_summary AS (
    SELECT
        c.customer_id,
        c.customer_name,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.quantity) AS total_quantity_purchased,
        SUM(oi.quantity * oi.unit_price) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_id,
        c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_orders,
    total_quantity_purchased,
    total_spent,
    ROUND(
        total_spent / total_orders,
        2
    ) AS average_order_value
FROM customer_summary
ORDER BY total_spent DESC;

ALTER TABLE products
ADD CONSTRAINT CK_products_price
CHECK (price > 0);
GO

ALTER TABLE products
ADD CONSTRAINT CK_products_stock
CHECK (stock >= 0);
GO

ALTER TABLE order_items
ADD CONSTRAINT CK_order_items_quantity
CHECK (quantity > 0);
GO

ALTER TABLE order_items
ADD CONSTRAINT CK_order_items_unit_price
CHECK (unit_price > 0);
GO

ALTER TABLE payments
ADD CONSTRAINT CK_payments_amount
CHECK (amount >= 0);
GO

CREATE OR ALTER VIEW dbo.CustomerSpendingSummary
AS
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name;
GO


SELECT *
FROM dbo.CustomerSpendingSummary
ORDER BY total_spent DESC
GO;


CREATE OR ALTER VIEW dbo.ProductPerformance
AS
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products p
JOIN categories c
    ON p.category_id = c.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name,
    c.category_name;
    GO

SELECT *
FROM dbo.ProductPerformance
ORDER BY total_revenue DESC
GO;


CREATE OR ALTER VIEW dbo.CategoryRevenue
AS
SELECT
    c.category_id,
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    c.category_id,
    c.category_name;
GO

SELECT *
FROM dbo.CategoryRevenue
ORDER BY total_revenue DESC
GO;

--stored procedure 1- get orders for a customer

CREATE OR ALTER PROCEDURE dbo.GetCustomerOrders
    @CustomerID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        o.order_id,
        o.order_date,
        o.order_status
    FROM orders o
    WHERE o.customer_id = @CustomerID
    ORDER BY o.order_date;
END;
GO

EXEC dbo.GetCustomerOrders @CustomerID = 1
go;

--get products by category.
CREATE OR ALTER PROCEDURE dbo.GetProductsByCategory
    @CategoryID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        p.product_id,
        p.product_name,
        p.price,
        p.stock
    FROM products p
    WHERE p.category_id = @CategoryID
    ORDER BY p.price DESC;
END;
GO  --THE GO COMMAND SIGNALS THE END OF THE PREVIOUS BATCH SO THE PROCEDURE CAN START FRESH.

EXEC dbo.GetProductsByCategory @CategoryID = 1;
GO
--CUSTOMER SPENDING SUMMARY.

CREATE OR ALTER PROCEDURE dbo.GetCustomerSpending
    @CustomerID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        c.customer_id,
        c.customer_name,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.quantity) AS total_quantity,
        SUM(oi.quantity * oi.unit_price) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE c.customer_id = @CustomerID
    GROUP BY
        c.customer_id,
        c.customer_name;
END;
GO

EXEC dbo.GetCustomerSpending @CustomerID = 1;
GO

--CHECK CUSTOMER'S TOTAL SPENDING AND CLASSIFY THEM AS HIGH SPENDER OR REGULAR SPENDER.
CREATE OR ALTER PROCEDURE dbo.CheckCustomerSpending
    @CustomerID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TotalSpent DECIMAL(12,2);

    SELECT
        @TotalSpent = SUM(oi.quantity * oi.unit_price)
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.customer_id = @CustomerID;

    IF @TotalSpent >= 50000
        SELECT
            @CustomerID AS customer_id,
            @TotalSpent AS total_spent,
            'High Spender' AS customer_category;
    ELSE
        SELECT
            @CustomerID AS customer_id,
            @TotalSpent AS total_spent,
            'Regular Spender' AS customer_category;
END;
GO

EXEC dbo.CheckCustomerSpending @CustomerID = 1
GO;

--GIVEN A CUSTOMER ID, SHOW THEIR TOTAL NUMBER OF ORDERS AND TOTAL AMOUNT SPENT.

CREATE OR ALTER PROCEDURE dbo.GetCustomerOrderSummary
    @CustomerID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        c.customer_id,
        c.customer_name,
        COUNT(DISTINCT o.order_id) AS total_orders,
        COALESCE(
            SUM(oi.quantity * oi.unit_price),
            0
        ) AS total_spent
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE c.customer_id = @CustomerID
    GROUP BY
        c.customer_id,
        c.customer_name;
END;
GO

EXEC dbo.GetCustomerOrderSummary @CustomerID = 1;
GO

--TRANSACTION#1 WE WILL DEMOSTRATE IT WITH A TRANSACTION AND THEN USE ROLLBACK SO YOUR EXIXSTING PROJECT DATA ISN'T CHANGED.
BEGIN TRANSACTION;

INSERT INTO orders
(order_id, customer_id, order_date, order_status)
VALUES
(1011, 1, '2024-08-30', 'Pending');

INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(18, 1011, 103, 1, 3000);

INSERT INTO payments
(payment_id, order_id, payment_date, amount, payment_method, payment_status)
VALUES
(511, 1011, '2024-08-30', 3000, 'UPI', 'Pending');

-- Check the transaction's changes
SELECT *
FROM orders
WHERE order_id = 1011;

SELECT * 
FROM order_items
WHERE order_id=1011;

SELECT *
FROM payments
WHERE order_id = 1011;

ROLLBACK TRANSACTION;

--Now we will create a new ordeer and permanently save it using COMMIT.
BEGIN TRANSACTION;

INSERT INTO orders
(order_id, customer_id, order_date, order_status)
VALUES
(1011, 1, '2024-08-30', 'Delivered');

INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(18, 1011, 103, 1, 3000);

INSERT INTO payments
(payment_id, order_id, payment_date, amount, payment_method, payment_status)
VALUES
(511, 1011, '2024-08-30', 3000, 'UPI', 'Paid');

COMMIT TRANSACTION;

SELECT *
FROM orders
WHERE order_id = 1011;

SELECT *
FROM order_items
WHERE order_id = 1011;

SELECT *
FROM payments
WHERE order_id = 1011;

--Now we will use a savepoint to demonstrate partial rollback safely.
BEGIN TRANSACTION;

UPDATE products
SET stock = stock - 1
WHERE product_id = 103;

SAVE TRANSACTION StockUpdate;

UPDATE products
SET stock = stock - 5
WHERE product_id = 102;

-- Undo only the second update
ROLLBACK TRANSACTION StockUpdate;

COMMIT TRANSACTION;

--triggers# we will create a useful order audit trigger.
CREATE TABLE order_audit (
    audit_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(20),
    action_date DATETIME DEFAULT GETDATE()
);
GO

CREATE OR ALTER TRIGGER dbo.trg_OrderInsertAudit
ON orders
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO order_audit
    (
        order_id,
        customer_id,
        order_date,
        order_status
    )
    SELECT
        order_id,
        customer_id,
        order_date,
        order_status
    FROM inserted;
END;
GO

INSERT INTO orders
(order_id, customer_id, order_date, order_status)
VALUES
(1012, 2, '2024-09-01', 'Pending');

SELECT *
FROM order_audit
WHERE order_id = 1012;

--now we will create another useful trigger that records when an order's status changes, fro example: pending:delivered, pending- cancelled 
CREATE TABLE order_status_audit (
    audit_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    old_status VARCHAR(20),
    new_status VARCHAR(20),
    changed_at DATETIME DEFAULT GETDATE()
);
GO

CREATE OR ALTER TRIGGER dbo.trg_OrderStatusUpdate
ON orders
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO order_status_audit
    (
        order_id,
        old_status,
        new_status
    )
    SELECT
        d.order_id,
        d.order_status,
        i.order_status
    FROM deleted d
    JOIN inserted i
        ON d.order_id = i.order_id
    WHERE d.order_status <> i.order_status;
END;
GO

UPDATE orders
SET order_status = 'Delivered'
WHERE order_id = 1012;

SELECT *
FROM order_status_audit
WHERE order_id = 1012
go;

--prevent a product's stock from beginning negative when someone updates the stock.

CREATE OR ALTER TRIGGER dbo.trg_PreventNegativeStock
ON products
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE stock < 0
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50001, 'Stock cannot be negative.', 1;
    END;
END;
GO

UPDATE products
SET stock = -5
WHERE product_id = 103;

SELECT product_id, product_name, stock
FROM products
WHERE product_id = 103;

-- this will record he old stock and new arock whenever a product's stock changes.
CREATE TABLE stock_audit (
    audit_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT,
    old_stock INT,
    new_stock INT,
    changed_at DATETIME DEFAULT GETDATE()
);
GO

CREATE OR ALTER TRIGGER dbo.trg_StockAudit
ON products
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO stock_audit
    (
        product_id,
        old_stock,
        new_stock
    )
    SELECT
        d.product_id,
        d.stock,
        i.stock
    FROM deleted d
    JOIN inserted i
        ON d.product_id = i.product_id
    WHERE d.stock <> i.stock;
END;
GO

UPDATE products
SET stock = stock - 1
WHERE product_id = 103;

SELECT *
FROM stock_audit
WHERE product_id = 103
ORDER BY changed_at DESC;

--index1 -->index customer_id in orders 

CREATE INDEX IX_orders_customer_id
ON orders(customer_id);
GO

SELECT
    name,
    type_desc
FROM sys.indexes
WHERE object_id = OBJECT_ID('orders');

--index2 -->we will create a composite index because the project frequently searches/joins order items using both prouct_id & order_id

CREATE INDEX IX_order_items_product_id_order_id
ON order_items(product_id, order_id);
GO

SELECT
    name,
    type_desc
FROM sys.indexes
WHERE object_id = OBJECT_ID('order_items');

--this will help queries that frequently filter payments by payment_status, such as fimding paid, pending, or failed payments.
CREATE INDEX IX_payments_payment_status
ON payments(payment_status);
GO

SELECT
    name,
    type_desc
FROM sys.indexes
WHERE object_id = OBJECT_ID('payments');



-- performance task1 -check statistics
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT
    o.order_id,
    o.order_date,
    o.order_status,
    c.customer_name
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.customer_id = 1;

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

SELECT
    order_id,
    customer_id
FROM orders WITH (INDEX(IX_orders_customer_id))
WHERE customer_id = 1;

SELECT
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

SELECT
    name
FROM sys.views
WHERE schema_id = SCHEMA_ID('dbo')
ORDER BY name;

SELECT
    name
FROM sys.procedures
WHERE schema_id = SCHEMA_ID('dbo')
ORDER BY name;

SELECT
    name
FROM sys.triggers
WHERE parent_id IN (
    OBJECT_ID('orders'),
    OBJECT_ID('products')
)
ORDER BY name;

SELECT
    OBJECT_NAME(i.object_id) AS table_name,
    i.name AS index_name,
    i.type_desc AS index_type
FROM sys.indexes i
WHERE i.name IS NOT NULL
  AND i.object_id IN (
      OBJECT_ID('orders'),
      OBJECT_ID('order_items'),
      OBJECT_ID('payments')
  )
ORDER BY table_name, index_name;

