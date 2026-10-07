# 🍽️ Zomato SQL Analytics & Interactive Dashboard

An end-to-end **SQL Analytics and Business Intelligence portfolio project** built using **PostgreSQL, Neon Cloud, Python, Pandas, Plotly, and Streamlit**.

This project models a food-delivery platform and uses SQL and interactive visualizations to analyze **customer behavior, restaurant performance, revenue trends, menu-item popularity, payments, and delivery operations**.

The project demonstrates practical skills in **relational database design, SQL analytics, CTEs, subqueries, joins, window functions, customer segmentation, business analysis, cloud databases, Python analytics, and interactive dashboard development**.

---

## 🚀 Live Project

### 🌐 Interactive Streamlit Dashboard

[View Live Zomato SQL Analytics Dashboard](https://zomato-sql-analytics.streamlit.app)

### 💻 GitHub Repository

[View Source Code](https://github.com/chandraAkiran/zomato-sql-analytics)

### ☁️ Cloud Database

The application uses **Neon PostgreSQL** as the cloud-hosted relational database.

---

## 📊 Dashboard Features

The Streamlit dashboard provides an interactive interface for exploring the food-delivery dataset and its business KPIs.

### 🎛️ Interactive Filters

Users can dynamically filter the dashboard by:

- City
- Cuisine
- Order Status

### 📌 Executive KPIs

The dashboard displays:

- Total Orders
- Delivered Orders
- Delivered Revenue
- Average Order Value
- Cancellation Rate

### 📈 Interactive Analytics

The dashboard includes:

- Monthly Revenue Trend
- Revenue by City
- Order Status Distribution
- Orders by Cuisine
- Restaurant Revenue Ranking
- Customer Spending Analysis
- Customer Leaderboard
- Delivery Partner Performance
- Payment Method Analysis
- Interactive Raw Data Explorer

All visualizations are built using **Plotly** and respond dynamically to dashboard filters.

---

## 📈 Key Business Results

| KPI | Result |
|---|---:|
| Total Orders | 12 |
| Delivered Orders | 9 |
| Delivered Revenue | ₹3,950 |
| Average Order Value | ₹438.89 |
| Cancellation Rate | 8.33% |
| Top Restaurant | Biryani House |
| Top Restaurant Revenue | ₹1,310 |
| Top Revenue City | Bengaluru |
| Most Popular Menu Item | Chicken Biryani |

> The project uses a small synthetic dataset created specifically for educational and portfolio demonstration purposes.

---

## 💡 Key Business Insights

### 🏆 Restaurant Performance

**Biryani House** generated the highest delivered revenue at approximately **₹1,310**, followed by Pizza Hub and Spice Garden.

Restaurant revenue ranking:

| Restaurant | Delivered Revenue |
|---|---:|
| Biryani House | ₹1,310 |
| Pizza Hub | ₹950 |
| Spice Garden | ₹900 |
| South Delight | ₹460 |
| Urban Cafe | ₹330 |

---

### 🏙️ City Performance

The analysis shows that **Bengaluru generated more delivered revenue than Hyderabad**.

| City | Delivered Revenue |
|---|---:|
| Bengaluru | ₹2,310 |
| Hyderabad | ₹1,640 |

This information could help a food-delivery platform identify stronger markets and prioritize restaurant acquisition, promotions, and delivery resources.

---

### 👥 Customer Analysis

The highest-value customers based on delivered order spending include:

| Customer | Total Spending |
|---|---:|
| Priya Reddy | ₹860 |
| Aarav Sharma | ₹850 |
| Vikram Kumar | ₹700 |
| Rahul Verma | ₹500 |
| Neha Singh | ₹500 |

Customer segmentation is also performed using SQL based on total spending.

---

### 🍛 Menu Performance

**Chicken Biryani** is the most frequently ordered delivered menu item in the sample dataset.

Menu-item analysis helps identify:

- High-demand dishes
- Popular restaurant offerings
- Customer food preferences
- Potential promotional opportunities

---

### 🚴 Delivery Performance

Delivery-partner performance is analyzed using:

- Number of completed deliveries
- Average delivery time
- Delivery ranking

This helps identify efficient delivery partners and potential delivery SLA improvements.

---

### 💳 Payment Analysis

The project analyzes payment-method usage and transaction success.

Payment methods include:

- UPI
- Credit Card
- Debit Card
- Cash on Delivery
- Wallet

UPI is the most frequently used payment method in the sample dataset.

---

## 🎯 Project Objective

The objective of this project is to design a normalized relational database for a food-delivery platform and use SQL and interactive analytics to answer practical business questions such as:

- Which restaurants generate the highest revenue?
- Who are the highest-value customers?
- Which cuisines are most popular?
- Which menu items are ordered most frequently?
- Which cities generate the most revenue?
- What is the order cancellation rate?
- How efficiently are delivery partners performing?
- Which payment methods are most frequently used?
- How does revenue change month over month?
- Which customers place repeat orders?
- How can customers be segmented according to spending?

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| PostgreSQL | Relational database |
| Neon | Cloud PostgreSQL hosting |
| SQL | Data analysis and business queries |
| Python | Dashboard application |
| Pandas | Data manipulation and aggregation |
| Plotly | Interactive data visualizations |
| Streamlit | Interactive analytics dashboard |
| Git | Version control |
| GitHub | Source-code hosting |
| Mermaid | ER diagram |

---

## 🏗️ Project Architecture

```text
                    GitHub
                       │
                       │ Source Code
                       ▼
             Streamlit Community Cloud
                       │
                       │ SQL / Database Queries
                       ▼
                 Neon PostgreSQL
                       │
                       ▼
                Relational Database
                       │
                       ▼
              SQL Analytics Layer
                       │
                       ▼
          Pandas + Plotly Visualizations
                       │
                       ▼
             Interactive Dashboard
```

---

## 🗄️ Database Design

The database contains **10 relational tables**.

| Table | Purpose |
|---|---|
| `locations` | Stores city and area information |
| `customers` | Stores customer information |
| `restaurants` | Stores restaurant information |
| `menu_items` | Stores restaurant menu items |
| `orders` | Stores customer orders |
| `order_items` | Stores items associated with each order |
| `payments` | Stores payment information |
| `delivery_partners` | Stores delivery-partner information |
| `deliveries` | Tracks delivery operations |
| `reviews` | Stores customer restaurant reviews |

---

## 🔗 Database Relationships

The relational schema contains the following major relationships:

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

Primary keys and foreign keys are used to maintain **referential integrity** across the database.

---

## 🧩 ER Diagram

The complete Entity Relationship Diagram is available here:

[`docs/ER_Diagram.md`](docs/ER_Diagram.md)

The database schema uses:

- Primary Keys
- Foreign Keys
- UNIQUE constraints
- NOT NULL constraints
- CHECK constraints
- Referential relationships

---

## 📂 Project Structure

```text
zomato-sql-analytics/
│
├── app/
│   └── app.py
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
├── docs/
│   └── ER_Diagram.md
│
├── .gitignore
├── requirements.txt
└── README.md
```

---

# 📊 SQL Analysis

The project contains three levels of SQL analysis.

---

## 1️⃣ Basic SQL Analysis

File:

[`analysis/01_basic_queries.sql`](analysis/01_basic_queries.sql)

The basic analysis covers:

- View all customers
- Total customers
- Total restaurants
- Total orders
- Total delivered revenue
- Average order value
- Order-status distribution
- Payment-method usage
- Revenue by restaurant
- Top restaurants
- Orders by cuisine
- Customer spending
- Top customers
- Restaurant ratings
- Popular menu items
- Monthly revenue
- Orders by city
- Revenue by city

### SQL Concepts

```sql
SELECT
WHERE
COUNT()
SUM()
AVG()
ROUND()
GROUP BY
ORDER BY
LIMIT
JOIN
LEFT JOIN
```

---

# 🚀 Advanced SQL Analysis

File:

[`analysis/02_advanced_queries.sql`](analysis/02_advanced_queries.sql)

The advanced SQL layer demonstrates:

- Common Table Expressions
- Subqueries
- CASE statements
- HAVING
- Multi-table JOINs
- Aggregate functions
- Window functions
- Ranking functions
- Revenue growth analysis
- Customer segmentation
- Delivery-performance analysis

### Window Functions Used

```sql
ROW_NUMBER()
RANK()
DENSE_RANK()
LAG()
PARTITION BY
```

### Other PostgreSQL Features

```sql
FILTER
DATE_TRUNC()
EXTRACT()
NULLIF()
COALESCE()
```

---

## 💼 Business Insights Analysis

File:

[`analysis/03_business_insights.sql`](analysis/03_business_insights.sql)

This layer converts SQL queries into practical business analysis.

### Restaurant Analytics

- Restaurant revenue
- Restaurant order volume
- Restaurant ratings
- Cuisine performance
- Revenue contribution

### Customer Analytics

- Highest-value customers
- Customer spending
- Repeat customers
- Customer segmentation

### Revenue Analytics

- Total delivered revenue
- Average order value
- Monthly revenue
- Month-over-month growth
- Revenue by city

### Menu Analytics

- Popular menu items
- Item-level quantity sold
- Menu revenue

### Delivery Analytics

- Delivery-partner performance
- Completed deliveries
- Average delivery time

### Payment Analytics

- Payment-method usage
- Completed transactions
- Refunds
- Payment success rates

---

## 👥 Customer Segmentation

Customers are segmented according to total delivered spending.

| Segment | Spending |
|---|---:|
| High Value | ₹800+ |
| Medium Value | ₹400 – ₹799.99 |
| Low Value | Below ₹400 |

Example SQL logic:

```sql
CASE
    WHEN total_spent >= 800 THEN 'High Value'
    WHEN total_spent >= 400 THEN 'Medium Value'
    ELSE 'Low Value'
END
```

This segmentation could support:

- Loyalty programs
- Personalized promotions
- Customer-retention strategies
- High-value customer targeting

---

## 📅 Monthly Revenue Analysis

Delivered revenue is analyzed by month.

| Month | Revenue |
|---|---:|
| May 2026 | ₹1,720 |
| June 2026 | ₹1,980 |
| July 2026 | ₹250 |

The advanced SQL analysis also uses `LAG()` to calculate month-over-month revenue changes.

---

## ⚡ Database Optimization

Indexes are created on frequently joined and filtered columns.

Examples include:

- Customer ID
- Restaurant ID
- Location ID
- Order Date
- Order Status
- Delivery Partner ID
- Menu Item ID

A composite index is also included for restaurant/order-status analysis.

SQL file:

[`database/04_indexes.sql`](database/04_indexes.sql)

Example:

```sql
CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

CREATE INDEX idx_orders_restaurant_id
ON orders(restaurant_id);

CREATE INDEX idx_orders_order_date
ON orders(order_date);

CREATE INDEX idx_orders_restaurant_status
ON orders(restaurant_id, order_status);
```

---

## ✅ Data Validation

The project contains dedicated validation queries.

File:

[`database/05_validation.sql`](database/05_validation.sql)

Validation includes:

- Verifying table creation
- Checking row counts
- Testing customer-order-restaurant relationships
- Checking orphan order items
- Checking orphan payments
- Comparing order totals with calculated item totals

### Validation Results

The final database contains:

| Table | Rows |
|---|---:|
| Locations | 5 |
| Customers | 8 |
| Restaurants | 5 |
| Menu Items | 15 |
| Orders | 12 |
| Order Items | 18 |
| Payments | 12 |
| Delivery Partners | 4 |
| Deliveries | 10 |
| Reviews | 9 |

The validation tests returned:

```text
Orphan Order Items = 0
Orphan Payments    = 0
```

All order totals also matched their calculated item totals.

---

# ▶️ Running the Project Locally

## 1. Clone the Repository

```bash
git clone https://github.com/chandraAkiran/zomato-sql-analytics.git
cd zomato-sql-analytics
```

---

## 2. Create the Local PostgreSQL Database

```bash
psql -U postgres -d postgres \
-f database/01_create_database.sql
```

---

## 3. Create the Tables

```bash
psql -U postgres -d zomato_db \
-f database/02_create_tables.sql
```

---

## 4. Insert Sample Data

```bash
psql -U postgres -d zomato_db \
-f database/03_insert_data.sql
```

---

## 5. Create Indexes

```bash
psql -U postgres -d zomato_db \
-f database/04_indexes.sql
```

---

## 6. Validate the Database

```bash
psql -U postgres -d zomato_db \
-f database/05_validation.sql
```

---

## 7. Run SQL Analysis

### Basic Queries

```bash
psql -U postgres -d zomato_db \
-f analysis/01_basic_queries.sql
```

### Advanced Queries

```bash
psql -U postgres -d zomato_db \
-f analysis/02_advanced_queries.sql
```

### Business Insights

```bash
psql -U postgres -d zomato_db \
-f analysis/03_business_insights.sql
```

---

# 🖥️ Running the Streamlit Dashboard Locally

## 1. Install Dependencies

```bash
pip install -r requirements.txt
```

---

## 2. Configure Database Connection

Set the PostgreSQL connection string as an environment variable.

macOS/Linux:

```bash
export DATABASE_URL='YOUR_POSTGRESQL_CONNECTION_STRING'
```

> Never commit your database password or connection string to GitHub.

---

## 3. Start Streamlit

```bash
streamlit run app/app.py
```

Then open:

```text
http://localhost:8501
```

---

# ☁️ Cloud Deployment

The project uses a cloud-based architecture.

### Database

**Neon PostgreSQL** hosts the relational database.

### Dashboard

**Streamlit Community Cloud** hosts the interactive analytics application.

### Source Code

**GitHub** stores the application, SQL scripts, documentation, and database design.

The database credentials are configured securely using deployment secrets and are **not stored in the repository**.

---

## 📦 Python Dependencies

The dashboard uses:

```text
streamlit
pandas
plotly
psycopg2-binary
sqlalchemy
```

These dependencies are defined in:

```text
requirements.txt
```

---

# 🧠 Skills Demonstrated

## SQL

`SELECT` • `WHERE` • `GROUP BY` • `ORDER BY` • `HAVING` • `LIMIT` • `CASE` • `JOIN` • `LEFT JOIN` • Subqueries • CTEs • Aggregate Functions • Window Functions • `ROW_NUMBER()` • `RANK()` • `DENSE_RANK()` • `LAG()` • `PARTITION BY` • PostgreSQL `FILTER` • Date Functions

## Database

- Relational Database Design
- Primary Keys
- Foreign Keys
- Referential Integrity
- Constraints
- Indexing
- Data Validation
- Query Optimization

## Python & Analytics

- Python
- Pandas
- Data Aggregation
- Database Connectivity
- Interactive Analytics

## Visualization

- Plotly
- KPI Cards
- Bar Charts
- Line/Area Charts
- Donut Charts
- Interactive Filters

## Deployment

- Neon PostgreSQL
- Streamlit Community Cloud
- Git
- GitHub

---

# 💼 Portfolio Highlights

This project demonstrates an end-to-end analytics workflow:

```text
Business Problem
      ↓
Relational Database Design
      ↓
PostgreSQL Implementation
      ↓
Data Validation
      ↓
SQL Analysis
      ↓
Advanced SQL
      ↓
Business Insights
      ↓
Cloud PostgreSQL
      ↓
Python / Pandas
      ↓
Interactive Streamlit Dashboard
      ↓
Cloud Deployment
```

It demonstrates both **technical SQL capability** and the ability to convert data into **business-facing analytics and visualizations**.

---

# 🔮 Future Improvements

Potential future enhancements include:

- Add a larger realistic dataset
- Add date-range filtering
- Add restaurant-level filters
- Add customer cohort analysis
- Add RFM customer segmentation
- Add restaurant retention analysis
- Add delivery SLA monitoring
- Add geographic analysis
- Add SQL views
- Add stored procedures
- Add materialized views
- Compare query performance using `EXPLAIN ANALYZE`
- Add automated ETL pipeline
- Add Power BI dashboard
- Add predictive customer analytics

---

# 👤 Author

## Chandra Akash Kiran

**Data Analytics | Data Science | SQL | Python | Power BI | Machine Learning**

GitHub: [chandraAkiran](https://github.com/chandraAkiran)

### Live Project

🌐 [Zomato SQL Analytics Dashboard](https://zomato-sql-analytics.streamlit.app)

💻 [GitHub Repository](https://github.com/chandraAkiran/zomato-sql-analytics)

---

# 📌 Disclaimer

This project is created for **educational and portfolio purposes**.

The dataset used in this repository is **sample/synthetic data** and does not represent official Zomato data.

The project is not affiliated with or endorsed by Zomato.

---

⭐ If you find this project useful, consider starring the repository.
