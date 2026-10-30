-- Rows in each table

SELECT 'customers' AS table_name, COUNT(*) FROM customers
UNION ALL SELECT 'geolocation', COUNT(*) FROM geolocation
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL SELECT 'order_reviews', COUNT(*) FROM order_reviews
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'sellers_dataset', COUNT(*) FROM sellers_dataset
UNION ALL SELECT 'product_category_name_translation', COUNT(*) FROM product_category_name_translation;

---------------------------------------------------------------------------------------------------------
-- Unique customer_id vs Unique customer_unique_id

SELECT 
	COUNT(DISTINCT customer_id) AS customer_id,
	COUNT(distinct customer_unique_id) AS unique_customer_id
FROM customers;

---------------------------------------------------------------------------------------------------------
-- Review rows minus distinct order_ids in reviews

SELECT 
	COUNT(review_id) - COUNT(DISTINCT order_id)
FROM order_reviews;

---------------------------------------------------------------------------------------------------------
-- Orders that have more than one review

SELECT COUNT(*) from (
	SELECT 
		order_id, 
		COUNT(review_id) AS review_count
	FROM order_reviews
	GROUP BY order_id
	HAVING COUNT(review_id) > 1
	ORDER BY review_count DESC) 
s;

---------------------------------------------------------------------------------------------------------
-- Orders with no items

SELECT 
	COUNT(*) from order_items OI 
RIGHT JOIN Orders O
on O.order_id = OI.order_id
where OI.order_id IS NULL;

---------------------------------------------------------------------------------------------------------
-- NULLs in orders: approved / carrier / customer date

SELECT 
    SUM(CASE WHEN CAST(order_approved_at AS CHAR) LIKE '0000%' THEN 1 ELSE 0 END) AS Approved,
    SUM(CASE WHEN CAST(order_delivered_carrier_date AS CHAR) LIKE '0000%' THEN 1 ELSE 0 END) AS Carrier,
    SUM(CASE WHEN CAST(order_delivered_customer_date AS CHAR) LIKE '0000%' THEN 1 ELSE 0 END) AS Customer
FROM Orders;

SELECT * FROM orders LIMIT 10;
---------------------------------------------------------------------------------------------------------
-- Orders with status delivered but no delivery date

SELECT 
    SUM(CASE WHEN CAST(order_delivered_customer_date AS CHAR) LIKE '0000%' THEN 1 ELSE 0 END) AS Customer
FROM Orders
WHERE order_status = "delivered";

---------------------------------------------------------------------------------------------------------
-- NULLs in product: category / weight

SELECT
    SUM(CASE WHEN product_category_name IS NULL 
          OR product_category_name = '' 
        THEN 1 ELSE 0 END) AS Category,
    SUM(CASE WHEN product_weight_g = 0 
		THEN 1 ELSE 0 END) AS Weight
FROM products;

---------------------------------------------------------------------------------------------------------
-- Orders with status delivered

SELECT
	COUNT(*)
FROM orders
WHERE order_status = "delivered";

--------------------------------------------------------------------------------------
-- Distinct payment types & how many rows each

SELECT
	payment_type,
	COUNT(*)
FROM order_payments
GROUP BY payment_type;

---------------------------------------------------------------------------------------------------------
-- Max, Min, Avg of price and freight

SELECT
	MAX(price) AS Maximun_price,
    MIN(price) AS Minimun_price,
    AVG(price) AS Avg_price,
    MAX(freight_value) AS Max_freight,
    MIN(freight_value) AS Min_freight,
    AVG(freight_value) AS Avg_freight
FROM order_items;

---------------------------------------------------------------------------------------------------------
-- Zera-value payments; zero installment

SELECT
	SUM(CASE WHEN payment_value IS NULL OR
    payment_value ='0' THEN 1 ELSE 0 END) AS Zero_value_payment,
    SUM(CASE WHEN payment_installments IS NULL OR 
    payment_installments = "0" THEN 1 ELSE 0 END) AS Zero_installments
FROM order_payments;

---------------------------------------------------------------------------------------------------------
-- First and last order date; orders per month

SELECT
	DATE_FORMAT(order_purchase_timestamp, "%m") AS Month,
	COUNT(DISTINCT order_id) AS Total_orders,
    MIN(order_purchase_timestamp) AS First_order_date,
    MAX(order_purchase_timestamp) AS Last_order_date
FROM orders
GROUP BY Month
Order BY Month;

---------------------------------------------------------------------------------------------------------
-- Items without order / product / seller

SELECT 
    order_item_id, 
    order_id, 
    product_id, 
    seller_id
FROM order_items
WHERE product_id = '0' OR product_id IS NULL OR product_id = ''
   OR seller_id = '0' OR seller_id IS NULL OR seller_id = ''
   OR order_id = '0' OR order_id IS NULL OR order_id = '';

---------------------------------------------------------------------------------------------------------
-- Product categories with no English translation

SELECT 
	DISTINCT(P.product_category_name),
    PT.product_category_name_english
FROM products P
LEFT JOIN product_category_name_translation PT
ON P.product_category_name= PT.product_category_name
WHERE PT.product_category_name IS NULL OR 
PT.product_category_name = "0" OR 
PT.product_category_name = "";

---------------------------------------------------------------------------------------------------------
-- Orders where carrier date is before purchase date

SELECT 
	COUNT(DISTINCT Order_id)
FROM orders
WHERE order_delivered_carrier_date < order_purchase_timestamp;

---------------------------------------------------------------------------------------------------------
-- Exact duplicate rows in geolocation

WITH DuplicateCheck AS (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state 
               ORDER BY geolocation_zip_code_prefix
           ) AS row_num
    FROM geolocation
)
SELECT COUNT(*) 
FROM DuplicateCheck 
WHERE row_num >  1;

---------------------------------------------------------------------------------------------------------
-- SUM(price) & SUM(freight_value) in order_items

SELECT
	SUM(price) AS Total_Price,
    SUM(freight_value) AS Total_freight_value
FROM order_items;

---------------------------------------------------------------------------------------------------------
-- SUM(payment_value) in order_payments

SELECT
	SUM(payment_value) AS Total_payment
FROM order_payments;

---------------------------------------------------------------------------------------------------------
-- Orders that have items

SELECT COUNT(DISTINCT o.order_id) AS total_orders_with_items
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id;

