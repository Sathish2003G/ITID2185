
WITH artist_revenue AS (
    SELECT
        il.invoice_id,
        a.artist_id,
        a.name AS artist_name,
        SUM(CAST(il.unit_price AS numeric) * CAST(il.quality AS integer)) AS artist_total
    FROM invoice_line il
    JOIN track t ON il.track_id = t.track_id
    JOIN album al ON t.album_id = al.album_id
    JOIN artist a ON al.artist_id = a.artist_id
    GROUP BY il.invoice_id, a.artist_id, a.name
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    ar.artist_name,
    SUM(ar.artist_total) AS total_spent
FROM artist_revenue ar
JOIN invoice i ON ar.invoice_id = i.invoice_id
JOIN customers c ON i.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, ar.artist_name
ORDER BY c.customer_id, total_spent DESC;
