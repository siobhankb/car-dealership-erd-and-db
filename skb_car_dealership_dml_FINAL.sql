--populate *sales_rep* table
INSERT INTO sales_rep (last_name, first_name, hire_date, store_id)
VALUES ('Tappet',
	'Click',
	'2012-01-03',  
	2
),('Tappet',
	'Clack',
	'2012-01-03',  
	3
),('Annodime',
	'Nicole',
	'2012-06-01',  
	2
),('El-Emmons',
	'Eustace',
	'2012-03-14',  
	3
),('Itznot',
	'Alexis',
	'2012-10-30',  
	3
),('Mahdel',
	'Megan',
	'2018-12-01',  
	4
),('Segusi',
	'Lou',
	'2014-02-14',  
	4
),('Carr',
	'Lisa',
	'2014-02-28',  
	4
),('Rigg',
	'Zbigniew',
	'2015-11-01',  
	5
),('Buggy',
	'Orson',
	'2019-01-10',  
	5
),('Bee-Hoffinett',
	'Ewell',
	'2019-01-31',  
	5
),('Shaw',
	'Rick',
	'2021-11-01',  
	5
);


--populate *mechanic* table
INSERT INTO mechanic (last_name, first_name, hire_date, store_id)
VALUES ('Ytziflatt',
	'Yasir',
	'2012-01-22',  
	2
),('Gogh',
	'Don Juan',
	'2012-01-30',  
	2
),('Gallore',
	'Rex',
	'2018-06-15',  
	3
),('Greasepan',
	'Alan',
	'2018-06-21',  
	3
),('Hammer',
	'Anita ',
	'2018-06-21',  
	2
),('Plyreslippe',
	'Tilda',
	'2021-05-30',  
	3
),('Boltz',
	'Lucinda',
	'2019-04-15',  
	5
),('Hoyt',
	'Kent',
	'2019-05-01',  
	5
),('Ibraikyrfais',
	'Euripedes ',
	'2021-08-16',  
	5
);


--populate *customer* table
INSERT INTO customer (last_name, first_name, email, phone, street, city, state, zip)
VALUES ('Von Dreiver',
	'Minnie',
	'chauffeur@soccer-mom.com', 
	'(123)123-1233', 
	'111 Payne Alley', 
	'Nautymnah', 
	'MO', 
	55666
),('Bach',
	'Wayne',
	'backseat.driver@annoyme.com', 
	'(873)469-3234', 
	'101 Caouche Petaita Circle', 
	'Laissez Faire', 
	'LA', 
	33221
),('Lission-Coors',
	'Veronica',
	'lookm@no-hands.com', 
	'(800)333-7777', 
	'321 Fast Lane', 
	'Rasier', 
	'AZ', 
	20911
),('Stout',
	'Max',
	'bigspender@charge-it.com', 
	'(521)345-6789', 
	'628 Easy  St', 
	'Ticky Tacky', 
	'CA', 
	90210
),('Chizzit',
	'Emma',
	'penny.pincher@save-up.com', 
	'(925)925-6600', 
	'401 K St', 
	'Goldwater', 
	'WA', 
	77890
),('Cranky',
	'Sloan',
	'grumpy-old@man.com', 
	'', 
	'', 
	'', 
	'', 
	null
),('Fender',
	'Denton',
	'cantsy@too-good.com', 
	'(341)387-5409', 
	'Pottolie Rd', 
	'Boulder', 
	'CO', 
	80529
),('Chow-Annapoppoeilli',
	'Dawn',
	'risque@dare-deville.com', 
	'(911)521-8686', 
	'Duraga Reyes Boulevard', 
	'Ring of Fire', 
	'HI', 
	99911
),('Krallen',
	'U.B.',
	'wheres-my-todo-list@forget-it.com', 
	'(211)555-4488', 
	'Sloan Steddie Way', 
	'Chillen', 
	'OK', 
	56731
),('Heap',
	'Iona',
	'bike2work@commuter.com', 
	'(678)322-9430', 
	'649 Gaz Guzzlah Gulch', 
	'Sapplannetis', 
	'IL', 
	56731
),('Raunde',
	'Althea',
	'scenic@route.com', 
	'(121)234-5678', 
	'445 Taika Dalonga Way', 
	'Fuhnfurrevah', 
	'ME', 
	01240
);


--populate *store* table
INSERT INTO store (store_name)
VALUES ('Wheel Dealz');

INSERT INTO store (store_name)
VALUES ('Drive-A-Way Dealz');

INSERT INTO store (store_name)
VALUES ('Shifting Gearz Hybrid Auto Dealz');

INSERT INTO store (store_name)
VALUES ('Four Wheel Dealz');

