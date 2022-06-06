CREATE OR REPLACE FUNCTION store_sales_record(store_name VARCHAR(100))
RETURNS TABLE (
	first_name VARCHAR,
	last_name VARCHAR,
	address VARCHAR,
	city VARCHAR,
	district VARCHAR,
	country VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY
	SELECT c.first_name, c.last_name, a.address, ci.city, a.district, co.country
	FROM customer c
	JOIN address a
	ON c.address_id = a.address_id
	JOIN city ci 
	ON a.city_id = ci.city_id 
	JOIN country co 
	ON ci.country_id = co.country_id
	WHERE co.country = country_name;
END; 
$$