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

CREATE TABLE department (
	id_department 		SMALLINT(5),
    type				ENUM('Administration', 'Assembly', 'Painting'),				
    phone_number		CHAR(9),
    location			VARCHAR(30),
    manager				VARCHAR(20),
    factory_id			TINYINT(3),
    PRIMARY KEY (id_department, factory_id),
    CONSTRAINT fk_department_factory FOREIGN KEY (factory_id) REFERENCES factory(id_factory)
);

CREATE TABLE administration (
	id_department	 		SMALLINT(5),
    number_of_computers		SMALLINT(3),	
    factory_id				TINYINT(3),
    PRIMARY KEY (id_department, factory_id),
    CONSTRAINT fk_administration_department FOREIGN KEY (id_department) REFERENCES department(id_department)
);

CREATE TABLE assembly (
	id_department	 	SMALLINT(5),
    work_spaces			SMALLINT(3),
	factory_id			TINYINT(3),
	PRIMARY KEY (id_department, factory_id),
	CONSTRAINT fk_assembly_department FOREIGN KEY (id_department) REFERENCES department(id_department)
);

CREATE TABLE painting (
	id_department	 		SMALLINT(5),
    painting_cabins			SMALLINT(3),
	factory_id				TINYINT(3),
	PRIMARY KEY (id_department, factory_id),
	CONSTRAINT fk_painting_department FOREIGN KEY (id_department) REFERENCES department(id_department)
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
ALTER TABLE model ADD INDEX ix_model_engine(engine);
ALTER TABLE model ADD INDEX ix_model_power(power);

ALTER TABLE dealership ADD INDEX ix_dealership_address(address);
ALTER TABLE dealership ADD INDEX ix_dealership_phone_number(phone_number);
ALTER TABLE dealership ADD INDEX ix_dealership_email(email);

ALTER TABLE car ADD INDEX ix_car_frame(frame);
ALTER TABLE car ADD INDEX ix_car_color(color);
ALTER TABLE car ADD INDEX ix_car_km(km);
ALTER TABLE car ADD INDEX ix_car_price(price);

ALTER TABLE salesman ADD INDEX ix_salesman_name(name);
ALTER TABLE salesman ADD INDEX ix_salesman_surname(surname);
ALTER TABLE salesman ADD INDEX ix_salesman_phone_number(phone_number);
ALTER TABLE salesman ADD INDEX ix_salesman_email(email);

CREATE INDEX ix_administration_number_of_computers ON administration(number_of_computers);
CREATE INDEX ix_assembly_work_spaces ON assembly(work_spaces);
CREATE INDEX ix_department_manager ON department(manager);
CREATE INDEX ix_painting_painting_cabins ON painting(painting_cabins);

ALTER TABLE department ADD INDEX ix_department_phone_number(phone_number);
ALTER TABLE department ADD INDEX ix_department_location(location);

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
	VALUES ('47898945X', 'Pep', 'Avila', null, '1985-06-19', 'C/ Manuel de Falla 20', 'Barberà del Vallès', 'PepAvila@gmail.com');
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
	VALUES ('48692500U', 'Pepito', 'Grillo', '623489238', '1967-04-23', 'C/ Industria 86', 'PepitoGrillo@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, city, email)
	VALUES ('89453896F', 'Pedro', 'Picapiedra', '623495856', '1950-11-01', 'C/ del Padre Jesús Ordóñez 12', 'Madrid', 'PedroPicapiedra@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, city, email)
	VALUES ('34534589Z', 'Clementina', 'Pérez', '623432222', '1971-03-17', 'Av. de la Plata 3', 'Valencia', 'ClementinaPerez@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, email)
	VALUES ('87564345D', 'Ana', 'Pana', '634883458', '1970-07-26', 'C/ Marquès de Sentmenat 35', 'AnaPana@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, city, email)
	VALUES ('26485937J', 'Theodore', 'Mosby', '698877651', '1978-04-25', 'C/ Torrent del Batlle 10', 'Terrassa', 'TedMosby@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, city, email)
	VALUES ('23468764C', 'Robin', 'Scherbatsky', '634583640', '1980-07-23', 'C/ de Dinarès 70', 'Sabadell', 'RobinScherbatsky@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, city, email)
	VALUES ('67854351Q', 'Barnabas', 'Stinson', '612345789', '1975-03-30', 'C/ Carrer Gaudí 1', 'Sentmenat', 'BarneyStinson@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, city, email)
	VALUES ('49569847K', 'Marshall', 'Eriksen', '690908474', '1978-01-11', 'Ctra. de Sabadell 60', 'Castellar del Vallès', 'MarshallEriksen@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, city, email)
	VALUES ('87347345W', 'Lily', 'Aldrin', '634646746', '1978-03-22', 'Ctra. de Sabadell 60', 'Castellar del Vallès', 'LilyAldrin@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, email)
	VALUES ('48357455H', 'Jon', 'Snow', '623453423', '1954-08-08', 'C/ Muntaner 88', 'JonSnow@gmail.com');
INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, email)
	VALUES ('35676544G', 'Daenerys', 'Targaryen', '683327463', '1959-09-30', 'Av. Diagonal 450', 'DannyTargaryen@gmail.com');
  
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
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 3, 111, 14, '2022-11-12');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 4, 101, 5, '2022-09-30');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 5, 103, 6, '2022-07-16');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 6, 104, 7, '2022-05-30');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 7, 107, 8, '2023-01-03');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 8, 106, 10, '2023-01-04');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 9, 112, 10, '2022-08-26');
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
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 21, 120, 7, '2022-05-04');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 22, 119, 8, '2022-08-16');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 23, 118, 9, '2022-03-15');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 24, 117, 11, '2022-01-30');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 25, 116, 12, '2022-10-12');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 26, 115, 15, '2015-09-24');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 27, 114, 16, '2021-03-19');
INSERT INTO car_client_salesman (id_car, car_id, client_id, salesman_id, date_of_purchase) VALUES (null, 28, 113, 17, '2022-10-30');

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

