DROP FUNCTION get_all_cars_for_customer;

--function to return new table showing cars owned by certain customer
CREATE OR REPLACE FUNCTION get_all_cars_for_customer(customer_last_name VARCHAR(50), customer_first_name VARCHAR(50))
RETURNS TABLE (
	customer_id INTEGER,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	car_id INTEGER,
	car_year INTEGER,
	car_make VARCHAR(20),
	car_model VARCHAR(20),
	car_color VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY
	SELECT c.customer_id, c.first_name, c.last_name, cc.car_id, c2.year_, c2.make, c2.model, c2.color
	FROM customer c
	JOIN customer_car cc 
	ON c.customer_id = cc.customer_id
	JOIN car c2
	ON c2.car_id = cc.car_id
	WHERE c.first_name = customer_first_name AND c.last_name = customer_last_name; 
END; 
$$

--WHY DOESN'T THIS RETURN A TABLE?
--It returns 2 rows with all info smashing into 1 column :/
SELECT get_all_cars_for_customer('Lission-Coors', 'Veronica');



--function to calculate profit using car_sale info and invoice purchase_price

--function to create list of customers to contact regarding upcoming service needs (like oil change, tire rotation, etc)
CHANGE oil
pick the garage WITH lowest overhead
never buy a car IN its FIRST YEAR OF production
never buy a french car unless you live IN france

--function to create join table summarizing sales by store

--function to create join table summarizing sales by sales_rep



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












