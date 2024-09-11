WITH customers AS (

    SELECT 
        *
    FROM 
        {{ ref('stg_jaffle_shop__customers') }}
),

orders AS (

    SELECT 
        *
    FROM 
        {{ ref('stg_jaffle_shop__orders') }}
),

customer_orders AS (
    
    SELECT 
        customer_id,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS most_recent_order_date,
        COUNT(order_id) AS number_of_orders  
    FROM 
        orders
    GROUP BY 1
),

final AS (
    
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        co.first_order_date,
        co.most_recent_order_date,
        COALESCE(co.number_of_orders, 0) AS number_of_orders
    FROM 
        customers c
    LEFT JOIN 
        customer_orders co USING (customer_id)
)

SELECT * FROM final