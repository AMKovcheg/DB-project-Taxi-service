CREATE OR REPLACE FUNCTION taxi.write_clients_history_on_delete()
RETURNS TRIGGER
AS $$
BEGIN
    INSERT INTO taxi.clients_history VALUES (
        OLD.client_id,
        OLD.firstname,
        OLD.surname,
        OLD.rating,
        OLD.phone_number,
        OLD.standard_paying,
        NOW()
    );
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER client_update_on_delete
AFTER DELETE ON taxi.client
FOR EACH ROW EXECUTE FUNCTION taxi.write_clients_history_on_delete();

---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION taxi.write_clients_history_on_insert_or_update()
RETURNS TRIGGER
AS $$
BEGIN
    INSERT INTO taxi.clients_history VALUES (
        NEW.client_id,
        NEW.firstname,
        NEW.surname,
        NEW.rating,
        NEW.phone_number,
        NEW.standard_paying,
        NOW()
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER client_update_on_insert_or_update
AFTER INSERT OR UPDATE ON taxi.client
FOR EACH ROW EXECUTE FUNCTION taxi.write_clients_history_on_insert_or_update();

-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION taxi.write_cars_history_on_delete()
RETURNS TRIGGER
AS $$
BEGIN
    INSERT INTO taxi.cars_history VALUES (
        OLD.car_id,
        OLD.mileage,
        NOW()
    );
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER car_update_on_delete
AFTER DELETE ON taxi.car
FOR EACH ROW EXECUTE FUNCTION taxi.write_cars_history_on_delete();

------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION taxi.write_cars_history_on_insert_or_update()
RETURNS TRIGGER
AS $$
BEGIN
    INSERT INTO taxi.cars_history VALUES (
        NEW.car_id,
        NEW.mileage,
        NOW()
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER car_update_on_insert_or_update
AFTER INSERT OR UPDATE ON taxi.car
FOR EACH ROW EXECUTE FUNCTION taxi.write_cars_history_on_insert_or_update();

------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION taxi.write_drivers_history_on_delete()
RETURNS TRIGGER
AS $$
BEGIN
    INSERT INTO taxi.drivers_history VALUES (
        OLD.driver_id,
        OLD.firstname,
        OLD.surname,
        OLD.rating,
        OLD.phone_number,
        NOW()
    );
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER driver_update_on_delete
AFTER DELETE ON taxi.driver
FOR EACH ROW EXECUTE FUNCTION taxi.write_drivers_history_on_delete();

------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION taxi.write_drivers_history_on_insert_or_update()
RETURNS TRIGGER
AS $$
BEGIN
    INSERT INTO taxi.drivers_history VALUES (
        NEW.driver_id,
        NEW.firstname,
        NEW.surname,
        NEW.rating,
        NEW.phone_number,
        NOW()
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER driver_update_on_insert_or_update
AFTER INSERT OR UPDATE ON taxi.driver
FOR EACH ROW EXECUTE FUNCTION taxi.write_drivers_history_on_insert_or_update();

------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION taxi.update_client_rating_and_amount_rating()
RETURNS TRIGGER
AS $$
BEGIN
    UPDATE taxi.client
    SET rating = (rating * rating_amount + NEW.mark) / (rating_amount + 1),
        rating_amount = rating_amount + 1
    WHERE client_id = NEW.client_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER client_rating_update
AFTER INSERT ON taxi.driver_review
FOR EACH ROW EXECUTE FUNCTION taxi.update_client_rating_and_amount_rating();

-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION taxi.update_driver_rating_and_amount_rating()
RETURNS TRIGGER
AS $$
BEGIN
    UPDATE taxi.driver
    SET rating = (rating * rating_amount + NEW.mark) / (rating_amount + 1),
        rating_amount = rating_amount + 1
    WHERE driver_id = NEW.driver_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER driver_rating_update
AFTER INSERT ON taxi.client_review
FOR EACH ROW EXECUTE FUNCTION taxi.update_driver_rating_and_amount_rating();