INSERT INTO department VALUES (1, 'Administration', '645678733', '2nd floor', 'Jaume Riera', 1);
INSERT INTO department VALUES (2, 'Assembly', '634353489', '1st floor', 'Josep Lopez', 1);
INSERT INTO department VALUES (3, 'Painting', '634567848', '1st floor', 'Josep Lopez', 1);
INSERT INTO department VALUES (1, 'Painting', '634533445', 'Ground floor', 'Gerardo Picatoste', 2);
INSERT INTO department VALUES (2, 'Assembly', '675446797', 'Ground floor', 'Gerardo Picatoste', 2);
INSERT INTO department VALUES (3, 'Administration', '643332099', '1st floor', 'Margarita Pomelo', 2);
INSERT INTO department VALUES (1, 'Assembly', '678789899', '1st floor', 'Francisco Rodríguez', 3);
INSERT INTO department VALUES (2, 'Administration', '643535464', '2nd floor', 'Francisca Martínez', 3);
INSERT INTO department VALUES (3, 'Painting', '678090443', '1st floor', 'Francisca Martínez', 3);
INSERT INTO department VALUES (1, 'Assembly', '655656788', 'Ground floor', 'Maria Dorada', 4);
INSERT INTO department VALUES (2, 'Administration', '655656788', 'Ground floor', 'Maria Dorada', 4);
INSERT INTO department VALUES (1, 'Painting', '678430098', 'Ground floor', 'Jesús Quintana', 5);
INSERT INTO department VALUES (2, 'Administration', '666554787', 'Ground floor', 'Ricardo Torre', 5);

INSERT INTO administration VALUES (1, 15, 1);
INSERT INTO administration VALUES (3, 10, 2);
INSERT INTO administration VALUES (2, 20, 3);
INSERT INTO administration VALUES (2, 5, 4);
INSERT INTO administration VALUES (2, 18, 5);

INSERT INTO assembly VALUES (2, 50, 1);
INSERT INTO assembly VALUES (2, 30, 2);
INSERT INTO assembly VALUES (1, 45, 3);
INSERT INTO assembly VALUES (1, 20, 4);

INSERT INTO painting VALUES (3, 5, 1);
INSERT INTO painting VALUES (1, 7, 2);
INSERT INTO painting VALUES (3, 4, 3);
INSERT INTO painting VALUES (1, 6, 5);

CREATE USER 'superAdmin'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON * TO 'superAdmin'@'localhost';

CREATE USER 'adminConcessionary' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON concessionary TO 'adminConcessionary';

CREATE USER CarlosPlaza IDENTIFIED BY '1234';
CREATE USER RamiroColleja IDENTIFIED BY '1234';
CREATE USER JaimeGarrido IDENTIFIED BY '1234';
CREATE USER RosaGonzalez IDENTIFIED BY '1234';
CREATE USER PedroRamirez IDENTIFIED BY '1234';
CREATE USER ManuelFernandez IDENTIFIED BY '1234';
CREATE USER FedericoGrapadora IDENTIFIED BY '1234';

