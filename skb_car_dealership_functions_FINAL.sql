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
--function to create join table summarizing sales by store
CREATE OR REPLACE FUNCTION store_sales_record(store_id_num INTEGER)
RETURNS TABLE (
	store_number INTEGER,
	store_sales NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY
	SELECT iv.store_id AS store_number, sum(iv.purchase_price) AS store_sales
	FROM car_sale cs
	JOIN invoice iv 
	ON cs.car_id = iv.car_id
	WHERE iv.store_id = store_id_num
	GROUP BY iv.store_id;
END; 
$$

SELECT store_sales_record(5); 

--WHY ISN'T THIS RETURNING SEPARATE COLUMNS???



--function to create join table summarizing sales by sales_rep
CREATE OR REPLACE FUNCTION rep_sales_record(rep_id_num INTEGER)
RETURNS TABLE (
	rep_id INTEGER,
	rep_sales NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY
	SELECT iv.sales_rep_id AS rep_id, sum(iv.purchase_price) AS rep_sales
	FROM car_sale cs
	JOIN invoice iv 
	ON cs.car_id = iv.car_id
	WHERE iv.sales_rep_id = rep_id_num
	GROUP BY iv.sales_rep_id;
END; 
$$


SELECT rep_sales_record(15); 

--WHY ISN'T THIS RETURNING SEPARATE COLUMNS???




--function to create list of customers to contact regarding upcoming service needs (like oil change, tire rotation, etc)
--CHANGE oil
--rotate tires
--check brakes
--xx,xxx mile tune-up



