CREATE OR REPLACE FUNCTION get_brand(car_number_ VARCHAR(10))
RETURNS VARCHAR(50) AS $$
<<outerblock>>
DECLARE
    brand_ VARCHAR(50) := '';
BEGIN
    SELECT taxi.car.brand INTO brand_
    FROM taxi.car
    WHERE taxi.car.car_number = car_number_;

    RETURN brand_;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION count_client_orders(client_id_ INTEGER)
RETURNS INTEGER AS $$
<<outerblock>>
DECLARE
    count_ INTEGER := 0;
BEGIN
    SELECT count INTO count_
    FROM
    (select distinct client_id,
    count(*) over(partition by client_id)
    from taxi.order) as tmp
    WHERE client_id = client_id_;

    RETURN count_;
END;
$$ LANGUAGE plpgsql;