-- Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    addresss VARCHAR(255)
);
-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2)
);
-- Create Categories table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);
-- Create Order_Items table
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Task1
SELECT c.customer_id, c.name, c.email, c.location, COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.email, c.location
ORDER BY total_orders DESC;


-- Task2
SELECT o.order_id, p.name AS product_name, oi.quantity, (oi.quantity * oi.unit_price) AS total_amount
FROM Order_Items oi
JOIN Orders o ON oi.order_id = o.order_id
JOIN Products p ON oi.product_id = p.product_id
ORDER BY o.order_id ASC;

-- Task3
SELECT c.name AS category_name, SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY c.name
ORDER BY total_revenue DESC;


-- Task4
SELECT c.name AS customer_name, SUM(oi.quantity * oi.unit_price) AS total_purchase_amount
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY c.name
ORDER BY total_purchase_amount DESC
LIMIT 5;
