SELECT 

    /* IDs */
    sku             AS product_id,

    /* DIMENSIONS */
    name            AS product_name,
    type            AS product_type,
    description     AS product_description,

    /* METRICS */
    price   AS product_price_cents
    
FROM {{ source('dl', 'products') }}