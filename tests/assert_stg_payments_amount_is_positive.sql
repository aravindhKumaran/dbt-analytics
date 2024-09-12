with 
    payments as (
        SELECT * 
        FROM {{ ref('stg_stripe__payments') }}
)

select 
    order_id,
    sum(amount) as total_amount

from payments

GROUP BY order_id
having total_amount < 0