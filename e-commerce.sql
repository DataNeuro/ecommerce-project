--1. List of departments with their associated aisles.
CREATE TEMPORARY TABLE list_of_aisle AS 
	SELECT DISTINCT a.aisle, p.department_id FROM aisles a
	JOIN products p 
	ON a.aisle_id=p.aisle_id;

SELECT d.department, la.aisle FROM departments d
JOIN list_of_aisle la
ON d.department_id=la.department_id
ORDER BY d.department ASC;

--2. Number of aisles in each department.
SELECT d.department, COUNT(la.aisle) AS number_of_aisle FROM departments d
JOIN list_of_aisle la
ON d.department_id=la.department_id
GROUP BY d.department
ORDER BY number_of_aisle DESC;

--3. List of products with their corresponding aisle.
SELECT product_name, aisle FROM products p
JOIN aisles a
ON p.aisle_id = a.aisle_id
ORDER BY aisle ASC;

--4. Number of products in each aisle.
SELECT aisle, COUNT(p.product_id) AS number_of_products_in_aisle FROM aisles a
JOIN products p
ON a.aisle_id = p.aisle_id
GROUP BY aisle
ORDER BY number_of_products_in_aisle DESC;

--5. List of users who have made the highest number of orders. 
SELECT user_id FROM orders
GROUP BY user_id
HAVING COUNT(order_id) IN
	(SELECT COUNT(order_id) FROM orders
	GROUP BY user_id
	ORDER BY COUNT(order_id) DESC
	LIMIT 1)
ORDER BY user_id;

-- 6. Discount for the 3 groups of customers with the most orders:
--1st group 15%, 2nd group 10%, 3rd group 5%, rest of users 0%.

CREATE TEMPORARY TABLE number_ordes_by_user AS
	SELECT user_id, COUNT(order_id) AS number_orders FROM orders
	GROUP BY user_id;

WITH ranking_orders AS(
	SELECT user_id, number_orders, DENSE_RANK() OVER(ORDER BY number_orders DESC) AS ranking
	FROM number_ordes_by_user)

SELECT user_id, number_orders,
CASE 
	WHEN ranking = 1 THEN '15%'
	WHEN ranking = 2 THEN '10%'
	WHEN ranking = 1 THEN '5%'
	ELSE '0%'
	END AS discount
FROM ranking_orders;

--7. Prepare a table for further analysis containing information on each order, 
-- including the products purchased and their department and aisle information.
CREATE TEMPORARY TABLE order_info AS
SELECT o.order_id, o.user_id, o.order_number, o.order_dow, o.order_hour_of_day, o.days_since_prior_order,
op.product_id, op.add_to_cart_order, op.reordered,
p.product_name, p.aisle_id, p.department_id
FROM orders o
JOIN order_products op ON o.order_id=op.order_id
JOIN products p ON op.product_id=p.product_id;

--8. The amount of products sold by department.
SELECT o.department_id, d.department, SUM(o.add_to_cart_order) AS sell_by_department FROM order_info o
JOIN departments d
ON o.department_id=d.department_id
GROUP BY o.department_id, d.department
ORDER BY o.department_id;

--9. Prepare a table for further analysis: by department with the total number of products purchased, 
--the total number of products purchased on weekdays and weekends.
CREATE TEMPORARY TABLE department_order_summary AS
	SELECT department_id, COUNT(*) AS total_products_purchased,
	COUNT(CASE WHEN order_dow < 6 THEN 1 ELSE NULL END) AS total_weekday_purchases,
	COUNT(CASE WHEN order_dow >= 6 THEN 1 ELSE NULL END) AS total_weekend_purchases
	FROM order_info
	GROUP BY department_id;

--10. Which department had the highest weekly sales?
SELECT department_id FROM department_order_summary
WHERE total_weekday_purchases IN(SELECT MAX(total_weekday_purchases) FROM department_order_summary);

--11. The 10 aisles with the highest sales.
CREATE TEMPORARY TABLE aisle_order_summary AS
	SELECT a.aisle_id, a.aisle, COUNT(o.*) total_products_purchased FROM aisles a
	JOIN order_info o
	ON a.aisle_id=o.aisle_id
	GROUP BY a.aisle_id, a.aisle;

SELECT * FROM aisle_order_summary
ORDER BY total_products_purchased DESC
LIMIT 10;

--12. List of the 10 most purchased products.
SELECT product_id, product_name FROM products
WHERE product_id IN
(SELECT product_id FROM order_products
GROUP BY product_id
ORDER BY SUM(add_to_cart_order) DESC
LIMIT 10);