CREATE ROLE admin;
CREATE ROLE user;

GRANT admin TO CarlosPlaza;
GRANT user TO RamiroColleja;
GRANT user TO JaimeGarrido;
GRANT user TO RosaGonzalez;

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER ON car TO admin;
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER ON salesman TO admin;
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER ON dealership TO admin;
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER ON dealership_salesman TO admin;
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER ON factory_model TO admin;

GRANT SELECT, INSERT, UPDATE ON client TO user;
GRANT SELECT, INSERT, UPDATE ON car_client_salesman TO user;

GRANT SELECT ON client TO PedroRamirez;
GRANT SELECT ON car_client_salesman TO PedroRamirez;
GRANT INSERT, UPDATE ON client TO ManuelFernandez;
GRANT INSERT, UPDATE ON car_client_salesman TO ManuelFernandez;
GRANT SELECT, INSERT, UPDATE ON client TO FedericoGrapadora;
GRANT SELECT, INSERT, UPDATE ON car_client_salesman TO FedericoGrapadora;

REVOKE UPDATE ON client FROM FedericoGrapadora;
REVOKE UPDATE ON car_client_salesman FROM FedericoGrapadora;

DELIMITER //
CREATE PROCEDURE searchPurchases(IN startDate DATE, IN finishDate DATE)
BEGIN
	IF (startDate IS NULL && finishDate IS NOT NULL) THEN
		SELECT frame, price, date_of_purchase FROM car
			INNER JOIN car_client_salesman ON car_client_salesman.car_id=car.id_car
		WHERE date_of_purchase <= finishDate
        ORDER BY date_of_purchase;
    ELSEIF (startDate IS NOT NULL && finishDate IS NULL) THEN
		SELECT frame, price, date_of_purchase FROM car
			INNER JOIN car_client_salesman ON car_client_salesman.car_id=car.id_car
		WHERE date_of_purchase >= startDate
		ORDER BY date_of_purchase;
	ELSEIF (startDate IS NOT NULL && finishDate IS NOT NULL) THEN
		SELECT frame, price, date_of_purchase FROM car
			INNER JOIN car_client_salesman ON car_client_salesman.car_id=car.id_car
		WHERE date_of_purchase >= startDate AND date_of_purchase <= finishDate
		ORDER BY date_of_purchase;
	ELSE
		SELECT frame, price, date_of_purchase FROM car
			INNER JOIN car_client_salesman ON car_client_salesman.car_id=car.id_car
		ORDER BY date_of_purchase;
	END IF;
END //
DELIMITER ;

CALL searchPurchases('2022-05-30', '2022-07-16');
CALL searchPurchases(null, '2022-07-16');
CALL searchPurchases('2022-05-30', null);
CALL searchPurchases(null, null);

DELIMITER //
CREATE PROCEDURE searchDepartments(IN name VARCHAR(20), OUT error VARCHAR(50))
BEGIN
    IF (name IS NOT NULL) THEN
		SET error = '';
		CASE (name)
			WHEN 'Administration' THEN
				SELECT type, department.phone_number, manager, city, address 
				FROM department 
					INNER JOIN factory ON factory.id_factory = department.factory_id 
				WHERE department.type=name;
			WHEN 'Assembly' THEN
				SELECT type, department.phone_number, manager, city, address 
				FROM department 
					INNER JOIN factory ON factory.id_factory = department.factory_id 
				WHERE department.type=name;
			WHEN 'Painting' THEN
				SELECT type, department.phone_number, manager, city, address 
				FROM department 
					INNER JOIN factory ON factory.id_factory = department.factory_id 
				WHERE department.type=name;
			ELSE
				SET error = 'Department name does not exist.';
		END CASE;
	ELSE 
		SET error = 'Insert a department name.';
    END IF;
END //
DELIMITER ;

CALL searchDepartments('Administration', @error);
CALL searchDepartments('Assembly', @error);
CALL searchDepartments('Painting', @error);
CALL searchDepartments('Pepito', @error);
CALL searchDepartments(null, @error);
SELECT @error;

