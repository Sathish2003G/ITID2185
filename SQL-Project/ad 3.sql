WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        c.country,
        SUM(CAST(il.unit_price AS numeric) * CAST(il.quality AS integer)) AS total_spent
    FROM customers c
    JOIN invoice i ON c.customer_id = i.customer_id
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    GROUP BY c.customer_id, c.first_name, c.last_name, c.country
),
ranked_customers AS (
    SELECT
        customer_id,
        first_name,
        last_name,
        country,
        total_spent,
        RANK() OVER (PARTITION BY country ORDER BY total_spent DESC) AS rnk
    FROM customer_spending
)
SELECT
    country,
    customer_id,
    (first_name ,last_name) AS customer_name,
    total_spent
FROM ranked_customers
WHERE rnk = 1
ORDER BY country;
