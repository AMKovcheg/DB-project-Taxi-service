CREATE INDEX IF NOT EXISTS index_drivers
ON taxi.driver(firstname, surname);

CREATE INDEX IF NOT EXISTS index_clients
ON taxi.client(firstname, surname);

CREATE INDEX IF NOT EXISTS index_cars
ON taxi.car(car_number);

CREATE INDEX IF NOT EXISTS index_order_driver_car
ON taxi.order_driver_car(order_id);

CREATE INDEX IF NOT EXISTS index_client_review
ON taxi.client_review(client_id);

CREATE INDEX IF NOT EXISTS index_driver_review
ON taxi.driver_review(driver_id);