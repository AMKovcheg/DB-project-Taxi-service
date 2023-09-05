INSERT INTO taxi.client VALUES
(11, 'Мария', 'Афанасьева', 5, '+79123251709', 'card', 1);

INSERT INTO taxi.car VALUES
(11, 'З128ФУ', 'Nissan', 43150);

INSERT INTO taxi.driver VALUES
(11, 'Егор', 'Колесников', 5, '+79005738265', 1);

SELECT concat(firstname, ' ', surname) as client
FROM taxi.client;

SELECT car_number, brand
FROM taxi.car
WHERE mileage <= 50000;

SELECT firstname, surname
FROM taxi.driver
WHERE rating < 4.5;

UPDATE taxi.driver
SET phone_number = '+79007860014'
WHERE surname = 'Данилов';

UPDATE taxi.car
SET mileage = 71500
WHERE car_id = 2;

DELETE FROM taxi.car
WHERE brand = 'Toyota';

DELETE FROM taxi.route
WHERE route_id = 10;