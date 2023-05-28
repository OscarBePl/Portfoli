DROP DATABASE IF EXISTS concessionary;
CREATE DATABASE concessionary;
USE concessionary;

CREATE TABLE city (
	id_city		TINYINT(3)	AUTO_INCREMENT,
	name		VARCHAR(30)	NOT NULL,
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
    city			VARCHAR(30)	DEFAULT 'Barcelona',
	email			VARCHAR(40),
	PRIMARY KEY (id_client),
    CONSTRAINT uk_client_dni UNIQUE (dni),
    CONSTRAINT ck_client_date_of_birth CHECK (date_of_birth < '2004-01-01')
) AUTO_INCREMENT=101;

CREATE TABLE factory (
    id_factory		TINYINT(3)	AUTO_INCREMENT,
    city			VARCHAR(20),
    address			VARCHAR(30),
    phone_number	CHAR(9),
    email			VARCHAR(40),
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
    email			VARCHAR(40),
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
    address				VARCHAR(50),
    city				VARCHAR(30) DEFAULT 'Barcelona',
    email				VARCHAR(40),
    contract_start_date DATE NOT NULL,
    manager_id 			SMALLINT(5),
    PRIMARY KEY (id_salesman),
    CONSTRAINT fk_salesman_salesman FOREIGN KEY (manager_id) REFERENCES salesman(id_salesman),
    CONSTRAINT uk_salesman_dni UNIQUE (dni),
    CONSTRAINT ck_salesman_date_of_birth CHECK (date_of_birth < '2004-01-01')
);

CREATE TABLE factory_model (
	id_factory	INTEGER(8)	AUTO_INCREMENT,
    factory_id	TINYINT(3),
    model_id	SMALLINT(5),
    PRIMARY KEY	(id_factory),
	CONSTRAINT fk_factory_model_factory FOREIGN KEY (factory_id) REFERENCES factory(id_factory),
    CONSTRAINT fk_factory_model_model FOREIGN KEY (model_id) REFERENCES model(id_model)
) AUTO_INCREMENT=1000;

