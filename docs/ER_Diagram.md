# Zomato SQL Analytics — ER Diagram

```mermaid
erDiagram

    LOCATIONS ||--o{ RESTAURANTS : contains
    CUSTOMERS ||--o{ ORDERS : places
    RESTAURANTS ||--o{ ORDERS : receives
    RESTAURANTS ||--o{ MENU_ITEMS : offers
    ORDERS ||--|{ ORDER_ITEMS : contains
    MENU_ITEMS ||--o{ ORDER_ITEMS : included_in
    ORDERS ||--o| PAYMENTS : has
    ORDERS ||--o| DELIVERIES : has
    DELIVERY_PARTNERS ||--o{ DELIVERIES : handles
    CUSTOMERS ||--o{ REVIEWS : writes
    RESTAURANTS ||--o{ REVIEWS : receives

    LOCATIONS {
        int location_id PK
        varchar city
        varchar area
        varchar state
        varchar pincode
    }

    CUSTOMERS {
        int customer_id PK
        varchar name
        varchar email UK
        varchar phone UK
        text address
        date registration_date
    }

    RESTAURANTS {
        int restaurant_id PK
        varchar restaurant_name
        int location_id FK
        varchar cuisine_type
        decimal rating
        varchar contact_number
    }

    MENU_ITEMS {
        int item_id PK
        int restaurant_id FK
        varchar item_name
        varchar category
        decimal price
        boolean availability_status
    }

    ORDERS {
        int order_id PK
        int customer_id FK
        int restaurant_id FK
        timestamp order_date
        varchar order_status
        decimal total_amount
    }

    ORDER_ITEMS {
        int order_item_id PK
        int order_id FK
        int item_id FK
        int quantity
        decimal price
    }

    PAYMENTS {
        int payment_id PK
        int order_id FK
        varchar payment_method
        varchar payment_status
        timestamp transaction_date
    }

    DELIVERY_PARTNERS {
        int delivery_partner_id PK
        varchar name
        varchar phone
        varchar vehicle_type
    }

    DELIVERIES {
        int delivery_id PK
        int order_id FK
        int delivery_partner_id FK
        timestamp pickup_time
        timestamp delivery_time
        varchar delivery_status
    }

    REVIEWS {
        int review_id PK
        int customer_id FK
        int restaurant_id FK
        int rating
        text review_text
        date review_date
    }
