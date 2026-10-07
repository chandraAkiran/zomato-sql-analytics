import os
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
import psycopg2
import streamlit as st


# =========================================================
# PAGE CONFIG
# =========================================================
st.set_page_config(
    page_title="Zomato Analytics Dashboard",
    page_icon="🍽️",
    layout="wide",
    initial_sidebar_state="expanded"
)


# =========================================================
# PROFESSIONAL CSS
# =========================================================
st.markdown("""
<style>

/* Main page */
.block-container {
    padding-top: 1.5rem;
    padding-bottom: 2rem;
}

/* Header */
.dashboard-title {
    font-size: 2.25rem;
    font-weight: 800;
    margin-bottom: 0;
}

.dashboard-subtitle {
    font-size: 1rem;
    opacity: 0.7;
    margin-bottom: 1.5rem;
}

/* KPI cards */
.kpi-card {
    padding: 20px;
    border-radius: 16px;
    border: 1px solid rgba(128,128,128,0.20);
    box-shadow: 0 4px 14px rgba(0,0,0,0.08);
    margin-bottom: 10px;
}

.kpi-label {
    font-size: 0.85rem;
    opacity: 0.70;
    font-weight: 600;
}

.kpi-value {
    font-size: 1.65rem;
    font-weight: 800;
    margin-top: 5px;
}

.kpi-green {
    border-top: 4px solid #16a34a;
}

.kpi-blue {
    border-top: 4px solid #2563eb;
}

.kpi-orange {
    border-top: 4px solid #f59e0b;
}

.kpi-red {
    border-top: 4px solid #ef4444;
}

.kpi-purple {
    border-top: 4px solid #8b5cf6;
}

/* Section headers */
.section-title {
    font-size: 1.25rem;
    font-weight: 700;
    margin-top: 12px;
    margin-bottom: 10px;
}

/* Sidebar */
section[data-testid="stSidebar"] {
    border-right: 1px solid rgba(128,128,128,0.15);
}

/* Hide Streamlit footer */
footer {
    visibility: hidden;
}

</style>
""", unsafe_allow_html=True)


# =========================================================
# DATABASE CONNECTION
# =========================================================
@st.cache_resource
def get_connection():

    database_url = os.getenv("DATABASE_URL")

    if not database_url:
        try:
            database_url = st.secrets["DATABASE_URL"]
        except Exception:
            database_url = None

    if not database_url:
        st.error("Database connection is not configured.")
        st.stop()

    return psycopg2.connect(database_url)


conn = get_connection()


@st.cache_data(ttl=300)
def run_query(query, params=None):
    return pd.read_sql_query(
        query,
        conn,
        params=params
    )


# =========================================================
# SIDEBAR
# =========================================================
with st.sidebar:

    st.title("🍽️ Zomato Analytics")

    st.caption("SQL Analytics Portfolio")

    st.divider()

    st.markdown("### 🎛️ Dashboard Filters")

    city_options = run_query("""
        SELECT DISTINCT city
        FROM locations
        ORDER BY city;
    """)

    selected_cities = st.multiselect(
        "City",
        city_options["city"].tolist(),
        default=city_options["city"].tolist()
    )

    status_options = run_query("""
        SELECT DISTINCT order_status
        FROM orders
        ORDER BY order_status;
    """)

    selected_status = st.multiselect(
        "Order Status",
        status_options["order_status"].tolist(),
        default=status_options["order_status"].tolist()
    )

    cuisine_options = run_query("""
        SELECT DISTINCT cuisine_type
        FROM restaurants
        WHERE cuisine_type IS NOT NULL
        ORDER BY cuisine_type;
    """)

    selected_cuisines = st.multiselect(
        "Cuisine",
        cuisine_options["cuisine_type"].tolist(),
        default=cuisine_options["cuisine_type"].tolist()
    )

    st.divider()

    st.markdown("### ☁️ Data Source")

    st.success("Neon PostgreSQL Connected")

    st.caption(
        "Dashboard queries are executed directly "
        "against the cloud PostgreSQL database."
    )

    st.divider()

    if st.button("🔄 Refresh Dashboard", use_container_width=True):
        st.cache_data.clear()
        st.rerun()


