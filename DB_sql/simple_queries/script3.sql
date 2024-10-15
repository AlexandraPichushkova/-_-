SELECT bill_id
FROM bill
WHERE datediff(now(),b_date)<=60;