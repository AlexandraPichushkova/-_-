CREATE VIEW exceed_maxer (phone, ex_kol) AS
SELECT ex_phone, COUNT(*)
FROM limit_exceed
WHERE ex_year = 2020
GROUP BY ex_phone;

