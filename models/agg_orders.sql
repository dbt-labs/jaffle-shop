SELECT
      ordered_at::DATE as order_date
    , customer_id
    , SUM(order_cost) as total_order_cost
    , SUM(order_items_subtotal) as total_order_items_subtotal
    , SUM(count_order_items) as total_order_items_count
FROM {{ ref('orders') }} o
GROUP BY ALL