SELECT 

    /* IDs */
    c.customer_id,

    /* DIMENSIONS */
    c.customer_name         AS name,
    CASE
        WHEN COUNT(c.customer_id) > 1 THEN true
        ELSE false END      AS is_repeating_customer,

    /* METRICS*/ 
    SUM(o.subtotal)         AS life_time_value,
    AVG(o.subtotal)         AS average_order_value

FROM {{ ref('cl_customers') }} c
LEFT JOIN {{ ref('ol_orders') }} o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name