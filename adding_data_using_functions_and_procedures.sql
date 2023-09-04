CREATE OR REPLACE FUNCTION add_cust(_first_name VARCHAR, _last_name VARCHAR, _buying_car BOOLEAN)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO customers(first_name, last_name, buying_car)
	VALUES(_first_name, _last_name, _buying_car);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_cust('Jonx','Jones',TRUE);
SELECT add_cust('Piston','Hondo',TRUE);
SELECT add_cust('Tom','Nobar',TRUE);
SELECT add_cust('Johnny','Lawrence',FALSE);

SELECT *
FROM customers;




CREATE OR REPLACE FUNCTION add_salesperson(_first_name VARCHAR, _last_name VARCHAR)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO salespeople(first_name, last_name)
	VALUES(_first_name, _last_name);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_salesperson('Lil','B');
SELECT add_salesperson('Lil','Mac');
SELECT add_salesperson('John','Desire');
SELECT add_salesperson('Terry','Silver');

SELECT *
FROM salespeople;




CREATE OR REPLACE FUNCTION add_mech(_first_name VARCHAR, _last_name VARCHAR)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO mechanics(first_name, last_name)
	VALUES(_first_name, _last_name);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_mech('Krushr','Pants');
SELECT add_mech('Doc', NULL);
SELECT add_mech('Slugma','Wallace');
SELECT add_mech('Nariyoshi','Miyagi');

SELECT *
FROM mechanics;




CREATE OR REPLACE FUNCTION add_service(_service_provided VARCHAR, _cost NUMERIC)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO service(service_provided, cost)
	VALUES(_service_provided, _cost);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_service('Oil change', 50.00);
SELECT add_service('Regular paint job', 500.00);
SELECT add_service('Transmission replacement', 3000.00);
SELECT add_service('"Pay and Spray"', 10000.00);

SELECT *
FROM service;




CREATE OR REPLACE FUNCTION add_part(_part_name VARCHAR, _stock INTEGER)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO parts(part_name, stock)
	VALUES(_part_name, _stock);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_part('Transmission', 100);
SELECT add_part('Tire', 1000);
SELECT add_part('Engine', 500);
SELECT add_part('Light', 1000);

SELECT *
FROM parts;




CREATE OR REPLACE FUNCTION add_car(_make VARCHAR, _model VARCHAR, _year VARCHAR, _color VARCHAR, _salesperson INTEGER, 
								   _customer INTEGER, _service_ticket INTEGER, _mechanic INTEGER, _part INTEGER)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO cars(make, model, year, color, salesperson, customer, service_ticket, mechanic, part)
	VALUES(_make, _model, _year, _color, _salesperson, _customer, _service_ticket, _mechanic, _part);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_car('Totoya', 'Camry', '1993', 'Beige', 
			   3, 3, 5, 3, NULL);
SELECT add_car('Totoya', 'Prius', '2013', 'Orange', 
			   1, 1, NULL, NULL, NULL);
SELECT add_car('Ford', 'Focus', '2014', 'Black', 
			   NULL, 2, 7, 2, 1);
SELECT add_car('Jeep', 'Grand Caravan', '2015', 'Dark Green', 
			   NULL, 4, 6, 3, NULL);
			   
SELECT * FROM cars;



ALTER TABLE invoices
ADD car_serial_number INTEGER;

ALTER TABLE invoices
ADD FOREIGN KEY (car_serial_number) REFERENCES cars(car_serial_number);

SELECT *
FROM invoices;

CREATE OR REPLACE FUNCTION create_invoice(_salesperson INTEGER, _customer INTEGER, _sub_total NUMERIC,
										  _taxes_and_fees NUMERIC, _grand_total NUMERIC, _date_of_sale DATE, _car_serial_number INTEGER)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO invoices(salesperson, customer, sub_total, taxes_and_fees, grand_total, date_of_sale, car_serial_number)
	VALUES(_salesperson, _customer, _sub_total,	_taxes_and_fees, _grand_total, _date_of_sale, _car_serial_number);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT create_invoice(3, 3, 7000.00, 1000.00, 8000.00, '1995-03-10');
SELECT create_invoice(1, 1, 20000.00, 3000.00, 23000.00, '2013-06-09');

UPDATE invoices
SET car_serial_number =1
WHERE salesperson = 3;

UPDATE invoices
SET car_serial_number = 2
WHERE salesperson = 1;



CREATE OR REPLACE FUNCTION create_service_history(_car_serial_number INTEGER, _date_of_service DATE)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO service_history(car_serial_number, date_of_service)
	VALUES(_car_serial_number, _date_of_service);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT create_service_history(1, '2020-10-17');
SELECT create_service_history(3, '2018-06-09');
SELECT create_service_history(4, '2022-07-08');

SELECT *
FROM service_history;

ALTER TABLE cars
ADD is_serviced BOOLEAN;



CREATE OR REPLACE PROCEDURE being_serviced()
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE cars
	SET is_serviced = TRUE
	WHERE service_ticket IS NOT NULL;
	
	UPDATE cars
	SET is_serviced = FALSE
	WHERE service_ticket IS NULL;
	
	COMMIT;
	
END;
$$

CALL being_serviced();

SELECT * FROM cars;

