SELECT car_number, brand, mileage
FROM taxi.car
GROUP BY car_number, brand, mileage
HAVING mileage > 70000;

SELECT concat(firstname, ' ', surname) as client
FROM taxi.client
ORDER BY client;

select firstname, surname, standard_paying,
avg(rating) over(partition by standard_paying) as avg_rating
from taxi.client;

select firstname, surname,
rank() over(partition by firstname order by firstname, surname) as avg_rating
from taxi.client;

select distinct
first_value(mileage) over (order by mileage) as min_mileage
from taxi.car;

select distinct brand,
first_value(mileage) over (partition by brand order by mileage) as min_mileage
from taxi.car;

select distinct client_id, brand,
first_value(cnt) over (partition by client_id) from
(select client_id, brand, count(*) as cnt from
(select taxi.car.car_id, taxi.car.brand, taxi.car.mileage, taxi.order.order_id, taxi.order.client_id
from taxi.order_driver_car
join taxi.car on order_driver_car.car_id = car.car_id
join taxi.order on taxi.order_driver_car.order_id = taxi.order.order_id) as tmp
group by client_id, brand
order by cnt desc) as tmp1