SELECT surname, division_id
FROM worker LEFT JOIN occ USING(phone_numb)
WHERE phone_numb IS NULL;