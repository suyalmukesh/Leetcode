Step By Step thought process

1. gets all the months in transactions and chargebacks table: (output:["2019-05","2019-06","2019-09"])
JOIN
(
	SELECT SUBSTR(a.trans_date,1,7) as month FROM Transactions as a
	UNION
	SELECT SUBSTR(b.trans_date,1,7) FROM Chargebacks as b
) as g

2. GROUP BY g.month and c.country (we want to calculate columns 3~6 group by group)

3. SUM(CASE WHEN......) performs operation on the group "(g.month,c.country)"

4. Obtains the results, but rows with all 0 still not removed
(
    SELECT g.month as month,c.country,
    SUM(CASE WHEN c.state="approved" AND SUBSTR(c.trans_date,1,7)=g.month THEN 1 ELSE 0 END) as approved_count,
    SUM(CASE WHEN c.state="approved" AND SUBSTR(c.trans_date,1,7)=g.month THEN amount ELSE 0 END) as approved_amount,
    SUM(CASE WHEN SUBSTR(d.trans_date,1,7)=g.month THEN 1 ELSE 0 END) as chargeback_count,
    SUM(CASE WHEN SUBSTR(d.trans_date,1,7)=g.month THEN c.amount ELSE 0 END) as chargeback_amount
    FROM Transactions as c
    LEFT JOIN Chargebacks as d
    ON c.id=d.trans_id
    JOIN
    (
        SELECT SUBSTR(a.trans_date,1,7) as month FROM Transactions as a
        UNION
        SELECT SUBSTR(b.trans_date,1,7) FROM Chargebacks as b
    ) as g
    GROUP BY g.month,c.country
) as h


5. Finally, Removed rows with all 3~6 columns being 0 (the answer)

SELECT * FROM
(
    SELECT g.month as month,c.country,
    SUM(CASE WHEN c.state="approved" AND SUBSTR(c.trans_date,1,7)=g.month THEN 1 ELSE 0 END) as approved_count,
    SUM(CASE WHEN c.state="approved" AND SUBSTR(c.trans_date,1,7)=g.month THEN amount ELSE 0 END) as approved_amount,
    SUM(CASE WHEN SUBSTR(d.trans_date,1,7)=g.month THEN 1 ELSE 0 END) as chargeback_count,
    SUM(CASE WHEN SUBSTR(d.trans_date,1,7)=g.month THEN c.amount ELSE 0 END) as chargeback_amount
    FROM Transactions as c
    LEFT JOIN Chargebacks as d
    ON c.id=d.trans_id
    JOIN
    (
        SELECT SUBSTR(a.trans_date,1,7) as month FROM Transactions as a
        UNION
        SELECT SUBSTR(b.trans_date,1,7) FROM Chargebacks as b
    ) as g
    GROUP BY g.month,c.country
) as h
WHERE h.approved_count!=0 OR h.approved_amount!=0 OR h.chargeback_count!=0 OR h.chargeback_amount!=0;