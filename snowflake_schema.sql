-- Create dimension tables


CREATE TABLE dim_category (
    category_id INT,
    category_name VARCHAR(50),
    PRIMARY KEY (category_id)
);

CREATE TABLE dim_brand (
    brand_id INT,
    brand_name VARCHAR(100),
    PRIMARY KEY (brand_id)
);

CREATE TABLE dim_product (
    product_id INT,
    product_name VARCHAR(100),
    category_id INT,
    brand_id INT,
    PRIMARY KEY (product_id),
    FOREIGN KEY (category_id) REFERENCES dim_category(category_id),
    FOREIGN KEY (brand_id) REFERENCES dim_brand(brand_id)
);



CREATE TABLE dim_store (
    store_id INT,
    store_name VARCHAR(100),
    location VARCHAR(100),
    PRIMARY KEY (store_id)
);

CREATE TABLE dim_customer (
    customer_id INT,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    PRIMARY KEY (customer_id)
);

CREATE TABLE dim_date (
    date_id INT,
    date_value DATE,
    day_of_week INT,
    month INT,
    year INT,
    PRIMARY KEY (date_id)
);

CREATE TABLE dim_product_subcategory (
    subcategory_id INT,
    subcategory_name VARCHAR(50),
    category_id INT,
    PRIMARY KEY (subcategory_id),
    FOREIGN KEY (category_id) REFERENCES dim_category(category_id)
);

-- Create fact table
CREATE TABLE fact_sales (
    sale_id INT,
    product_id INT,
    store_id INT,
    customer_id INT,
    date_id INT,
    quantity INT,
    amount DECIMAL(10,2),
    PRIMARY KEY (sale_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);



-- Insert data into dim_category
INSERT INTO dim_category (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books');

-- Insert data into dim_brand
INSERT INTO dim_brand (brand_id, brand_name) VALUES
(1, 'Sony'),
(2, 'Samsung'),
(3, 'Nike'),
(4, 'Adidas'),
(5, 'Penguin Books'),
(6, 'HarperCollins');

-- Insert data into dim_product
INSERT INTO dim_product (product_id, product_name, category_id, brand_id) VALUES
(1, 'Sony TV', 1, 1),
(2, 'Samsung Phone', 1, 2),
(3, 'Nike Shoes', 2, 3),
(4, 'Adidas T-Shirt', 2, 4),
(5, 'Harry Potter Book', 3, 5),
(6, 'To Kill a Mockingbird', 3, 6);

-- Insert data into dim_store
INSERT INTO dim_store (store_id, store_name, location) VALUES
(1, 'Electronics Emporium', 'New York'),
(2, 'Fashion Haven', 'Los Angeles'),
(3, 'Bookworm Central', 'Chicago');

-- Insert data into dim_customer
INSERT INTO dim_customer (customer_id, customer_name, email) VALUES
(1, 'John Doe', 'john@example.com'),
(2, 'Jane Smith', 'jane@example.com'),
(3, 'Alice Johnson', 'alice@example.com');

-- Insert data into dim_date
INSERT INTO dim_date (date_id, date_value, day_of_week, month, year) VALUES
(1, '2024-02-10', 4, 2, 2024),
(2, '2024-02-09', 3, 2, 2024),
(3, '2024-02-08', 2, 2, 2024);

-- Insert data into dim_product_subcategory
INSERT INTO dim_product_subcategory (subcategory_id, subcategory_name, category_id) VALUES
(1, 'Televisions', 1),
(2, 'Phones', 1),
(3, 'Shoes', 2),
(4, 'Clothing', 2),
(5, 'Fiction', 3),
(6, 'Non-Fiction', 3);

-- Insert data into fact_sales
INSERT INTO fact_sales (sale_id, product_id, store_id, customer_id, date_id, quantity, amount) VALUES
(1, 1, 1, 1, 1, 1, 500.00),
(2, 2, 1, 2, 1, 2, 1000.00),
(3, 3, 2, 3, 2, 1, 150.00),
(4, 4, 2, 1, 3, 3, 120.00),
(5, 5, 3, 2, 1, 1, 15.00),
(6, 6, 3, 3, 2, 2, 30.00);



----Basic query for retrive data:
SELECT
    dc.category_name,
    SUM(fs.amount) AS total_sales_amount,
    SUM(fs.quantity) AS total_quantity_sold
FROM
    fact_sales fs
INNER JOIN dim_product dp ON fs.product_id = dp.product_id
INNER JOIN dim_category dc ON dp.category_id = dc.category_id
GROUP BY
    dc.category_name;
