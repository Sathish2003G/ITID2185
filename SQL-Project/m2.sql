
SELECT a.name AS artist_name, 
       COUNT(t.track_id) AS track_count
FROM artist a
JOIN album al ON a.artist_id = al.artist_id
JOIN track t ON al.album_id = t.album_id
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
GROUP BY a.name
ORDER BY track_count DESC
LIMIT 10;

