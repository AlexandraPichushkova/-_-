SELECT surname
FROM worker JOIN occ USING(phone_numb) JOIN  bill_lines  ON occ.phone_numb=bill_lines.worker_phone
JOIN  bill  USING(bill_id)
WHERE post='headmaster' AND b_month=3 AND b_year=2020 AND bill_lines.summ<occ_limit;


select    surname from  worker w left join
  (select ex_phone from limit_exceed where ex_month = 3 and ex_year = 2020) march_exceeded
  on w.phone_numb = march_exceeded.ex_phone
where
  march_exceeded.ex_phone is NULL
