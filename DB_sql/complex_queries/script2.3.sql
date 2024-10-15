SELECT *
FROM worker
WHERE birth_date=(SELECT MIN(birth_date) FROM worker);