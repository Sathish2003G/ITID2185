
SELECT name, milliseconds::bigint AS duration
FROM track
WHERE milliseconds::bigint > (
    SELECT AVG(milliseconds::bigint)
    FROM track
);
