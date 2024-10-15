SELECT surname, ex_phone, summ
FROM worker JOIN limit_exceed ON worker.phone_numb=limit_exceed.ex_phone
WHERE ex_month=3 AND ex_year=2020
