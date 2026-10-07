# 🍽️ Zomato SQL Analytics & Database Design

An end-to-end **PostgreSQL analytics project** that models a food-delivery platform and uses SQL to analyze customer behavior, restaurant performance, revenue trends, menu-item popularity, payments, and delivery operations.

The project demonstrates practical skills in **relational database design, SQL analytics, CTEs, subqueries, joins, window functions, customer segmentation, business analysis, and query optimization**.

---

## 🎯 Project Objective

The objective of this project is to design a relational database for a food-delivery platform and use SQL to answer business questions such as:

- Which restaurants generate the highest revenue?
- Who are the highest-value customers?
- Which cuisines and menu items are most popular?
- Which cities generate the most revenue?
- What is the order cancellation rate?
- How efficiently are delivery partners performing?
- Which payment methods are most frequently used?
- How does revenue change month over month?
- What percentage of customers place repeat orders?

---

## 🛠️ Tech Stack

- PostgreSQL 18
- SQL
- Mac Terminal
- Git
- GitHub
- Mermaid ER Diagram

---

## 🗄️ Database Design

The database contains **10 relational tables**:

| Table | Purpose |
|---|---|
| `locations` | Stores city and area information |
| `customers` | Stores customer information |
| `restaurants` | Stores restaurant information |
| `menu_items` | Stores restaurant menu items |
| `orders` | Stores customer orders |
| `order_items` | Stores items associated with each order |
| `payments` | Stores payment information |
| `delivery_partners` | Stores delivery partner details |
| `deliveries` | Tracks order delivery information |
| `reviews` | Stores customer restaurant reviews |

---

## 🔗 Key Relationships

- One location can contain multiple restaurants.
- One customer can place multiple orders.
- One restaurant can receive multiple orders.
- One restaurant can offer multiple menu items.
- One order can contain multiple order items.
- One menu item can appear in multiple order items.
- One order can have one payment.
- One order can have one delivery.
- One delivery partner can handle multiple deliveries.
- One customer can write multiple reviews.
- One restaurant can receive multiple reviews.

---

## 🧩 ER Diagram

The complete database ER diagram is available here:

[`docs/ER_Diagram.md`](docs/ER_Diagram.md)

The schema uses **Primary Keys, Foreign Keys, UNIQUE constraints, NOT NULL constraints, CHECK constraints, and referential relationships** to maintain data integrity.

---

## 📂 Project Structure

```text
zomato-sql-analytics/
│
├── database/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_insert_data.sql
│   ├── 04_indexes.sql
│   └── 05_validation.sql
│
├── analysis/
│   ├── 01_basic_queries.sql
│   ├── 02_advanced_queries.sql
│   └── 03_business_insights.sql
│
├── data/
├── docs/
│   └── ER_Diagram.md
│
├── images/
└── README.md
```

---

## 📊 SQL Analysis

### Basic Analysis

The basic analysis covers:

- Total customers
- Total restaurants
- Total orders
- Total revenue
- Average order value
- Order status distribution
- Payment method usage
- Revenue by restaurant
- Top customers by spending
- Popular menu items
- Monthly revenue
- Revenue by city

SQL file:

[`analysis/01_basic_queries.sql`](analysis/01_basic_queries.sql)

---

## 🚀 Advanced SQL Analysis

The advanced analysis demonstrates:

- Common Table Expressions (CTEs)
- Subqueries
- `CASE` statements
- `HAVING`
- Multi-table joins
- Aggregate functions
- `ROW_NUMBER()`
- `RANK()`
- `DENSE_RANK()`
- `LAG()`
- `PARTITION BY`
- PostgreSQL `FILTER`
- Date and time calculations

SQL file:

[`analysis/02_advanced_queries.sql`](analysis/02_advanced_queries.sql)

---

## 💼 Business Analysis

The project answers practical business questions involving:

### Restaurant Performance

Analyze restaurant revenue, order volume, ratings, cuisine performance, and revenue contribution.

### Customer Analytics

