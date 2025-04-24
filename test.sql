USE ecomercedb;

-- --- Insert Sample Data ---

-- Insert data into brand table
INSERT INTO brand (brand_id, brand_name) VALUES
(1, 'Acme Corporation'),
(2, 'Innovate Tech'),
(3, 'Fashion Forward');

-- Insert data into product_category table
INSERT INTO product_category (category_id, category_name, parent_category_id) VALUES
(101, 'Electronics', NULL),
(102, 'Laptops', 101),
(103, 'Clothing', NULL),
(104, 'T-Shirts', 103);

-- Insert data into product table
INSERT INTO product (product_id, product_name, base_price, brand_id, category_id, description) VALUES
(1001, 'Laptop Pro', 1200.00, 2, 102, 'High performance laptop.'),
(1002, 'Basic T-Shirt', 15.00, 3, 104, 'Comfortable cotton t-shirt.'),
(1003, 'Wireless Mouse', 25.00, 2, 101, 'Ergonomic wireless mouse.');

-- Insert data into product_image table
INSERT INTO product_image (image_id, product_id, image_url, is_main_image) VALUES
(10001, 1001, 'http://example.com/images/laptop_pro_main.jpg', TRUE),
(10002, 1001, 'http://example.com/images/laptop_pro_angle.jpg', FALSE),
(10003, 1002, 'http://example.com/images/tshirt_basic_blue.jpg', TRUE);

-- Insert data into color table
INSERT INTO color (color_id, color_name, hex_code) VALUES
(1, 'Red', '#FF0000'),
(2, 'Blue', '#0000FF'),
(3, 'Green', '#008000');

-- Insert data into size_category table
INSERT INTO size_category (size_category_id, category_name) VALUES
(1, 'Clothing Sizes'),
(2, 'Shoe Sizes');

-- Insert data into size_option table
INSERT INTO size_option (size_option_id, size_category_id, size_value) VALUES
(10, 1, 'S'),
(11, 1, 'M'),
(12, 1, 'L'),
(20, 2, '9'),
(21, 2, '10');

-- Insert data into product_item table (Specific variants)
INSERT INTO product_item (product_item_id, product_id, price, quantity_in_stock, sku) VALUES
(100001, 1002, 15.00, 100, 'TSHIRT-BASIC-BLUE-M'), -- Basic T-Shirt, Blue, M
(100002, 1002, 15.00, 80, 'TSHIRT-BASIC-RED-L'), -- Basic T-Shirt, Red, L
(100003, 1001, 1200.00, 50, 'LAPTOP-PRO-MODEL-A'); -- Laptop Pro

-- Insert data into product_variation table (Linking product_items to variations)
INSERT INTO product_variation (product_variation_id, product_item_id, color_id, size_option_id) VALUES
(1, 100001, 2, 11), -- T-Shirt Blue M
(2, 100002, 1, 12); -- T-Shirt Red L
-- Laptop Pro (100003) might not have color/size variations, so no entry needed here unless other variation types exist

-- Insert data into attribute_type table
INSERT INTO attribute_type (attribute_type_id, type_name) VALUES
(1, 'Text'),
(2, 'Number'),
(3, 'Boolean');

-- Insert data into attribute_category table
INSERT INTO attribute_category (attribute_category_id, category_name) VALUES
(1, 'Technical Specifications'),
(2, 'Physical Properties');

-- Insert data into product_attribute table
INSERT INTO product_attribute (product_attribute_id, product_id, attribute_category_id, attribute_type_id, attribute_name, attribute_value) VALUES
(1, 1001, 1, 1, 'Processor', 'Intel Core i7'),
(2, 1001, 1, 2, 'RAM (GB)', '16'),
(3, 1002, 2, 1, 'Material', 'Cotton'),
(4, 1003, 2, 2, 'Weight (g)', '100');


-- --- Test Queries ---

-- Select all products with their brand and category
SELECT
    p.product_name,
    b.brand_name,
    pc.category_name,
    p.base_price
FROM product p
JOIN brand b ON p.brand_id = b.brand_id
JOIN product_category pc ON p.category_id = pc.category_id;

-- Select product items for a specific product (e.g., Basic T-Shirt)
SELECT
    pi.sku,
    pi.price,
    pi.quantity_in_stock,
    c.color_name,
    so.size_value
FROM product_item pi
JOIN product pr ON pi.product_id = pr.product_id
LEFT JOIN product_variation pv ON pi.product_item_id = pv.product_item_id
LEFT JOIN color c ON pv.color_id = c.color_id
LEFT JOIN size_option so ON pv.size_option_id = so.size_option_id
WHERE pr.product_name = 'Basic T-Shirt';

-- Select all images for a specific product (e.g., Laptop Pro)
SELECT
    image_url,
    is_main_image
FROM product_image
WHERE product_id = (SELECT product_id FROM product WHERE product_name = 'Laptop Pro');

-- Select all attributes for a specific product (e.g., Laptop Pro)
SELECT
    pa.attribute_name,
    pa.attribute_value,
    at.type_name AS attribute_type,
    ac.category_name AS attribute_category
FROM product_attribute pa
JOIN attribute_type at ON pa.attribute_type_id = at.attribute_type_id
JOIN attribute_category ac ON pa.attribute_category_id = ac.attribute_category_id
WHERE pa.product_id = (SELECT product_id FROM product WHERE product_name = 'Laptop Pro');

-- Select categories and their parent categories
SELECT
    pc1.category_name AS category,
    pc2.category_name AS parent_category
FROM product_category pc1
LEFT JOIN product_category pc2 ON pc1.parent_category_id = pc2.category_id;

--update price of a product
UPDATE product
SET base_price = 4500
WHERE product_id = 1;

--modify name of a product
UPDATE brand
SET brand_name = 'Adidas'
WHERE brand_id = 1;

--retrieve products with attributes
SELECT p.product_name, pa.attribute_name, pa.attribute_value
FROM product_attribute pa
INNER JOIN product p ON pa.product_id = p.product_id;
