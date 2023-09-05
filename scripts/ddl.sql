CREATE SCHEMA taxi;

CREATE TABLE taxi.driver (
  driver_id INTEGER PRIMARY KEY,
  firstname VARCHAR(50) NOT NULL,
  surname VARCHAR(50) NOT NULL,
  rating NUMERIC,
  phone_number VARCHAR(20) NOT NULL,
  rating_amount INTEGER NOT NULL
);

CREATE TABLE taxi.car (
  car_id INTEGER PRIMARY KEY,
  car_number VARCHAR(10) NOT NULL,
  brand VARCHAR(50) NOT NULL,
  mileage INTEGER
);

CREATE TABLE taxi.client (
  client_id INTEGER PRIMARY KEY,
  firstname VARCHAR(50) NOT NULL,
  surname VARCHAR(50) NOT NULL,
  rating NUMERIC,
  phone_number VARCHAR(20) NOT NULL,
  standard_paying VARCHAR(10) NOT NULL,
  rating_amount INTEGER NOT NULL
  CHECK (standard_paying = 'card' or standard_paying = 'in cash')
);

CREATE TABLE taxi.client_review (
  review_id INTEGER PRIMARY KEY,
  client_id INTEGER NOT NULL,
  comment TEXT,
  driver_id INTEGER NOT NULL,
  date DATE NOT NULL,
  mark INTEGER,
  FOREIGN KEY (client_id) REFERENCES taxi.client(client_id) ON DELETE CASCADE,
  FOREIGN KEY (driver_id) REFERENCES taxi.driver(driver_id) ON DELETE CASCADE,
  CHECK (mark >= 1 and mark <= 5)
);

CREATE TABLE taxi.order (
  order_id INTEGER PRIMARY KEY,
  client_id INTEGER NOT NULL,
  cost INTEGER NOT NULL,
  taxi_class VARCHAR(20) NOT NULL,
  num_cars INTEGER NOT NULL,
  num_stops INTEGER NOT NULL,
  close_time TIMESTAMP NOT NULL,
  FOREIGN KEY (client_id) REFERENCES taxi.client(client_id) ON DELETE CASCADE
);

CREATE TABLE taxi.order_driver_car (
  odc_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  driver_id INTEGER NOT NULL,
  car_id INTEGER NOT NULL,
  FOREIGN KEY (order_id) REFERENCES taxi.order(order_id),
  FOREIGN KEY (driver_id) REFERENCES taxi.driver(driver_id),
  FOREIGN KEY (car_id) REFERENCES taxi.car(car_id)
);

CREATE TABLE taxi.route (
    route_id INTEGER PRIMARY KEY,
    departure_addr VARCHAR(200) NOT NULL,
    distance NUMERIC NOT NULL,
    order_id INTEGER NOT NULL,
    exp_time INTEGER NOT NULL,
    FOREIGN KEY (order_id) REFERENCES taxi.order(order_id) ON DELETE CASCADE
);

CREATE TABLE taxi.stop (
    stop_id INTEGER PRIMARY KEY,
    cost_inc INTEGER,
    addr VARCHAR(200) NOT NULL,
    order_id INTEGER NOT NULL,
    FOREIGN KEY (order_id) REFERENCES taxi.order(order_id)
);

CREATE TABLE taxi.cars_history (
  car_id INTEGER,
  mileage INTEGER,
  change_time TIMESTAMP
);

CREATE TABLE taxi.clients_history (
  client_id INTEGER,
  firstname VARCHAR(50) NOT NULL,
  surname VARCHAR(50) NOT NULL,
  rating NUMERIC,
  phone_number VARCHAR(20) NOT NULL,
  standard_paying VARCHAR(10) NOT NULL,
  change_time TIMESTAMP
);

CREATE TABLE taxi.drivers_history (
  driver_id INTEGER,
  firstname VARCHAR(50) NOT NULL,
  surname VARCHAR(50) NOT NULL,
  rating NUMERIC,
  phone_number VARCHAR(20) NOT NULL,
  change_time TIMESTAMP
);

CREATE TABLE taxi.driver_review (
  review_id INTEGER PRIMARY KEY,
  driver_id INTEGER NOT NULL,
  comment TEXT,
  client_id INTEGER NOT NULL,
  date DATE NOT NULL,
  mark INTEGER,
  FOREIGN KEY (client_id) REFERENCES taxi.client(client_id) ON DELETE CASCADE,
  FOREIGN KEY (driver_id) REFERENCES taxi.driver(driver_id) ON DELETE CASCADE,
  CHECK (mark >= 1 and mark <= 5)
);