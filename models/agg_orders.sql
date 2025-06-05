SELECT
    o.order_date,
    o.status,
    c.customer_id,
    SUM(o.amount) as total_amount
FROM {{ ref('orders') }} o
JOIN {{ ref('customers') }} c USING(customer_id)
GROUP BY ALL