/*	Question Set 1 - Basic */

/* Q1: Who is the most experienced employee based on job title? */

SELECT title, last_name, first_name 
FROM employee
ORDER BY experience_level DESC
LIMIT 1;


/* Q2: Which countries have the highest number of invoices? */

SELECT COUNT(*) AS count, billing_country 
FROM invoice
GROUP BY billing_country
ORDER BY count DESC;


/* Q3: What are the top 3 values of total invoices? */

SELECT total 
FROM invoice
ORDER BY total DESC
LIMIT 3;


/* Q4: Which city has the most valuable customers? To organize a promotional Music Festival, we're targeting the city with the highest total invoice amounts. 
Write a query that returns the city with the highest sum of invoice totals. 
Provide both the city name & the sum of all invoice totals */

SELECT billing_city, SUM(total) AS total_invoices
FROM invoice
GROUP BY billing_city
ORDER BY total_invoices DESC
LIMIT 1;


/* Q5: Who is the top customer? The customer with the highest expenditure will be declared the top customer. 
Write a query to determine the person who has spent the most money */

SELECT customer.customer_id, first_name, last_name, SUM(total) AS total_spent
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total_spent DESC
LIMIT 1;

/* Question Set 2 – Intermediate */

/* Q1: Write a query to retrieve the email, first name, last name, & Genre of all Rock Music listeners. 
List them alphabetically by email starting with A. */

/*Method 1 */

SELECT DISTINCT email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoiceline ON invoice.invoice_id = invoiceline.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;


/* Method 2 */

SELECT DISTINCT email AS Email,first_name AS FirstName, last_name AS LastName, genre.name AS Genre
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoiceline ON invoiceline.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoiceline.track_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
ORDER BY email;


/* Q2: Let's invite the artists who have composed the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT artist.artist_id, artist.name,COUNT(artist.artist_id) AS track_count
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY track_count DESC
LIMIT 10;


/* Q3: List all track names with a duration longer than the average song length. 
Display the Name and Milliseconds for each track. Order by song length, with the longest songs first. */

SELECT name, milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
	FROM track )
ORDER BY milliseconds DESC;
