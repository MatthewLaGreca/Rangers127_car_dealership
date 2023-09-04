CREATE TABLE salespeople (
  salesperson SERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50)
);

CREATE TABLE customers (
  customer SERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  buying_car BOOLEAN
);

CREATE TABLE invoices (
  invoice_number SERIAL PRIMARY KEY,
  salesperson INTEGER,
  customer INTEGER,
  sub_total NUMERIC(8,2),
  taxes_and_fees NUMERIC(7,2),
  grand_total NUMERIC(8,2),
  date_of_sale DATE,
  FOREIGN KEY (salesperson) REFERENCES salespeople(salesperson), 
  FOREIGN KEY (customer) REFERENCES customers(customer) 
);

CREATE TABLE service (
  service_ticket SERIAL PRIMARY KEY,
  service_provided VARCHAR(200),
  cost NUMERIC(7,2)
);

CREATE TABLE mechanics (
  mechanic SERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50)
);

CREATE TABLE parts (
  part SERIAL PRIMARY KEY,
  stock INTEGER,
  part_name VARCHAR(30)
);

CREATE TABLE cars (
  car_serial_number SERIAL PRIMARY KEY,
  make VARCHAR(50),
  model VARCHAR(50),
  year VARCHAR(4),
  color VARCHAR(15),
  salesperson INTEGER,
  customer INTEGER,
  service_ticket INTEGER,
  mechanic INTEGER,
  part INTEGER,
  FOREIGN KEY (salesperson) REFERENCES salespeople(salesperson),
  FOREIGN KEY (customer) REFERENCES customers(customer),
  FOREIGN KEY (service_ticket) REFERENCES service(service_ticket),
  FOREIGN KEY (mechanic) REFERENCES mechanics(mechanic),
  FOREIGN KEY (part) REFERENCES parts(part)
);

CREATE TABLE service_history (
  service_instance SERIAL PRIMARY KEY,
  car_serial_number INTEGER,
  date_of_service DATE,
  FOREIGN KEY (car_serial_number) REFERENCES cars(car_serial_number)
);

