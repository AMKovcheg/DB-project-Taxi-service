CREATE OR REPLACE VIEW taxi.client_view AS
SELECT
REPLACE(firstname, substring(firstname, 2, length(firstname) - 2), repeat('*', 3)) as hidden_firstname,
REPLACE(surname, substring(surname, 2, length(surname) - 2), repeat('*', 3)) as hidden_surname,
rating
FROM taxi.client;

CREATE OR REPLACE VIEW taxi.driver_view AS
SELECT
REPLACE(firstname, substring(firstname, 2, length(firstname) - 2), repeat('*', 3)) as hidden_firstname,
REPLACE(surname, substring(surname, 2, length(surname) - 2), repeat('*', 3)) as hidden_surname,
rating
FROM taxi.driver;

CREATE OR REPLACE VIEW taxi.drivers_clients AS
SELECT
taxi.driver.firstname as driver_firstname, taxi.driver.surname as driver_surname,
taxi.client.firstname as client_firstname, taxi.client.surname as client_surname
FROM
(SELECT taxi.order_driver_car.order_id, taxi.order_driver_car.driver_id, taxi.order.client_id
FROM taxi.order_driver_car
JOIN taxi.order ON taxi.order.order_id = taxi.order_driver_car.order_id) as ids
JOIN taxi.driver ON ids.driver_id = taxi.driver.driver_id
JOIN taxi.client ON ids.client_id = taxi.client.client_id;

CREATE OR REPLACE VIEW taxi.drivers_cars AS
SELECT
taxi.driver.firstname as driver_firstname, taxi.driver.surname as driver_surname,
taxi.car.car_number as car_number, taxi.car.brand as brand
FROM
(SELECT taxi.order_driver_car.order_id, taxi.order_driver_car.driver_id, taxi.order_driver_car.car_id
FROM taxi.order_driver_car) as ids
JOIN taxi.driver ON ids.driver_id = taxi.driver.driver_id
JOIN taxi.car ON ids.car_id = taxi.car.car_id;

CREATE OR REPLACE VIEW taxi.clients_cars AS
SELECT
taxi.client.firstname as client_firstname, taxi.client.surname as client_surname,
taxi.car.car_number as car_number, taxi.car.brand as brand
FROM
(SELECT taxi.order_driver_car.order_id, taxi.order.client_id, taxi.order_driver_car.car_id
FROM taxi.order_driver_car
JOIN taxi.order ON taxi.order.order_id = taxi.order_driver_car.order_id) as ids
JOIN taxi.client ON ids.client_id = taxi.client.client_id
JOIN taxi.car ON ids.car_id = taxi.car.car_id;

CREATE OR REPLACE VIEW taxi.clients_stops AS
SELECT
taxi.client.firstname as client_firstname, taxi.client.surname as client_surname,
taxi.stop.addr as addr, taxi.stop.cost_inc as cost
FROM
(SELECT distinct taxi.order_driver_car.order_id, taxi.order.client_id
FROM taxi.order_driver_car
JOIN taxi.order ON taxi.order.order_id = taxi.order_driver_car.order_id) as ids
JOIN taxi.client ON ids.client_id = taxi.client.client_id
JOIN taxi.stop ON ids.order_id = taxi.stop.order_id;