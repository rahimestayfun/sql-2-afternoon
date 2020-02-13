Summary
-- Let's simulate an e-commerce site. We're going to need users, products, and orders.

-- users need a name and an email.
-- products need a name and a price
-- orders need a ref to product.
-- All 3 need primary keys.

Instructions
-- Create 3 tables following the criteria in the summary.
-- Add some data to fill up each table.
-- At least 3 users, 3 products, 3 orders.
-- Run queries against your data.
CREATE TABLE users(
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  email VARCHAR(100)  
  );

INSERT INTO users(name,email)
VALUES('Tom','tom@gmail.com'),
      ('Haley','haley@gmail.com'),
      ('Frank','frank@gmail.com'),
      ('Sally','sally@gmail.con');
--==================================   
CREATE TABLE products
(product_id SERIAL PRIMARY KEY,
 product_name VARCHAR(200),
 product_price INT
);

INSERT INTO products
(product_name,product_price)
VALUES('jacket',100),
      ('beanie',20),
      ('jeans',50),
      ('t-shirt',20),
      ('sweater',50);

--==================================   
CREATE TABLE orders
(order_id SERIAL PRIMARY KEY,
product_id INT REFERENCES products(product_id));


INSERT INTO orders
(product_id)
VALUES(4),
      (2),
      (5);


-- Get all products for the first order.

SELECT * FROM products
WHERE product_id IN(
  SELECT product_id FROM orders
  WHERE order_id = 1);


-- Get all orders.
SELECT * FROM orders;

-- Get the total cost of an order ( sum the price of all products on an order ).
SELECT o.order_id, SUM(p.product_price) FROM products p
JOIN orders o ON p.product_id = o.product_id
WHERE o.order_id = 3
GROUP BY o.order_id;

-- Add a foreign key reference from orders to users.
ALTER TABLE users
ADD COLUMN order_id INT
REFERENCES orders(order_id);


-- Update the orders table to link a user to each order.
UPDATE users 
SET order_id = 1
WHERE user_id = 3;

UPDATE users 
SET order_id = 2
WHERE user_id = 3;

UPDATE users 
SET order_id = 3
WHERE user_id = 4;


-- Run queries against your data.
-- Get all orders for a user.
SELECT * FROM users
WHERE order_id IN(
  SELECT order_id from orders
  WHERE user_id = 4);


-- Get how many orders each user has.
SELECT u.name,COUNT(*) FROM orders o
JOIN users u ON o.order_id = u.order_id
GROUP BY u.name;



-- Black Diamond
-- Get the total amount on all orders for each user.
SELECT u.name,SUM(p.product_price) from products p
JOIN orders o ON o.product_id = p.product_id
JOIN users u ON u.order_id = o.order_id
GROUP BY u.name;



