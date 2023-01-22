

CREATE TABLE sales (
  "customer_id" VARCHAR(1),
  "order_date" DATE,
  "product_id" INTEGER
);

INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  "product_id" INTEGER,
  "product_name" VARCHAR(5),
  "price" INTEGER
);

INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  "customer_id" VARCHAR(1),
  "join_date" DATE
);

INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');

  select * from members;select * from sales;select * from menu;
--1. What is the total amount each customer spent at the restaurant?
select s.customer_id,sum(m.price) as total_amount_spent
from sales s  left join menu  m on s.product_id=m.product_id group by customer_id;

--2. How many days has each customer visited the restaurant?
select customer_id,count(distinct order_date) as total_visit from sales group by customer_id;

--3. What was the first item from the menu purchased by each customer?
SELECT DISTINCT(customer_id), 
       product_name FROM sales s
JOIN menu m 
ON m.product_id = s.product_id
WHERE s.order_date = ANY 
      (
       SELECT MIN(order_date) 
       FROM sales 
       GROUP BY customer_id
      )

--4. What is the most purchased item on the menu and how many times was it purchased by all customers?
 select * from members;select * from sales;select * from menu;

with Max_Purchased_item as
(
select m.product_name,count(s.product_id) as total_sales 
	from sales s left join menu m 
	on s.product_id=m.product_id
	group by m.product_name
	) 
select * from Max_Purchased_item where total_sales = (select max(total_sales) from Max_Purchased_item);

--5. Which item was the most popular for each customer?
 select * from members;select * from sales;select * from menu;

 select s.customer_id,max(s.product_id)
	from sales s LEFT JOIN menu m 
	ON s.product_id=m.product_id
	GROUP BY s.customer_id
