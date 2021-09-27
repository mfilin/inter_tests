SELECT
	  r.name AS region
	, c.name AS city
	, a.name AS apteka
	, g.name
	, g.mn_name
	, wh.quantity
	, wh.price
FROM t_regions r
	INNER JOIN t_city c
ON c.rf_region = r.id
	INNER JOIN t_aptek a
ON a.rf_city = c.id
	INNER JOIN t_goods_wh wh
ON wh.rf_aptek = a.id
	LEFT JOIN t_goods g
ON g.id = wh.rf_good
	LEFT JOIN t_black_list b
ON g.id = b.rf_good AND c.id = b.rf_city
WHERE
	b.id IS null