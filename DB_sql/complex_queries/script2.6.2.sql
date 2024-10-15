SELECT *
FROM worker JOIN exceed_maxer ON worker.phone_numb=exceed_maxer.phone
WHERE ex_kol = (SELECT MAX(ex_kol) FROM exceed_maxer);