DELIMITER //
CREATE PROCEDURE find_client_by_name(IN search_name VARCHAR(10))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE result_count INT DEFAULT 0;
    DECLARE client_id INT;
    DECLARE client_name VARCHAR(10);
    DECLARE cur CURSOR FOR SELECT id_client, name FROM client WHERE name LIKE CONCAT('%', search_name, '%');
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    DROP TABLE IF EXISTS temp_results;
    CREATE TEMPORARY TABLE temp_results (id_client INT, name VARCHAR(10));

    OPEN cur;
    REPEAT
        FETCH cur INTO client_id, client_name;
        IF NOT done THEN
            INSERT INTO temp_results (id_client, name) VALUES (client_id, client_name);
            SET result_count = result_count + 1;
        END IF;
    UNTIL done END REPEAT;
    CLOSE cur;

    IF result_count > 0 THEN
        SELECT * FROM temp_results;
    ELSE
        SELECT 'No results found.';
    END IF;
    DROP TABLE temp_results;
END //
DELIMITER ;

CALL find_client_by_name('Jacinto');
CALL find_client_by_name('Federico');

DELIMITER //
CREATE PROCEDURE add_salesman(IN nameAdd VARCHAR(10), IN surnameAdd VARCHAR(10), IN dniAdd CHAR(9), IN phoneNumberAdd CHAR(9), IN dateOfBirthAdd DATE, 
							  IN addressAdd VARCHAR(50), IN cityAdd VARCHAR(30), IN emailAdd VARCHAR(40), IN contractStartDateAdd DATE)
BEGIN
    INSERT INTO salesman (dni, name, surname, phone_number, date_of_birth, address, city, email, contract_start_date) VALUES (dniAdd, nameAdd, surnameAdd , phoneNumberAdd, dateOfBirthAdd, addressAdd, cityAdd, emailAdd, contractStartDateAdd);
END //
DELIMITER ;

CALL add_salesman ('Pepe', 'Viyuela', '28536785J', 623443309, '1980-05-13', 'C/ Pintor Vancells, 5', 'Terrassa', 'PepeViyuela@gmail.com', '2023-05-01');

DELIMITER //
CREATE PROCEDURE carByDealership(IN id TINYINT(3))
BEGIN
    SELECT frame, price 
    FROM car
		INNER JOIN dealership ON dealership.id_dealership=car.dealership_id
	WHERE id = id_dealership;
END //
DELIMITER ;

CALL carByDealership(3);

DELIMITER //
CREATE PROCEDURE salesmanByContractDate(IN contractDate DATE)
BEGIN
    SELECT name, surname, dni, email 
    FROM salesman
	WHERE contract_start_date >= contractDate;
END //
DELIMITER ;

CALL salesmanByContractDate('1998-01-01');

DELIMITER //
CREATE PROCEDURE add_client(IN nameAdd VARCHAR(10), IN surnameAdd VARCHAR(10), IN dniAdd CHAR(9), IN phoneNumberAdd CHAR(9), IN dateOfBirthAdd DATE, 
							  IN addressAdd VARCHAR(50), IN cityAdd VARCHAR(30), IN emailAdd VARCHAR(40))
BEGIN
    INSERT INTO client (dni, name, surname, phone_number, date_of_birth, address, city, email) VALUES (dniAdd, nameAdd, surnameAdd , phoneNumberAdd, dateOfBirthAdd, addressAdd, cityAdd, emailAdd);
END //
DELIMITER ;

CALL add_client ('Juaneque', 'Tornillo', '34459734G', 699890343, '1995-02-20', 'Av. Abat Marcet, 167', 'Terrassa', 'JuanequeTornillo@gmail.com');

DELIMITER //
CREATE PROCEDURE update_client_phoneNumber(IN phone1 CHAR(9), IN phone2 CHAR(9))
BEGIN
     UPDATE client SET phone_number = phone2 WHERE phone_number = phone1;
END //
DELIMITER ;

CALL update_client_phoneNumber('699890343', '666777888');

DELIMITER //
CREATE PROCEDURE search_department(IN id SMALLINT(5))
BEGIN
    SELECT type, phone_number, manager 
    FROM department 
    WHERE id_department=id;
END //
DELIMITER ;

CALL search_department(1);
	
DELIMITER //
CREATE PROCEDURE add_car(IN frameAdd CHAR(17), IN colorAdd ENUM('black','white','blue','red','yellow'), IN kmAdd MEDIUMINT(6), IN priceAdd DECIMAL(7,2))
BEGIN
    INSERT INTO car (frame, color, km, price) VALUES (frameAdd, colorAdd, kmAdd , priceAdd);
END //
DELIMITER ;

CALL add_car('TMBLJ7NU7J5000128', 'white', 0, 20000.00);