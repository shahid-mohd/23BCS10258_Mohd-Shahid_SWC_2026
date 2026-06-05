SELECT
    transaction_date,
    SUM(revenue) AS daily_net_revenue
FROM (
    SELECT
        DATE(p.transaction_date) AS transaction_date,
        p.amount AS revenue
    FROM product_sales p
    WHERE p.product_id = 'PROD-2891'
      AND p.country = 'US'
      AND p.type = 'purchase'
      AND p.status = 'completed'
      AND DATE(p.transaction_date)
            BETWEEN '2025-04-15' AND '2025-04-28'
    UNION ALL
    SELECT
        DATE(r.transaction_date) AS transaction_date,
        -r.amount AS revenue
    FROM product_sales r
    JOIN product_sales p
        ON r.original_transaction_id = p.transaction_id
    WHERE p.product_id = 'PROD-2891'
      AND p.country = 'US'
      AND p.type = 'purchase'
      AND p.status = 'completed'
      AND DATE(p.transaction_date)
            BETWEEN '2025-04-15' AND '2025-04-28'
      AND r.type = 'refund'
      AND r.status = 'completed'
) t
GROUP BY transaction_date
ORDER BY transaction_date;
