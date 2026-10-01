# E-Commerce Order Management & Sales Analytics Database

## 📌 Project Overview

This project is a relational E-Commerce Order Management and Sales Analytics Database developed using Microsoft SQL Server and T-SQL.

The database manages customers, products, categories, orders, order items, and payments while providing business insights through SQL-based analysis.

The project demonstrates practical SQL skills including database design, constraints, JOINs, subqueries, CTEs, window functions, views, stored procedures, transactions, triggers, indexing, and query performance analysis.

---

## 🎯 Project Objectives

- Design a relational e-commerce database
- Manage customers, products, orders, and payments
- Implement primary and foreign key relationships
- Apply data integrity constraints
- Analyze customer purchasing behavior
- Analyze product and category performance
- Generate sales and revenue insights
- Create reusable database views
- Develop stored procedures
- Demonstrate transaction management
- Implement triggers for auditing and validation
- Improve query performance using indexes
- Analyze query execution using SQL Server execution plans

---

## 🛠️ Technologies Used

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- T-SQL
- GitHub

---

## 🗄️ Database Structure

### Customers
Stores customer information.

- customer_id — Primary Key
- customer_name
- email — Unique
- city
- registration_date

### Categories
Stores product category information.

- category_id — Primary Key
- category_name — Unique

### Products
Stores product information.

- product_id — Primary Key
- product_name
- category_id — Foreign Key
- price
- stock

### Orders
Stores customer order information.

- order_id — Primary Key
- customer_id — Foreign Key
- order_date
- order_status

### Order_Items
Stores products included in each order.

- order_item_id — Primary Key
- order_id — Foreign Key
- product_id — Foreign Key
- quantity
- unit_price

### Payments
Stores payment information.

- payment_id — Primary Key
- order_id — Foreign Key
- payment_date
- amount
- payment_method
- payment_status

---

## 🔗 Table Relationships

```text
Customers
    |
    | 1-to-Many
    ↓
Orders
    |
    | 1-to-Many
    ↓
Order_Items
    |
    | Many-to-1
    ↓
Products
    |
    | Many-to-1
    ↓
Categories

Orders
    |
    | Payment associated with an order
    ↓
Payments
