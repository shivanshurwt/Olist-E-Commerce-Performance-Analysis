use e_comerce_o_list;

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/ADMIN/OneDrive/Desktop/Project/SQL/olist_customers_dataset.csv'
INTO TABLE customers
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-----------------------------------------------------------------------------------------------------

-- 2. Geolocation Table (1M+ rows, may take a few seconds)
LOAD DATA LOCAL INFILE 'C:/Users/ADMIN/OneDrive/Desktop/Project/SQL/olist_geolocation_dataset.csv'
INTO TABLE geolocation
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- 3. Order Items Table
LOAD DATA LOCAL INFILE 'C:/Users/ADMIN/OneDrive/Desktop/Project/SQL/olist_order_items_dataset.csv'
INTO TABLE order_items
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- 4. Order Payments Table
LOAD DATA LOCAL INFILE 'C:/Users/ADMIN/OneDrive/Desktop/Project/SQL/olist_order_payments_dataset.csv'
INTO TABLE order_payments
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- 5. Order Reviews Table
LOAD DATA LOCAL INFILE 'C:/Users/ADMIN/OneDrive/Desktop/Project/SQL/olist_order_reviews_dataset.csv'
INTO TABLE order_reviews
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- 6. Orders Table
LOAD DATA LOCAL INFILE 'C:/Users/ADMIN/OneDrive/Desktop/Project/SQL/olist_orders_dataset.csv'
INTO TABLE orders
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- 7. Products Table
LOAD DATA LOCAL INFILE 'C:/Users/ADMIN/OneDrive/Desktop/Project/SQL/olist_products_dataset.csv'
INTO TABLE products
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- 8. Sellers Table (Note: table name matches your schema 'sellers_dataset')
LOAD DATA LOCAL INFILE 'C:/Users/ADMIN/OneDrive/Desktop/Project/SQL/olist_sellers_dataset.csv'
INTO TABLE sellers_dataset
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- 9. Product Category Translation Table
LOAD DATA LOCAL INFILE 'C:/Users/ADMIN/OneDrive/Desktop/Project/SQL/product_category_name_translation.csv'
INTO TABLE product_category_name_translation
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


SELECT 'customers' AS table_name, COUNT(*) FROM customers
UNION ALL SELECT 'geolocation', COUNT(*) FROM geolocation
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL SELECT 'order_reviews', COUNT(*) FROM order_reviews
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'sellers_dataset', COUNT(*) FROM sellers_dataset
UNION ALL SELECT 'product_category_name_translation', COUNT(*) FROM product_category_name_translation;

TRUNCATE TABLE geolocation;


