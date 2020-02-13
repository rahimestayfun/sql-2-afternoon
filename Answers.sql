#### Practice joins  #####

-- Get all invoices where the unit_price on the invoice_line is greater than $0.99.

SELECT * FROM invoice i
JOIN invoice_line il ON i.invoice_id = il.invoice_id
WHERE il.unit_price > 0.99;

-- Get the invoice_date, customer first_name and last_name, and total from all invoices.

SELECT i.invoice_date,c.first_name,c.last_name,i.total
FROM customer c
JOIN invoice i ON i.customer_id = c.customer_id;

-- Get the customer first_name and last_name and the support rep's first_name and last_name from all customers.
-- Support reps are on the employee table.
SELECT c.first_name,c.last_name,e.first_name,e.last_name
FROM customer c
JOIN employee e ON c.support_rep_id = e.employee_id;


-- Get the album title and the artist name from all albums.
SELECT al.title,ar.name FROM album al
JOIN artist ar ON ar.artist_id= al.artist_id;

-- Get all playlist_track track_ids where the playlist name is Music.
SELECT pt.track_id FROM playlist_track pt
JOIN playlist p ON pt.playlist_id = p.playlist_id
WHERE p.name = 'Music';

-- Get all track names for playlist_id 5.
SELECT t.name FROM track T
JOIN playlist_track pt ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5;

-- Get all track names and the playlist name that they're on ( 2 joins ).

SELECT p.name,t.name FROM playlist p
JOIN playlist_track pt ON pt.playlist_id = p.playlist_id
JOIN track t ON t.track_id= pt.track_id;

-- SELECT t.name, p.name
-- FROM track t
-- JOIN playlist_track pt ON t.track_id = pt.track_id
-- JOIN playlist p ON pt.playlist_id = p.playlist_id;

-- Get all track names and album titles that are the genre Alternative & Punk ( 2 joins ).
SELECT t.name,al.title FROM album al
JOIN track t ON t.album_id = al.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';

## Black Diamond
-- Get all tracks on the playlist(s) called Music and show their name, genre name, album name, and artist name.
-- At least 5 joins.



 #### Practice nested queries ####

-- Get all invoices where the unit_price on the invoice_line is greater than $0.99.
SELECT * FROM invoice 
WHERE invoice_id IN(
  SELECT invoice_id FROM invoice_line
  WHERE unit_price > 0.99);

-- Get all playlist tracks where the playlist name is Music.
SELECT * FROM playlist_track
WHERE playlist_id IN(
  SELECT playlist_id FROM playlist
  WHERE name = 'Music');

-- Get all track names for playlist_id 5.

SELECT name FROM track
WHERE track_id IN(
  SELECT track_id FROM playlist_track
  WHERE playlist_id = 5);

-- Get all tracks where the genre is Comedy.

SELECT * FROM track
WHERE genre_id IN(
  SELECT genre_id FROM genre
  WHERE name = 'Comedy');

-- Get all tracks where the album is Fireball.

SELECT * FROM track
WHERE album_id IN(
  SELECT album_id FROM album
  WHERE title = 'Fireball');

-- Get all tracks for the artist Queen ( 2 nested subqueries ).

SELECT * FROM track
WHERE album_id IN (
  SELECT album_id FROM album
  WHERE artist_id IN(
    SELECT artist_id FROM artist
    WHERE name = 'Queen'));


#### Practice updating Rows ####

-- Find all customers with fax numbers and set those numbers to null.
UPDATE customer
SET fax = NULL
WHERE fax IS NOT NULL;

SELECT * FROM customer;

-- Find all customers with no company (null) and set their company to "Self".

UPDATE customer
SET company = 'Self'
WHERE company IS NULL;

SELECT * FROM customer;

-- Find the customer Julia Barnett and change her last name to Thompson.

UPDATE customer
SET last_name = 'Thompson'
WHERE first_name ='Julia' AND last_name='Barnett';

-- Find the customer with this email luisrojas@yahoo.cl and change his support rep to 4.

UPDATE customer
SET support_rep_id = 4
WHERE email='luisrojas@yahoo.cl';

-- Find all tracks that are the genre Metal and have no composer. Set the composer to "The darkness around us".
UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id IN(
  SELECT genre_id FROM genre
  WHERE name = 'Metal') AND composer IS NULL;

-- UPDATE track
-- SET composer = 'The darkness around us'
-- WHERE genre_id = ( SELECT genre_id FROM genre WHERE name = 'Metal' )
-- AND composer IS null;

-- SELECT * FROM track
-- WHERE composer = 'The darkness around us';

-- Refresh your page to remove all database changes.


#### Group By ####

-- Find a count of how many tracks there are per genre. Display the genre name with the count.
SELECT g.name,COUNT(*) FROM track t
JOIN genre g ON t.genre_id= g.genre_id
GROUP BY g.name;

-- Find a count of how many tracks are the "Pop" genre and how many tracks are the "Rock" genre.
SELECT g.name, COUNT(*) FROM track t
JOIN genre g ON g.genre_id= t.genre_id
WHERE g.name = 'Pop'OR g.name='Rock'
GROUP BY g.name; 

-- Find a list of all artists and how many albums they have.
SELECT ar.name, COUNT(*) FROM album al
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY ar.name;


#### Use Distinct ####

-- From the track table find a unique list of all composers.
SELECT DISTINCT composer FROM track;

-- From the invoice table find a unique list of all billing_postal_codes.
SELECT DISTINCT billing_postal_code FROM invoice;

-- From the customer table find a unique list of all companys.
SELECT DISTINCT company FROM customer;


#### Delete Rows ####

CREATE TABLE practice_delete ( name TEXT, type TEXT, value INTEGER );
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);

SELECT * FROM practice_delete;

Copy, paste, and run the SQL code from the summary.
-- Delete all 'bronze' entries from the table.
DELETE from practice_delete
WHERE type='bronze';


-- Delete all 'silver' entries from the table.
DELETE FROM practice_delete
WHERE type='silver';

-- Delete all entries whose value is equal to 150.
DELETE FROM practice_delete
WHERE value=150;













