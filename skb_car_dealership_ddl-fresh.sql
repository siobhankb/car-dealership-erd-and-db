--Make *store* TABLE 
CREATE TABLE store(
	store_id SERIAL PRIMARY KEY,
	store_name VARCHAR(100),
	store_mgr INTEGER
);


--Make *sales_rep* TABLE 
CREATE TABLE sales_rep(
	sales_rep_id SERIAL PRIMARY KEY,
	last_name VARCHAR(50),
	first_name VARCHAR(50),
	hire_date DATE,
	store_id INTEGER NOT NULL,
	FOREIGN KEY (store_id) REFERENCES store(store_id)
);

--set foreign key for store_id in sales_rep table
ALTER TABLE store
ADD FOREIGN KEY(store_mgr) REFERENCES sales_rep(sales_rep_id);


--Make *mechanic* TABLE 
CREATE TABLE mechanic(
	mech_id SERIAL PRIMARY KEY,
	last_name VARCHAR(50),
	first_name VARCHAR(50),
	hire_date DATE,
	store_id INTEGER NOT NULL,
	FOREIGN KEY (store_id) REFERENCES store(store_id)
);


--Make *customer* TABLE 
CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	last_name VARCHAR(50),
	first_name VARCHAR(50),
	email VARCHAR(50),
	phone VARCHAR(17),
	street VARCHAR(50),
	city VARCHAR(50),
	state VARCHAR(2),
	zip VARCHAR(5)
);


--Make *car* TABLE 
CREATE TABLE car(
	car_id SERIAL PRIMARY KEY,
	make VARCHAR(50),
	model VARCHAR(50),
	year_ INTEGER,
	color VARCHAR(20)
);



--Make *car_sale* TABLE 
CREATE TABLE car_sale(
	car_sale_id SERIAL PRIMARY KEY,
	car_id INTEGER NOT NULL,
	FOREIGN KEY (car_id) REFERENCES car(car_id),
	store_id INTEGER,
	FOREIGN KEY (store_id) REFERENCES store(store_id),
	to_lot DATE,
	pre_owned BOOLEAN,
	custom BOOLEAN,
	custom_descr VARCHAR(200),
	WHOLESALE NUMERIC(8,2),
	sticker NUMERIC(8,2),
	promo BOOLEAN
);


--Make *customer_car* TABLE 
CREATE TABLE customer_car(
	car_id INTEGER NOT NULL,
	FOREIGN KEY (car_id) REFERENCES car(car_id),
	customer_id INTEGER NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	car_sale_id INTEGER,
	FOREIGN KEY (car_sale_id) REFERENCES car_sale(car_sale_id)
);


--Make *invoice* TABLE 
CREATE TABLE invoice(
	invoice_id SERIAL PRIMARY KEY,
	purchase_date TIMESTAMP,
	purchase_price NUMERIC(8,2),
	sales_rep_id INTEGER NOT NULL,
	FOREIGN KEY (sales_rep_id) REFERENCES sales_rep(sales_rep_id),
	store_id INTEGER NOT NULL,
	FOREIGN KEY (store_id) REFERENCES store(store_id),
	customer_id INTEGER NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	car_id INTEGER NOT NULL,
	FOREIGN KEY (car_id) REFERENCES car(car_id)
);


--Make *service_ticket* TABLE 
CREATE TABLE service_ticket(
	service_ticket_id SERIAL PRIMARY KEY,
	car_id INTEGER NOT NULL,
	FOREIGN KEY (car_id) REFERENCES car(car_id),
	description VARCHAR(200),
	date_in TIMESTAMP,
	date_out TIMESTAMP
);


--Make *service_mechanic* TABLE 
CREATE TABLE service_mechanic(
	mech_id INTEGER NOT NULL,
	FOREIGN KEY (mech_id) REFERENCES mechanic(mech_id),
	service_ticket_id INTEGER NOT NULL,
	FOREIGN KEY (service_ticket_id) REFERENCES service_ticket(service_ticket_id),
	description VARCHAR(200),
	service_date TIMESTAMP,
	service_hours NUMERIC(4,2)
);

