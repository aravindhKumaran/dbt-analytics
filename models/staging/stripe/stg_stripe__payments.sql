WITH payments AS (
    SELECT  
        *
    FROM 
        raw.stripe.payment 
)

SELECT 
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    amount / 100 as amount, -- amount is stored in cents, convert it to dollars
    created as created_at

FROM payments 