# =========================================================
# LOAD MASTER DATA
# =========================================================
orders_df = run_query("""
SELECT
    o.order_id,
    o.order_date,
    o.order_status,
    o.total_amount,
    c.name AS customer_name,
    r.restaurant_name,
    r.cuisine_type,
    l.city
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id
JOIN locations l
    ON r.location_id = l.location_id;
""")


# =========================================================
# APPLY FILTERS
# =========================================================
filtered_df = orders_df[
    orders_df["city"].isin(selected_cities)
    & orders_df["order_status"].isin(selected_status)
    & orders_df["cuisine_type"].isin(selected_cuisines)
].copy()


delivered_df = filtered_df[
    filtered_df["order_status"] == "Delivered"
].copy()


# =========================================================
# HEADER
# =========================================================
st.markdown(
    '<div class="dashboard-title">🍽️ Zomato SQL Analytics</div>',
    unsafe_allow_html=True
)

st.markdown(
    """
    <div class="dashboard-subtitle">
    Interactive Restaurant • Customer • Revenue • Delivery Analytics
    </div>
    """,
    unsafe_allow_html=True
)


# =========================================================
# KPI CALCULATIONS
# =========================================================
total_orders = len(filtered_df)

delivered_orders = len(delivered_df)

total_revenue = delivered_df["total_amount"].sum()

average_order_value = (
    delivered_df["total_amount"].mean()
    if not delivered_df.empty
    else 0
)

cancelled_orders = len(
    filtered_df[
        filtered_df["order_status"] == "Cancelled"
    ]
)

cancellation_rate = (
    cancelled_orders / total_orders * 100
    if total_orders > 0
    else 0
)


# =========================================================
# KPI CARDS
# =========================================================
col1, col2, col3, col4, col5 = st.columns(5)

with col1:
    st.markdown(f"""
        <div class="kpi-card kpi-blue">
            <div class="kpi-label">TOTAL ORDERS</div>
            <div class="kpi-value">{total_orders:,}</div>
        </div>
    """, unsafe_allow_html=True)

with col2:
    st.markdown(f"""
        <div class="kpi-card kpi-green">
            <div class="kpi-label">DELIVERED ORDERS</div>
            <div class="kpi-value">{delivered_orders:,}</div>
        </div>
    """, unsafe_allow_html=True)

with col3:
    st.markdown(f"""
        <div class="kpi-card kpi-purple">
            <div class="kpi-label">DELIVERED REVENUE</div>
            <div class="kpi-value">₹{total_revenue:,.0f}</div>
        </div>
    """, unsafe_allow_html=True)

with col4:
    st.markdown(f"""
        <div class="kpi-card kpi-orange">
            <div class="kpi-label">AVG ORDER VALUE</div>
            <div class="kpi-value">₹{average_order_value:,.2f}</div>
        </div>
    """, unsafe_allow_html=True)

with col5:
    st.markdown(f"""
        <div class="kpi-card kpi-red">
            <div class="kpi-label">CANCELLATION RATE</div>
            <div class="kpi-value">{cancellation_rate:.2f}%</div>
        </div>
    """, unsafe_allow_html=True)


st.write("")


# =========================================================
# DASHBOARD TABS
# =========================================================
tab1, tab2, tab3, tab4 = st.tabs([
    "📊 Overview",
    "🏆 Restaurants",
    "👥 Customers",
    "🚴 Operations"
])


