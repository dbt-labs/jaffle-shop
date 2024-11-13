SELECT 

    /* IDs */
    product_id,

    /* DIMENSIONS */
    product_name                AS name,
    product_type                AS type,
    product_description         AS description,

    /* METRICS */
    product_price_cents / 100   AS price
    
FROM {{ ref('cl_products') }}