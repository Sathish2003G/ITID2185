SELECT billing_city,SUM(CAST(total AS NUMERIC)) AS city_total
FROM invoice
GROUP BY billing_city
ORDER BY city_total DESC
LIMIT 1;
