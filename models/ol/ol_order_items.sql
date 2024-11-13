SELECT 

    /* IDs */
    order_item_id,
    order_id,
    product_id
    
FROM {{ ref('cl_items') }}