Identify high-value customers, repeat customers, customer spending patterns, and customer segments.

### Revenue Analytics

Analyze total revenue, average order value, monthly revenue, and month-over-month revenue growth.

### Menu Analysis

Identify popular menu items and analyze item-level sales.

### Delivery Analytics

Measure delivery-partner performance and average delivery times.

### Payment Analytics

Analyze payment-method usage, completed transactions, refunds, and payment success rates.

SQL file:

[`analysis/03_business_insights.sql`](analysis/03_business_insights.sql)

---

## 📈 Key KPIs

The analysis calculates business KPIs including:

- Total Orders
- Delivered Orders
- Cancelled Orders
- Total Revenue
- Average Order Value
- Delivery Success Rate
- Cancellation Rate
- Repeat Customer Percentage
- Payment Success Rate
- Average Delivery Time

---

## 👥 Customer Segmentation

Customers are segmented according to total spending:

| Segment | Total Spending |
|---|---:|
| High Value | ₹800+ |
| Medium Value | ₹400–₹799.99 |
| Low Value | Below ₹400 |

This segmentation can help identify customers for loyalty programs, targeted promotions, and retention campaigns.

---

## ⚡ Database Optimization

Indexes are created on frequently joined and filtered columns such as:

- Customer ID
- Restaurant ID
- Location ID
- Order Date
- Order Status
- Delivery Partner ID
- Menu Item ID

A composite index is also created for restaurant and order-status analysis.

SQL file:

[`database/04_indexes.sql`](database/04_indexes.sql)

---

## ✅ Data Validation

Validation queries are included to check:

- Table creation
- Row counts
- Customer-order-restaurant relationships
- Orphan order items
- Orphan payments
- Order totals against calculated item totals

SQL file:

[`database/05_validation.sql`](database/05_validation.sql)

---

## ▶️ How to Run the Project

### 1. Clone the repository

```bash
git clone https://github.com/chandraAkiran/zomato-sql-analytics.git
cd zomato-sql-analytics
```

### 2. Create the database

```bash
psql -U postgres -d postgres -f database/01_create_database.sql
```

### 3. Create the tables

```bash
psql -U postgres -d zomato_db -f database/02_create_tables.sql
```

### 4. Insert sample data

```bash
psql -U postgres -d zomato_db -f database/03_insert_data.sql
```

### 5. Create indexes

```bash
psql -U postgres -d zomato_db -f database/04_indexes.sql
```

### 6. Validate the database

```bash
psql -U postgres -d zomato_db -f database/05_validation.sql
```

### 7. Run the analysis

```bash
psql -U postgres -d zomato_db -f analysis/01_basic_queries.sql

psql -U postgres -d zomato_db -f analysis/02_advanced_queries.sql

psql -U postgres -d zomato_db -f analysis/03_business_insights.sql
```

---

## 🧠 SQL Skills Demonstrated

`SELECT` • `WHERE` • `GROUP BY` • `ORDER BY` • `HAVING` • `LIMIT` • `CASE` • `JOIN` • `LEFT JOIN` • Subqueries • CTEs • Aggregate Functions • Window Functions • `ROW_NUMBER()` • `RANK()` • `DENSE_RANK()` • `LAG()` • `PARTITION BY` • PostgreSQL `FILTER` • Date Functions • Indexes • PK/FK Constraints

---

## 🔮 Future Improvements

- Build a Power BI dashboard
- Add larger realistic datasets
- Perform customer cohort analysis
- Add RFM customer segmentation
- Analyze restaurant retention
- Add delivery SLA analysis
- Add stored procedures and views
- Compare query performance using `EXPLAIN ANALYZE`

---

## 👤 Author

**Chandra Akash Kiran**

Data Analytics | Data Science | SQL | Python | Power BI | Machine Learning

GitHub: `chandraAkiran`

---

## 📌 Disclaimer

This is a portfolio and educational project. The dataset used in this repository is sample/synthetic data created for SQL analysis and does not represent official Zomato data.