--13. Ranking of the 10 products with the highest number of units sold.
CREATE TEMPORARY TABLE number_of_order_products AS
	SELECT product_id, SUM(add_to_cart_order) AS sum_of_order_products FROM order_products
	GROUP BY product_id;

SELECT no.product_id, p.product_name, no.sum_of_order_products, DENSE_RANK() OVER(ORDER BY no.sum_of_order_products DESC) AS rankig 
FROM number_of_order_products no
JOIN products p
ON no.product_id=p.product_id
LIMIT 10;

--14. The three most reordered products.
WITH reordered_products AS
	(SELECT product_id, SUM(reordered) AS number_reordered_products FROM order_products
	GROUP BY product_id)

SELECT rp.product_id, p.product_name, rp.number_reordered_products FROM reordered_products rp
JOIN products p
ON rp.product_id=p.product_id
ORDER BY rp.number_reordered_products DESC
LIMIT 3;

--15. Prepare a table for further analysis with the number of product orders compared to the number of product re-orders, 
--and with the average amount of product added to the basket.
CREATE TEMPORARY TABLE product_order_summary AS
	SELECT product_id, product_name, count(*) AS total_orders,
	SUM(reordered) AS total_reorders, AVG(add_to_cart_order) AS avg_add_to_cart
	FROM order_info
	GROUP BY product_id, product_name;

--16. What percentage of all products ordered were orders of the product with the highest sales?
SELECT ROUND((SELECT total_orders FROM product_order_summary 
			  WHERE product_id IN(SELECT product_id FROM order_info GROUP BY product_id ORDER BY SUM(add_to_cart_order) DESC LIMIT 1 ))/SUM(total_orders)*100,2)
FROM product_order_summary;

--17. Number of orders per hour.
CREATE TEMPORARY TABLE number_orders_per_hour AS 
SELECT order_hour_of_day, COUNT(order_id) AS number_orders FROM orders
GROUP BY order_hour_of_day;

SELECT * FROM number_orders_per_hour;

--18. Which hour had the most orders and which the least.
SELECT order_hour_of_day, number_orders FROM number_orders_per_hour
WHERE number_orders IN (SELECT MAX(number_orders)FROM number_orders_per_hour)
UNION ALL 
SELECT order_hour_of_day, number_orders FROM number_orders_per_hour
WHERE number_orders IN (SELECT MIN(number_orders)FROM number_orders_per_hour);

--19. List of the 10 most frequently purchased products in the morning.
SELECT product_id, product_name, COUNT(product_id) AS number_products FROM order_info
GROUP BY product_id, product_name, order_hour_of_day
HAVING order_hour_of_day IN(6,7,8,9)
ORDER BY number_products DESC
LIMIT 10;

-- 20. The difference between weekday and weekend sales in each department.
SELECT department_id, (total_weekday_purchases-total_weekend_purchases) AS difference_in_sales 
FROM department_order_summary
ORDER BY department_id;

--21. List of products that have not been reordered.
SELECT product_id, product_name FROM order_info
GROUP BY product_id, product_name
HAVING SUM(reordered) = 0;

--22. The average amount of a specific product placed in a shopping cart.
SELECT product_id, product_name, ROUND(AVG(add_to_cart_order),2) AS avg_add_to_cart FROM order_info
GROUP BY product_id, product_name
ORDER BY product_id;

--23. Summary with information on product, department, aisle, total number of orders, reorders,
--average number of products added to basket, total sales, weekly and weekend sales.
CREATE TEMPORARY TABLE product_behavior_analysis AS
    SELECT p.product_id, p.product_name, p.department_id, d.department, p.aisle_id, a.aisle,
           pos.total_orders, pos.total_reorders, pos.avg_add_to_cart,
           dos.total_products_purchased,dos.total_weekday_purchases, 
		   dos.total_weekend_purchases
    FROM product_order_summary pos
    JOIN products p ON pos.product_id = p.product_id
    JOIN departments d ON p.department_id = d.department_id
    JOIN aisles a ON p.aisle_id = a.aisle_id
    JOIN department_order_summary dos ON p.department_id = dos.department_id;
	
SELECT * FROM product_behavior_analysis;

--24. Comparison of the number of orders of each product with the maximum number of orders in an aisle.
SELECT product_id, product_name, aisle_id, aisle, total_orders, 
MAX(total_orders) OVER(PARTITION BY aisle_id)AS highest_orders
FROM product_behavior_analysis;
