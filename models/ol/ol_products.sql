SELECT 

    /* IDs */
    p.product_id,

    /* DIMENSIONS */
    p.product_name                AS name,
    p.product_type                AS type,
    p.product_description         AS description,

    /* METRICS */
    p.product_price_cents / 100   AS price,
    COUNT(p.product_id)           AS amount_supplies
    
FROM {{ ref('cl_products') }} p
LEFT JOIN {{ ref('ol_supplies') }} s ON p.product_id = s.product_id
GROUP BY p.product_id, p.product_name, p.product_type, p.product_description, price