CREATE TABLE car_client_salesman (
	id_car				INTEGER(8)	AUTO_INCREMENT,
    car_id				SMALLINT(5),
    client_id			SMALLINT(5),
    salesman_id 		SMALLINT(5),
    date_of_purchase	DATE DEFAULT CURRENT_TIMESTAMP,
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

INSERT INTO city (name, postal_code, country) VALUES ('Barcelona', '08010', 'Spain');
INSERT INTO city (name, postal_code, country) VALUES ('Madrid', '28011', 'Spain');
INSERT INTO city (name, postal_code, country) VALUES ('Valencia', '46002', 'Spain');
INSERT INTO city (name, postal_code, country) VALUES ('Ripollet', '08291', 'Spain');
INSERT INTO city (name, postal_code, country) VALUES ('Sabadell', '08203', 'Spain');
INSERT INTO city (name, postal_code, country) VALUES ('Terrasa', '08225', 'Spain');
INSERT INTO city (name, postal_code, country) VALUES ('Cerdanyola del Vallès', '08290', 'Spain');
INSERT INTO city (name, postal_code, country) VALUES ('Castellbisbal', '08755', 'Spain');
INSERT INTO city (name, postal_code, country) VALUES ('Manresa', '08243', 'Spain');
INSERT INTO city (name, postal_code, country) VALUES ('Sant Cugat del Vallès', '08172', 'Spain');

INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, city, email)
	VALUES ('47898945X', 'Pep', 'Avila', null, '1985-06-19', 'C/ Manuel de Falla 20', 'Barberà deL Vallès', 'PepAvila@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, city, email)
	VALUES ('89094242Z', 'Josefa', 'Perez', '678902040', '1983-06-23', 'C/ del Puerto de Somosierra 6', 'Madrid', 'JosefaPerez@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, city, email)
	VALUES ('45881631N', 'Oscar', 'Bellerino', '687007897', '1988-09-16', 'C/ Sabadell 6', 'Terrassa', 'OscarBellerino@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, city, email)
	VALUES ('47941730R', 'Marc', 'Cristóbal', '610064025', '1992-03-27', 'Av. Gayarre 19', 'Castellbisbal', 'MarcCristobal@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, city, email)
	VALUES ('47898100X', 'Jacinto', 'Cordero', null, '1989-11-10', 'C/ del Conde de Peñalver 16', 'Madrid', 'JacintoCordero@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, city, email)
	VALUES ('47806020X', 'Paula', 'Garcia', '690449000', '1960-02-23', 'C/ dels Plàtans 13', 'Valencia', 'PaulaGarcia@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, email)
	VALUES ('60307833X', 'Rebeca', 'Aniston', '620507890', '1990-08-18', 'C/ Enric Granados 80', 'RebecaAniston@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, email)
	VALUES ('90452956I', 'Pilar', 'Torrezno', null, '1989-01-20', 'C/ Aribau 37', 'PilarTorrezno@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, email)
	VALUES ('47008945R', 'Sofia', 'Carnica', '690901050', '1985-10-23', 'C/ Rosselló 245', 'SoficaCarnica@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, email)
	VALUES ('47009020H', 'Mauricio', 'Leon', '600000001', '1955-12-20', 'C/ Rosselló 546', 'MauricioLeon@gmail.com');
    
INSERT INTO factory VALUES (null, 'Barcelona', 'C/ Acer 34', '931002003', 'seatfactorybarcelona@gmail.com');
INSERT INTO factory VALUES (null, 'Valencia', 'C/ Mecanics 4', '962003004', 'audifactoryvalencia@gmail.com');
INSERT INTO factory VALUES (null, 'Madrid', 'C/ Fuenlabrada 58', '911002003', 'skodafactorymadrid@gmail.com');
INSERT INTO factory VALUES (null, 'Lugo', 'C/ Rua A, As Gándaras 18 ', '982100203', 'seatfactorylugo@gmail.com');
INSERT INTO factory VALUES (null, 'Sevilla', 'C/ Metalurgia 2', '954102003', 'volkswagenfactorysevilla@gmail.com');

INSERT INTO model VALUES (null, 'seat', 'suv', '2015', 'diesel', '115');
INSERT INTO model VALUES (null, 'audi', 'crossover', '2013', 'gasoline', '150');
INSERT INTO model VALUES (null, 'volkswagen', 'coupe', '2020', 'diesel', '190');
INSERT INTO model VALUES (null, 'skoda', 'coupe', '2022', 'gasoline', '90');
INSERT INTO model VALUES (null, 'seat', 'crossover', '2023', 'diesel', '115');
INSERT INTO model VALUES (null, 'skoda', 'suv', '2018', 'diesel', '115');
INSERT INTO model VALUES (null, 'audi', 'sports car', '2019', 'gasoline', '300');
INSERT INTO model VALUES (null, 'volkswagen', 'suv', '2023', 'diesel', '160');
INSERT INTO model VALUES (null, 'skoda', 'coupe', '2023', 'diesel', '75');
INSERT INTO model VALUES (null, 'audi', 'sports car', '2023', 'electric', '199');

INSERT INTO dealership VALUES (null, 'C/ Aribau 23', '938903045', 'seatbarcelona@gmail.com', '1');
INSERT INTO dealership VALUES (null, 'Paseo de la Castellana 60', '918904050', 'seatmadrid@gmail.com', '2');
INSERT INTO dealership VALUES (null, 'C/ Jesus 71', '962893045', 'skodavalencia@gmail.com', '3');
INSERT INTO dealership VALUES (null, 'C/ Calvari 31', '938443678', 'audiripollet@gmail.com', '4');
INSERT INTO dealership VALUES (null, 'C/ Gracia 30', '937703045', 'seatsabadell@gmail.com', '5');
INSERT INTO dealership VALUES (null, 'C/ Antoni Bros 44', '936703045', 'volkswagenterrassa@gmail.com', '6');
INSERT INTO dealership VALUES (null, 'Ronda Guinardo 2', '938793456', 'volkswagencerdanyola@gmail.com', '7');
INSERT INTO dealership VALUES (null, 'C/ Motors 67', '937729087', 'audicastellbisbal@gmail.com', '8');
INSERT INTO dealership VALUES (null, 'C/ Sant Bartomeu 12', '938909045', 'volkswagenmanresa@gmail.com', '9');
INSERT INTO dealership VALUES (null, 'Avinguda de Cerdanyola 92', '938903408', 'skodasantcugat@gmail.com', '10');

INSERT INTO car VALUES (null, 'WVGZZZ5NZJM131395', 'black', default, '30690', 1, 5);
INSERT INTO car VALUES (null, 'WVGZZZ5NZJM131396', 'white', default, '30690', 1, 5);
INSERT INTO car VALUES (null, 'WVGZZZ5NZJM131397', 'yellow', default, '30690', 2, 5);
INSERT INTO car VALUES (null, 'WVGZZZ5NZJM131398', 'red', default, '30690', 2, 5);
INSERT INTO car VALUES (null, 'WVGZZZ5NZJM131399', 'yellow', default, '30690', 5, 5);
INSERT INTO car VALUES (null, 'WVGZZZ5NZJM131400', 'black', default, '30690', 5, 5);
INSERT INTO car VALUES (null, '1G1YM3D78E9HD23MR', 'white', default, '23000', 3, 9);
INSERT INTO car VALUES (null, '1G1YM3D78E9HD24MR', 'blue', default, '23000', 3, 9);
INSERT INTO car VALUES (null, '1G1YM3D78E9HD25MR', 'black', default, '23000', 10, 9);
INSERT INTO car VALUES (null, '1G1YM3D78E9HD26MR', 'red', default, '23000', 10, 9);
INSERT INTO car VALUES (null, 'VF7S6NFXB57818400', 'black', '80545', '17000', 3, 6);
INSERT INTO car VALUES (null, 'LJCPCBLCX11000237', 'yellow', '64957', '67500', 4, 7);
INSERT INTO car VALUES (null, 'JN1BBAB14Z0010370', 'red', '102420', '5000', 5, 1);
INSERT INTO car VALUES (null, '1HGCM82633A004352', 'blue', default, '80600', 4, 10);
INSERT INTO car VALUES (null, '1HGCM82633A004353', 'red', default, '80600', 4, 10);
INSERT INTO car VALUES (null, '1HGCM82633A004354', 'yellow', default, '80600', 4, 10);
INSERT INTO car VALUES (null, '1HGCM82633A004355', 'black', default, '80600', 8, 10);
INSERT INTO car VALUES (null, '1HGCM82633A004356', 'blue', default, '80600', 8, 10);
INSERT INTO car VALUES (null, 'WBA4H91010BB98492', 'white', default, '43200', 7, 8);
INSERT INTO car VALUES (null, 'WBA4H91010BB98493', 'blue', default, '43200', 7, 8);
INSERT INTO car VALUES (null, 'WBA4H91010BB98494', 'yellow', default, '43200', 6, 8);
INSERT INTO car VALUES (null, 'WBA4H91010BB98495', 'red', default, '43200', 6, 8);
INSERT INTO car VALUES (null, 'WBA4H91010BB98496', 'black', default, '43200', 9, 8);
INSERT INTO car VALUES (null, 'WBA4H91010BB98497', 'white', default, '43200', 9, 8);
INSERT INTO car VALUES (null, 'WBA4H91010BB98498', 'blue', default, '43200', 6, 8);
INSERT INTO car VALUES (null, 'MNCLSFE405W491230', 'black', '154768', '20000', 8, 2);
INSERT INTO car VALUES (null, '1HGBH41JXMN109186', 'red', '33003', '30499', 9, 3);
INSERT INTO car VALUES (null, 'TMBLJ7NU7J5000127', 'blue', '16715', '25000', 10, 4);

INSERT INTO salesman VALUES (null, '23562344S', 'Carlos', 'Plaza', '679422019', '1979-08-08', 'C/ Marquès de Sentmenat 35', default, 'CarlosPlaza@gmail.com', '2002-08-12', null);
INSERT INTO salesman VALUES (null, '77545678P', 'Ana', 'Hernández', '600752435', '1978-04-23', 'C/ Cartagena 71', 'Madrid', 'AnaHernandez@gmail.com', '2003-04-27', null);
INSERT INTO salesman VALUES (null, '86547218Y', 'Daniel', 'Cazorla', '611511789', '1988-03-20', 'C/ Jorge Juan 19', 'Valencia', 'DanielCazorlagmail.com', '2007-05-15', null);
INSERT INTO salesman VALUES (null, '95178462B', 'Ramiro', 'Colleja', '619875342', '1975-11-15', 'C/ Francesc Pi i Margall 89', 'Sant Boi de Llobregat', 'RamiroCollejagmail.com', '1999-08-22', null);
INSERT INTO salesman VALUES (null, '69342457F', 'Jaime', 'Garrido', '666384724', '1985-08-12', 'Passeig Vint-i-Dos de Juliol 102', 'Terrassa', 'JaimeGarrido@gmail.com', '2015-02-01', 1);
INSERT INTO salesman VALUES (null, '47876478J', 'Rosa', 'Gonzalez', '623406765', '1989-01-11', 'Rambla de Sant Jordi 54', 'Ripollet', 'RosaGonzalez@gmail.com', '2014-10-15', 1);
INSERT INTO salesman VALUES (null, '92345745R', 'Pedro', 'Martínez', '634544456', '1980-12-31', 'C/ Sta. Marcelina 28', 'Cerdanyola del Vallès', 'PedroMartinez@gmail.com', '2014-07-20', 1);
INSERT INTO salesman VALUES (null, '23568546E', 'Manuel', 'Fernández', '688904356', '1985-09-15', 'Plaça dels Quatre Cantons 3', 'Sant Cugat del Vallès', 'ManuelFernandez@gmail.com', '2015-11-10', 1);
INSERT INTO salesman VALUES (null, '45644385N', 'Federico', 'Grapadora', '653477668', '1991-10-11', 'C/ Muralla del Carme 18', 'Manresa', 'FedericoGrapadora@gmail.com', '2016-09-30', 1);
INSERT INTO salesman VALUES (null, '19673467L', 'Inma', 'Roldán', '617567666', '1990-03-04', 'Av. Peris i Valero 118', 'Valencia', 'InmaRoldan@gmail.com', '2010-03-09', 3);
INSERT INTO salesman VALUES (null, '67659995G', 'Sergio', 'Martín', '622091574', '1990-01-01', 'C/ de Sant Cugat 8', 'Sabadell', 'SergioMartin@gmail.com', '2016-01-01', 1);
INSERT INTO salesman VALUES (null, '86435655D', 'Eva', 'López', '642874409', '1987-07-26', 'C/ Pi i Maragall 15', 'Castellbisbal', 'EvaLopez@gmail.com', '2012-07-25', 4);
INSERT INTO salesman VALUES (null, '58879985A', 'Rodrigo', 'Palacio', '622879544', '1995-06-15', 'C/ Villaverde 1', 'Getafe', 'RodrigoPalacio@gmail.com', '2010-06-04', 2);
INSERT INTO salesman VALUES (null, '45125387F', 'Carmen', 'Rodríguez', '615428798', '1994-04-19', 'Av. Fuenlabrada 28', 'Leganés', 'CarmenRodriguezgmail.com', '2008-04-29', 2);
INSERT INTO salesman VALUES (null, '38714528N', 'Sofia', 'Pérez', '699187525', '1990-01-22', 'C/ de Cal Gerrer', 'Rubí', 'SofiaPerezgmail.com', '2019-06-08', 4);
INSERT INTO salesman VALUES (null, '87541825K', 'Laura', 'García', '625187435', '1975-12-03', 'C/ Montaca 32', 'Castellar del Vallès', 'LauraGarciagmail.com', '2014-09-26', 4);
INSERT INTO salesman VALUES (null, '46587898L', 'Natalia', 'Ramírez', '699876542', '1981-07-09', 'C/ Palaudàries', 'Granollers', 'NataliaRamirez', '2016-06-26', 4);
INSERT INTO salesman VALUES (null, '52897641A', 'Rigoberta', 'Molina', '628252535', '2002-01-11', 'Rambla de les Bòbiles 8', 'Martorell', 'RigobertaMolinagmail.com', '2021-10-18', 4);
INSERT INTO salesman VALUES (null, '97125366V', 'Pascual', 'Puigdemont', '636187954', '1966-08-20', 'C/ Salvador Baroné 68', 'Viladecans', 'PascualPuigdemontgmail.com', '2005-04-26', 4);
INSERT INTO salesman VALUES (null, '48965231J', 'Enrique', 'Pastor', '645213879', '1969-05-16', 'C/ Ramoneda 40', 'Cornellà del Llobregat', 'EnriquePastorgmail.com', '2000-03-01', 4);

INSERT INTO factory_model (id_factory, factory_id, model_id) VALUES (null, 1, 1);
INSERT INTO factory_model (id_factory, factory_id, model_id) VALUES (null, 1, 5);
INSERT INTO factory_model (id_factory, factory_id, model_id) VALUES (null, 4, 1);
INSERT INTO factory_model (id_factory, factory_id, model_id) VALUES (null, 2, 2);
INSERT INTO factory_model (id_factory, factory_id, model_id) VALUES (null, 2, 7);
INSERT INTO factory_model (id_factory, factory_id, model_id) VALUES (null, 2, 10);
INSERT INTO factory_model (id_factory, factory_id, model_id) VALUES (null, 3, 4);
INSERT INTO factory_model (id_factory, factory_id, model_id) VALUES (null, 3, 6);
INSERT INTO factory_model (id_factory, factory_id, model_id) VALUES (null, 3, 9);
INSERT INTO factory_model (id_factory, factory_id, model_id) VALUES (null, 5, 3);
INSERT INTO factory_model (id_factory, factory_id, model_id) VALUES (null, 5, 8);

INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 1, 102, 13, '2023-01-10');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 2, 105, 14, '2023-01-16');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 3, 102, 14, '2022-11-12');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 4, 101, 5, '2022-09-30');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 5, 103, 6, '2022-07-16');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 6, 104, 7, '2022-05-30');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 7, 107, 8, '2023-01-03');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 8, 106, 10, '2023-01-04');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 9, 106, 10, '2022-08-26');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 10, 108, 9, '2022-10-10');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 11, 109, 11, '2020-04-25');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 12, 110, 12, '2019-12-20');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 13, 101, 15, '2017-06-08');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 14, 103, 16, '2022-02-18');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 15, 104, 17, '2022-06-24');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 16, 107, 18, '2022-09-04');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 17, 108, 19, '2022-11-25');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 18, 109, 20, '2022-12-07');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 19, 110, 5, '2022-07-19');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 20, 101, 6, '2022-04-05');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 21, 103, 7, '2022-05-04');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 22, 104, 8, '2022-08-16');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 23, 107, 9, '2022-03-15');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 24, 108, 11, '2022-01-30');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 25, 109, 12, '2022-10-12');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 26, 110, 15, '2015-09-24');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 27, 101, 16, '2021-03-19');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 28, 103, 17, '2022-10-30');

