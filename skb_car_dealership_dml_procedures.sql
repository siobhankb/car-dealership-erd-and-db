--procedure to update manager of store
CREATE OR REPLACE PROCEDURE store_mgr(name_of_store VARCHAR(50), first_ VARCHAR(50), last_ VARCHAR(50))
LANGUAGE plpgsql
AS $$
BEGIN 
	UPDATE store SET store_mgr = (
		SELECT sales_rep_id 
		FROM sales_rep 
		WHERE first_name = first_ AND last_name = last_
		)
	WHERE store_name = name_of_store;
END;
$$


CALL store_mgr('Drive-A-Way Dealz', 'Clack', 'Tappet');
CALL store_mgr('Shifting Gearz Hybrid Auto Dealz', 'Megan', 'Mahdel');
CALL store_mgr('Four Wheel Dealz', 'Zbigniew', 'Rigg');



--procedure to change employee to new store
CREATE OR REPLACE PROCEDURE change_employee_store(employ_type VARCHAR(10), first_initial VARCHAR(1), last_ VARCHAR(50), new_store_id INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN  
	IF employ_type = 'sales_rep' THEN 
		UPDATE sales_rep SET store_id = new_store_id
		WHERE first_name LIKE first_initial || '%' AND last_name = last_;
	END IF;
	IF employ_type = 'mechanic' THEN 
		UPDATE mechanic SET store_id = new_store_id
		WHERE first_name LIKE first_initial || '%' AND last_name = last_;
	END IF;
END;
$$;


CALL change_employee_store('sales_rep',  'O', 'Buggy', 2);



--procedure to add car to car_sale table;
--first create instance of 'car'
--link its id into car_sale 
--                       with car sales info

CREATE OR REPLACE PROCEDURE add_car_to_lot(
	car_make VARCHAR(20),
	car_model VARCHAR(50),
	car_color VARCHAR(20),
	car_year INTEGER,
	custom_tf BOOLEAN, 
	custom_descr VARCHAR(200), 
	wholesale_price NUMERIC(8,2), 
	sticker_price NUMERIC(8,2), 
	promo_tf BOOLEAN, 
	to_lot_date TIMESTAMP, 
	store_id_num INTEGER, 
	pre_owned_tf BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO car (make, model, color, year_)
	VALUES (car_make,
		car_model,
		car_color, 
		car_year
	);
	INSERT INTO car_sale (car_id, custom, custom_descr, wholesale, sticker, promo, to_lot, store_id, pre_owned)
	VALUES ((SELECT max(car_id) FROM car),
		custom_tf,
		custom_descr,
		wholesale_price,
		sticker_price,
		promo_tf,
		to_lot_date,
		store_id_num,
		pre_owned_tf
	);
END;
$$;

CALL add_car_to_lot('Toyota', 'Corolla', 'beige', 2003, FALSE, NULL, 275, 2199, FALSE, '2014-03-01', 3, TRUE);
CALL add_car_to_lot('Jeep', 'Grand Cherokee', 'forest green', 2005, FALSE, NULL, 2450, 17299, FALSE, '2017-03-01', 3, TRUE);
CALL add_car_to_lot('Nissan', 'Sentra', 'white', 2008, FALSE, NULL, 650, 4129, FALSE, '2017-06-030', 4, TRUE);
CALL add_car_to_lot('Hyundai', 'Elantra', 'black', 2001, FALSE, NULL, 175, 1859, FALSE, '2013-08-031', 2, TRUE);


--procedure to add customer_car
--FIRST - make the car
--THEN link it to customer_car using car_id
--		if customer purchased from dealer, car_id will already exist (and be linked to car_sale)

CREATE OR REPLACE PROCEDURE add_customer_car(customer_last_name VARCHAR(50), customer_first_name VARCHAR(50), car_make VARCHAR(20), car_model VARCHAR(50), car_color VARCHAR(20), car_year INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN  
	INSERT INTO car (make, model, color, year_)
	VALUES (car_make,
		car_model,
		car_color, 
		car_year
	);
	INSERT INTO customer_car (car_id, customer_id, car_sale_id)
	VALUES (
		(SELECT max(car_id) FROM car),
		(SELECT customer_id FROM customer WHERE last_name = customer_last_name AND first_name = customer_first_name),
		(SELECT car_sale_id FROM car_sale WHERE car_sale_id = (SELECT max(car_id) FROM car))  
	);
END;
$$;


CALL add_customer_car('Lission-Coors', 'Veronica', 'Chevroket', 'Camaro', 'cherry', 1999);
CALL add_customer_car('Stout', 'Max', 'BMW', 'Z4', 'black', 2003);
CALL add_customer_car('Fender', 'Denton', 'BMW', '3 Series', 'silver', 2006);
CALL add_customer_car('Cranky', 'Sloan', 'Cadillac', 'DeVille', 'sand', 2004);
CALL add_customer_car('Krallen', 'U.B.', 'Cadillac', 'DeVille', 'burgundy', 2002);
CALL add_customer_car('Chow-Annapoppoeilli', 'Dawn', 'Jeep', 'Wrangler', 'yellow', 2001);
CALL add_customer_car('Chizzit', 'Emma', 'Toyota', 'Tercel', 'blue', 1991);
CALL add_customer_car('Lission-Coors', 'Veronica', 'Land Rover', 'Range Rover', 'red', 2007);




--function to return NUMBER of cars owned by certain customer
CREATE OR REPLACE FUNCTION get_cust_car_count(customer_last_name VARCHAR(50), customer_first_name VARCHAR(50))
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
	DECLARE car_count INTEGER;
BEGIN 
	SELECT count(*) INTO car_count -- this IS how we RETURN the value(we declared this variable as the result of this action)
	FROM customer_car
	WHERE customer_id = (
		SELECT customer_id 
		FROM customer
		WHERE last_name = customer_last_name AND first_name = customer_first_name
	);
	RETURN car_count;
END;
$$

DROP PROCEDURE new_service_ticket;

SELECT *
FROM car;

--procedure for making service ticket
CREATE OR REPLACE PROCEDURE new_service_ticket(car_id_num INTEGER, descr_ VARCHAR(100))
LANGUAGE plpgsql
AS $$
BEGIN  
	INSERT INTO service_ticket (car_id, description, date_in)
	VALUES (car_id_num,
		descr_,
		NOW()
	);
END;
$$;

CALL new_service_ticket(6, 'oil change');


--procedure for mechanic working on car
CREATE OR REPLACE PROCEDURE log_mech_service(mech_id_num INTEGER, service_ticket_id_num INTEGER, descr_ VARCHAR(100), date_of_work TIMESTAMP, hours_worked NUMERIC(4,2))
LANGUAGE plpgsql
AS $$
BEGIN  
	INSERT INTO service_mechanic(mech_id, service_ticket_id, description, date_, service_hours)
	VALUES (mech_id_num,
		service_ticket_id_num,
		descr_,
		date_of_work,
		hours_worked
	);
END;
$$;



--procedure for making invoice



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









