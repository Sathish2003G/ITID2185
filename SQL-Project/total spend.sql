


SELECT c.customer_id, c.first_name, c.last_name, SUM(CAST(i.total AS NUMERIC)) AS total_spent
FROM customers c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 1;