INSERT INTO dealership_salesman VALUES (null, 1, 1);
INSERT INTO dealership_salesman VALUES (null, 6, 4);
INSERT INTO dealership_salesman VALUES (null, 2, 2);
INSERT INTO dealership_salesman VALUES (null, 2, 13);
INSERT INTO dealership_salesman VALUES (null, 2, 14);
INSERT INTO dealership_salesman VALUES (null, 3, 3);
INSERT INTO dealership_salesman VALUES (null, 3, 10);
INSERT INTO dealership_salesman VALUES (null, 1, 5);
INSERT INTO dealership_salesman VALUES (null, 9, 5);
INSERT INTO dealership_salesman VALUES (null, 1, 6);
INSERT INTO dealership_salesman VALUES (null, 9, 6);
INSERT INTO dealership_salesman VALUES (null, 5, 7);
INSERT INTO dealership_salesman VALUES (null, 6, 7);
INSERT INTO dealership_salesman VALUES (null, 10, 8);
INSERT INTO dealership_salesman VALUES (null, 7, 8);
INSERT INTO dealership_salesman VALUES (null, 10, 9);
INSERT INTO dealership_salesman VALUES (null, 9, 9);
INSERT INTO dealership_salesman VALUES (null, 10, 11);
INSERT INTO dealership_salesman VALUES (null, 6, 11);
INSERT INTO dealership_salesman VALUES (null, 4, 12);
INSERT INTO dealership_salesman VALUES (null, 7, 12);
INSERT INTO dealership_salesman VALUES (null, 5, 15);
INSERT INTO dealership_salesman VALUES (null, 8, 15);
INSERT INTO dealership_salesman VALUES (null, 8, 16);
INSERT INTO dealership_salesman VALUES (null, 9, 16);
INSERT INTO dealership_salesman VALUES (null, 4, 17);
INSERT INTO dealership_salesman VALUES (null, 10, 17);
INSERT INTO dealership_salesman VALUES (null, 4, 18);
INSERT INTO dealership_salesman VALUES (null, 8, 19);
INSERT INTO dealership_salesman VALUES (null, 8, 20);

