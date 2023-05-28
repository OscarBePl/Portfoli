DROP DATABASE IF EXISTS concessionary;
CREATE DATABASE concessionary;
USE concessionary;

CREATE TABLE city (
	id_city		TINYINT(3)	AUTO_INCREMENT,
	name		VARCHAR(20)	NOT NULL,
	postal_code	CHAR(5),
	country		VARCHAR(15),
	PRIMARY KEY (id_city)
);

CREATE TABLE client (
	id_client		SMALLINT(5)	AUTO_INCREMENT,
	dni				CHAR(9)	NOT NULL,
	name			VARCHAR(15) NOT NULL,
	surname			VARCHAR(25) NOT NULL,
	phone_number	CHAR(9),
	date_of_birth	DATE,
	address			VARCHAR(30),
    city			VARCHAR(20)	DEFAULT 'Barcelona',
	email			VARCHAR(20),
	PRIMARY KEY (id_client),
    CONSTRAINT uk_client_dni UNIQUE (dni),
    CONSTRAINT ck_client_date_of_birth CHECK (date_of_birth > '2004-01-01')
);

CREATE TABLE factory (
    id_factory		TINYINT(3)	AUTO_INCREMENT,
    city			VARCHAR(20),
    address			VARCHAR(30),
    phone_number	CHAR(9),
    email			VARCHAR(20),
    PRIMARY KEY (id_factory)
);

CREATE TABLE model (
    id_model	SMALLINT(5)	AUTO_INCREMENT,
    brand		ENUM('seat','volkswagen','skoda','audi'),
    type		ENUM('suv','crossover','coupe','sports car'),
    year		YEAR(4),
    engine		ENUM('diesel','gasoline','electric'),
    power		CHAR(3),
    PRIMARY KEY (id_model),
    CONSTRAINT ck_model_year CHECK (year > '2002')
);

CREATE TABLE dealership (
    id_dealership	TINYINT(3)	AUTO_INCREMENT,
    address			VARCHAR(30),
    phone_number	CHAR(9),
    email			VARCHAR(20),
    city_id			TINYINT(3),
    PRIMARY KEY (id_dealership),
    CONSTRAINT fk_dealership_city FOREIGN KEY (city_id) REFERENCES city(id_city)
);

CREATE TABLE car (
    id_car			SMALLINT(5)	AUTO_INCREMENT,
    frame			CHAR(17)	NOT NULL,
    color			ENUM('black','white','blue','red','yellow'),
    km				MEDIUMINT(6)	DEFAULT '0',
    price			DECIMAL(7,2),
    dealership_id	TINYINT(3),
    model_id 		SMALLINT(5),
    PRIMARY KEY (id_car),
    CONSTRAINT fk_car_dealership FOREIGN KEY (dealership_id) REFERENCES dealership(id_dealership),
    CONSTRAINT fk_car_model FOREIGN KEY (model_id) REFERENCES model(id_model),
    CONSTRAINT uk_car_frame UNIQUE (frame),
	CONSTRAINT ck_car_km CHECK (km < 200000)
);

CREATE TABLE salesman (
    id_salesman			SMALLINT(5)	AUTO_INCREMENT,
    dni					CHAR(9)	NOT NULL,
    name				VARCHAR(15) NOT NULL,
    surname 			VARCHAR(25) NOT NULL,
    phone_number		CHAR(9),
    date_of_birth		DATE,
    address				VARCHAR(30),
    city				VARCHAR(20) DEFAULT 'Barcelona',
    email				VARCHAR(20),
    contract_start_date DATE NOT NULL,
    manager_id 			SMALLINT(5),
    PRIMARY KEY (id_salesman),
    CONSTRAINT fk_salesman_salesman FOREIGN KEY (manager_id) REFERENCES salesman(id_salesman),
    CONSTRAINT uk_salesman_dni UNIQUE (dni),
    CONSTRAINT ck_salesman_date_of_birth CHECK (date_of_birth > '2004-01-01')
);

CREATE TABLE factory_model (
	id_factory	INTEGER(8)	AUTO_INCREMENT,
    factory_id	TINYINT(3),
    model_id	SMALLINT(5),
    PRIMARY KEY	(id_factory),
	CONSTRAINT fk_factory_model_factory FOREIGN KEY (factory_id) REFERENCES factory(id_factory),
    CONSTRAINT fk_factory_model_model FOREIGN KEY (model_id) REFERENCES model(id_model)
);

CREATE TABLE car_client_salesman (
	id_car				INTEGER(8)	AUTO_INCREMENT,
    car_id				SMALLINT(5),
    client_id			SMALLINT(5),
    salesman_id 		SMALLINT(5),
    date_of_purchase	DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_car),
    CONSTRAINT fk_car_client_salesman_car FOREIGN KEY (car_id) REFERENCES car(id_car),
    CONSTRAINT fk_car_client_salesman_client FOREIGN KEY (client_id) REFERENCES client(id_client),
    CONSTRAINT fk_car_client_salesman_salesman FOREIGN KEY (salesman_id) REFERENCES salesman(id_salesman)
);

CREATE TABLE dealership_salesman (
	id_dealership	SMALLINT(5)	AUTO_INCREMENT,
    dealership_id	TINYINT(3),
    salesman_id		SMALLINT(5),
    PRIMARY KEY (id_dealership),
    CONSTRAINT fk_dealership_salesman_dealership FOREIGN KEY (dealership_id) REFERENCES dealership(id_dealership),
    CONSTRAINT fk_dealership_salesman_salesman FOREIGN KEY (salesman_id) REFERENCES salesman(id_salesman)
    );

CREATE INDEX ix_client_name ON client(name);
CREATE INDEX ix_client_surname ON client(surname);
CREATE INDEX ix_client_phone_number ON client(phone_number);
CREATE INDEX ix_client_email ON client(email);

CREATE INDEX ix_factory_phone_number ON factory(phone_number);
CREATE INDEX ix_factory_email ON factory(email);

CREATE INDEX ix_model_brand ON model(brand);
CREATE INDEX ix_model_type ON model(type);
CREATE INDEX ix_model_year ON model(year);
ALTER TABLE model ADD INDEX ix_model_engine (engine);
ALTER TABLE model ADD INDEX ix_model_power (power);

ALTER TABLE dealership ADD INDEX ix_dealership_address (address);
ALTER TABLE dealership ADD INDEX ix_dealership_phone_number (phone_number);
ALTER TABLE dealership ADD INDEX ix_dealership_email (email);

ALTER TABLE car ADD INDEX ix_car_frame (frame);
ALTER TABLE car ADD INDEX ix_car_color (color);
ALTER TABLE car ADD INDEX ix_car_km (km);
ALTER TABLE car ADD INDEX ix_car_price (price);

ALTER TABLE salesman ADD INDEX ix_salesman_name (name);
ALTER TABLE salesman ADD INDEX ix_salesman_surname (surname);
ALTER TABLE salesman ADD INDEX ix_salesman_phone_number (phone_number);
ALTER TABLE salesman ADD INDEX ix_salesman_email (email);