# =========================================================
# TAB 1 - OVERVIEW
# =========================================================
with tab1:

    left, right = st.columns(2)

    # ---------------- MONTHLY REVENUE ----------------
    with left:

        st.markdown(
            '<div class="section-title">📈 Monthly Revenue Trend</div>',
            unsafe_allow_html=True
        )

        if not delivered_df.empty:

            monthly_df = delivered_df.copy()

            monthly_df["month"] = pd.to_datetime(
                monthly_df["order_date"]
            ).dt.to_period("M").astype(str)

            monthly_revenue = (
                monthly_df
                .groupby("month", as_index=False)["total_amount"]
                .sum()
            )

            fig = px.area(
                monthly_revenue,
                x="month",
                y="total_amount",
                markers=True,
                labels={
                    "month": "Month",
                    "total_amount": "Revenue (₹)"
                }
            )

            fig.update_layout(
                height=350,
                margin=dict(l=10, r=10, t=20, b=10)
            )

            st.plotly_chart(
                fig,
                use_container_width=True
            )


    # ---------------- ORDER STATUS ----------------
    with right:

        st.markdown(
            '<div class="section-title">📦 Order Status Distribution</div>',
            unsafe_allow_html=True
        )

        status_df = (
            filtered_df
            .groupby("order_status")
            .size()
            .reset_index(name="orders")
        )

        fig = px.donut if hasattr(px, "donut") else None

        fig = px.pie(
            status_df,
            names="order_status",
            values="orders",
            hole=0.55
        )

        fig.update_layout(
            height=350,
            margin=dict(l=10, r=10, t=20, b=10)
        )

        st.plotly_chart(
            fig,
            use_container_width=True
        )


    # ---------------- CITY + CUISINE ----------------
    left, right = st.columns(2)

    with left:

        st.markdown(
            '<div class="section-title">🏙️ Revenue by City</div>',
            unsafe_allow_html=True
        )

        city_df = (
            delivered_df
            .groupby("city", as_index=False)["total_amount"]
            .sum()
            .sort_values("total_amount", ascending=False)
        )

        fig = px.bar(
            city_df,
            x="city",
            y="total_amount",
            text_auto=True,
            labels={
                "city": "City",
                "total_amount": "Revenue (₹)"
            }
        )

        fig.update_layout(
            height=350,
            margin=dict(l=10, r=10, t=20, b=10)
        )

        st.plotly_chart(fig, use_container_width=True)


    with right:

        st.markdown(
            '<div class="section-title">🍛 Orders by Cuisine</div>',
            unsafe_allow_html=True
        )

        cuisine_df = (
            filtered_df
            .groupby("cuisine_type")
            .size()
            .reset_index(name="orders")
            .sort_values("orders", ascending=True)
        )

        fig = px.bar(
            cuisine_df,
            x="orders",
            y="cuisine_type",
            orientation="h",
            text_auto=True,
            labels={
                "orders": "Orders",
                "cuisine_type": "Cuisine"
            }
        )

        fig.update_layout(
            height=350,
            margin=dict(l=10, r=10, t=20, b=10)
        )

        st.plotly_chart(fig, use_container_width=True)


# =========================================================
# TAB 2 - RESTAURANTS
# =========================================================
with tab2:

    st.markdown(
        '<div class="section-title">🏆 Restaurant Revenue Ranking</div>',
        unsafe_allow_html=True
    )

    restaurant_df = (
        delivered_df
        .groupby("restaurant_name", as_index=False)
        .agg(
            revenue=("total_amount", "sum"),
            orders=("order_id", "count")
        )
        .sort_values("revenue", ascending=False)
    )

    fig = px.bar(
        restaurant_df,
        x="restaurant_name",
        y="revenue",
        text_auto=True,
        labels={
            "restaurant_name": "Restaurant",
            "revenue": "Revenue (₹)"
        }
    )

    fig.update_layout(height=400)

    st.plotly_chart(fig, use_container_width=True)

    st.markdown(
        '<div class="section-title">📋 Restaurant Performance Table</div>',
        unsafe_allow_html=True
    )

    restaurant_display = restaurant_df.copy()

    restaurant_display["revenue"] = (
        restaurant_display["revenue"]
        .map(lambda x: f"₹{x:,.2f}")
    )

    st.dataframe(
        restaurant_display,
        use_container_width=True,
        hide_index=True
    )


