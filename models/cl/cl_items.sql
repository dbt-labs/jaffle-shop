SELECT 

    /* IDs */
    id          AS order_item_id,
    order_id,
    sku         AS product_id
    
FROM {{ source('dl', 'items') }}