-- Task 1.
# Show some columns with two filters where the null value is involved.

SELECT date_of_birth, city, email 
	FROM client 
    WHERE date_of_birth >='1980-01-01' AND phone_number IS NULL;

-- Task 2.
# Show some columns with an alphanumeric filter, where the value of a column ends with specific characters.

SELECT frame, color, km 
	FROM car 
    WHERE frame LIKE '%MR';

-- Task 3.
# Show some columns with a filter between two values. 

SELECT brand, type, year, power 
	FROM model 
    WHERE year BETWEEN 2020 AND 2022;

-- Task 4.
# Show all columns using a LIKE filter.

SELECT * 
	FROM city 
    WHERE name LIKE 'B%';

-- Task 5.
# Show the result of an aggregation function with a filter that combines AND and OR.

SELECT AVG(price) AS average_price
   FROM car
   WHERE (model_id='5' OR model_id='9') AND color='black';

-- Task 6.
# Show some columns with a numerical filter and use an aggregation function.

SELECT frame, color, SUM(price) as total_price 
	FROM car 
	WHERE price BETWEEN 30000 AND 40000; 

-- Task 7.
# Show all columns with a subset of information with a filter that uses a mathematical function.

SELECT *
	FROM model
	WHERE power > (SELECT AVG(power) FROM model);

-- Task 8.
# Show some columns with three filters AND where one of the filters uses a character function.

SELECT LEFT(name, 3), LEFT(surname, 3), dni
	FROM salesman
    WHERE date_of_birth > 1989-12-31 AND contract_start_date > 2015-12-31 AND city = 'Sabadell';

-- Task 9.
# Show some columns using character functions with an alphanumeric filter.

SELECT address, phone_number, UPPER(email) AS mayus
	FROM dealership
    WHERE id_dealership > 5;

-- Task 10.
# Show all columns applying a filter and use a date function.

SELECT *
	FROM client
    WHERE DAYOFMONTH(date_of_birth) < 15;