# =========================================================
# TAB 3 - CUSTOMERS
# =========================================================
with tab3:

    customer_df = (
        delivered_df
        .groupby("customer_name", as_index=False)
        .agg(
            total_orders=("order_id", "count"),
            total_spent=("total_amount", "sum")
        )
        .sort_values("total_spent", ascending=False)
    )

    left, right = st.columns([1.4, 1])

    with left:

        st.markdown(
            '<div class="section-title">💰 Top Customers by Spending</div>',
            unsafe_allow_html=True
        )

        fig = px.bar(
            customer_df.head(10),
            x="customer_name",
            y="total_spent",
            text_auto=True,
            labels={
                "customer_name": "Customer",
                "total_spent": "Total Spending (₹)"
            }
        )

        fig.update_layout(height=400)

        st.plotly_chart(fig, use_container_width=True)


    with right:

        st.markdown(
            '<div class="section-title">👑 Customer Leaderboard</div>',
            unsafe_allow_html=True
        )

        display_customer = customer_df.copy()

        display_customer["total_spent"] = (
            display_customer["total_spent"]
            .map(lambda x: f"₹{x:,.2f}")
        )

        st.dataframe(
            display_customer,
            use_container_width=True,
            hide_index=True
        )


# =========================================================
# TAB 4 - OPERATIONS
# =========================================================
with tab4:

    delivery_df = run_query("""
        SELECT
            dp.name AS delivery_partner,
            COUNT(d.delivery_id) AS deliveries,
            ROUND(
                AVG(
                    EXTRACT(
                        EPOCH FROM
                        (d.delivery_time - d.pickup_time)
                    ) / 60
                ),
                2
            ) AS avg_delivery_minutes
        FROM deliveries d
        JOIN delivery_partners dp
            ON d.delivery_partner_id =
               dp.delivery_partner_id
        WHERE d.delivery_time IS NOT NULL
        GROUP BY
            dp.delivery_partner_id,
            dp.name
        ORDER BY avg_delivery_minutes;
    """)

    left, right = st.columns(2)

    with left:

        st.markdown(
            '<div class="section-title">🚴 Average Delivery Time</div>',
            unsafe_allow_html=True
        )

        fig = px.bar(
            delivery_df,
            x="delivery_partner",
            y="avg_delivery_minutes",
            text_auto=True,
            labels={
                "delivery_partner": "Delivery Partner",
                "avg_delivery_minutes": "Minutes"
            }
        )

        fig.update_layout(height=350)

        st.plotly_chart(fig, use_container_width=True)


    with right:

        st.markdown(
            '<div class="section-title">📦 Deliveries by Partner</div>',
            unsafe_allow_html=True
        )

        fig = px.pie(
            delivery_df,
            names="delivery_partner",
            values="deliveries",
            hole=0.55
        )

        fig.update_layout(height=350)

        st.plotly_chart(fig, use_container_width=True)


    # PAYMENT METHODS

    st.markdown(
        '<div class="section-title">💳 Payment Method Usage</div>',
        unsafe_allow_html=True
    )

    payment_df = run_query("""
        SELECT
            payment_method,
            COUNT(*) AS transactions
        FROM payments
        GROUP BY payment_method
        ORDER BY transactions DESC;
    """)

    fig = px.bar(
        payment_df,
        x="payment_method",
        y="transactions",
        text_auto=True,
        labels={
            "payment_method": "Payment Method",
            "transactions": "Transactions"
        }
    )

    fig.update_layout(height=350)

    st.plotly_chart(fig, use_container_width=True)


# =========================================================
# RAW DATA EXPLORER
# =========================================================
with st.expander("🔎 Explore Filtered Order Data"):

    st.dataframe(
        filtered_df,
        use_container_width=True,
        hide_index=True
    )


# =========================================================
# FOOTER
# =========================================================
st.divider()

st.caption(
    "Zomato SQL Analytics Portfolio Project • "
    "PostgreSQL • Neon • Python • Pandas • Plotly • Streamlit"
)

st.caption(
    "Sample/synthetic dataset created for educational "
    "and portfolio purposes. Not official Zomato data."
)
