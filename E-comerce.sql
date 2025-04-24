-- Create the database
CREATE DATABASE ecomercedb;

-- Use the created database
USE ecomercedb;

-- Create the brand table
CREATE TABLE brand (
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL UNIQUE
);

-- Create the product_category table
CREATE TABLE product_category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    parent_category_id INT NULL,
    FOREIGN KEY (parent_category_id) REFERENCES product_category(category_id)
);

-- Create the product table
CREATE TABLE product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    base_price DECIMAL(10, 2) NOT NULL,
    brand_id INT,
    category_id INT,
    description TEXT,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

-- Create the product_image table
CREATE TABLE product_image (
    image_id INT PRIMARY KEY,
    product_id INT,
    image_url VARCHAR(255) NOT NULL,
    is_main_image BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
);

-- Create the product_item table
CREATE TABLE product_item (
    product_item_id INT PRIMARY KEY,
    product_id INT,
    price DECIMAL(10, 2) NOT NULL,
    quantity_in_stock INT NOT NULL DEFAULT 0,
    sku VARCHAR(50) UNIQUE,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
);

-- Create the color table
CREATE TABLE color (
    color_id INT PRIMARY KEY,
    color_name VARCHAR(50) NOT NULL UNIQUE,
    hex_code VARCHAR(7) UNIQUE
);

-- Create the size_category table
CREATE TABLE size_category (
    size_category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- Create the size_option table
CREATE TABLE size_option (
    size_option_id INT PRIMARY KEY,
    size_category_id INT,
    size_value VARCHAR(50) NOT NULL,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

-- Create the product_variation table
CREATE TABLE product_variation (
    product_variation_id INT PRIMARY KEY,
    product_item_id INT,
    color_id INT NULL,
    size_option_id INT NULL,
    FOREIGN KEY (product_item_id) REFERENCES product_item(product_item_id) ON DELETE CASCADE,
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id)
);

-- Create the attribute_type table
CREATE TABLE attribute_type (
    attribute_type_id INT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE
);

-- Create the attribute_category table
CREATE TABLE attribute_category (
    attribute_category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- Create the product_attribute table
CREATE TABLE product_attribute (
    product_attribute_id INT PRIMARY KEY,
    product_id INT,
    attribute_category_id INT,
    attribute_type_id INT,
    attribute_name VARCHAR(100) NOT NULL,
    attribute_value TEXT,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE,
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id)
);
