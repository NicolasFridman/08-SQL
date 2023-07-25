-- Año de Nacimiento:

SELECT name, year FROM movies WHERE year=1989;

-- 1982:

SELECT COUNT() FROM movies WHERE year=1982;

-- Stacktors

SELECT FROM actors WHERE last_name LIKE '%stack%';

-- Juego del Nombre de la Fama
-- Nombres mas populares:

SELECT first_name, COUNT() FROM actors
GROUP BY first_name
ORDER BY count() DESC
LIMIT 10;

-- Apellidos mas populares:

SELECT last_name, COUNT() FROM actors
GROUP BY last_name
ORDER BY count() DESC
LIMIT 10;

-- Los nombres completos mas populares:

SELECT first_name  ||' '||  last_name as full_name, COUNT() FROM actors
GROUP BY full_name
ORDER BY count() DESC
LIMIT 10;

-- Prolífico

SELECT first_name, last_name, COUNT() as role_count FROM actors 
JOIN roles
ON id=actor_id
GROUP BY id
ORDER BY role_count DESC
LIMIT 100;

-- Fondo del Barril

SELECT genre, COUNT() as num_movies_by_genres FROM movies_genres
JOIN movies
ON movie_id=id
GROUP BY genre
ORDER BY num_movies_by_genres ASC;

-- Braveheart

SELECT first_name, last_name FROM actors
JOIN roles
ON actors.id = roles.actor_id
JOIN movies
ON movies.id =r oles.movie_id
WHERE movies.name = 'Braveheart' AND movies.year = 1995
ORDER BY actors.last_name ASC;

-- Noir Bisiesto

SELECT d.first_name, d.last_name, m.name, m.year 
FROM directors as d
JOIN movies_directors as md
ON d.id = md.director_id
JOIN movies as m
ON m.id = md.movie_id
JOIN movies_genres as mg
ON m.id = mg.movie_id
WHERE mg.genre = 'Film-Noir' AND m.year % 4 = 0
ORDER BY m.name ASC;

--Kevin Bacon

SELECT m.name, a.first_name, a.last_name 
FROM movies as m
JOIN roles as r
ON m.id = r.movie_id
JOIN actors as a
ON a.id = r.actor_id
JOIN movies_genres as mg
ON mg.movie_id = m.id
WHERE m.id IN (
  SELECT r.movie_id
  FROM roles as r
  JOIN movies_genres as mg
  ON mg.movie_id = r.movie_id
  JOIN actors as a
  ON a.id = r.actor_id
  WHERE a.first_name = 'Kevin' AND a.last_name = 'Bacon' AND mg.genre = 'Drama'
)
AND NOT (a.first_name = 'Kevin' AND a.last_name = 'Bacon')
ORDER BY m.name ASC
LIMIT 20;

--Actores Inmortales

SELECT a.first_name, a.last_name, a.id
FROM actors as a
JOIN roles as r
ON a.id = r.actor_id
JOIN movies as m
ON r.movie_id = m.id
WHERE m.year < 1900

INTERSECT

SELECT a.first_name, a.last_name, a.id
FROM actors as a
JOIN roles as r
ON a.id = r.actor_id
JOIN movies as m
ON r.movie_id = m.id
WHERE m.year > 2000
ORDER BY a.id ASC;

--Ocupados en Filmación

SELECT a.first_name, a.last_name, m.name, m.year, COUNT(r.role) as num_roles
FROM actors as a
JOIN roles as r
ON a.id = r.actor_id
JOIN movies as m
ON r.movie_id = m.id
WHERE m.year > 1990
GROUP BY a.id, a.first_name, a.last_name, m.id, m.name, m.year
HAVING COUNT(DISTINCT r.role) >= 5
ORDER BY num_roles DESC;