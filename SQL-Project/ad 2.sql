WITH genre_purchases AS (
    SELECT
        c.country,
        g.name AS genre_name,
        COUNT(il.invoice_line_id) AS purchase_count
    FROM customers c
    JOIN invoice i ON c.customer_id = i.customer_id
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    JOIN track t ON il.track_id = t.track_id
    JOIN genre g ON t.genre_id = g.genre_id
    GROUP BY c.country, g.name
),
ranked_genres AS (
    SELECT
        country,
        genre_name,
        purchase_count,
        RANK() OVER (PARTITION BY country ORDER BY purchase_count DESC) AS rnk
    FROM genre_purchases
)
SELECT
    country,
    genre_name AS most_popular_genre,
    purchase_count
FROM ranked_genres
WHERE rnk = 1
ORDER BY country;
