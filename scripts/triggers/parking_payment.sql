-- Unsure about its necessity: USE hotel_reservation_db;

-- Trigger(Parking Payment)
DELIMITER //
CREATE TRIGGER check_parking_payment 
BEFORE UPDATE ON Rooms
FOR EACH ROW
BEGIN
DECLARE parking_spot INT;
DECLARE parking_payment BOOL;
-- Do only if the vacancy is changed and other aspects are the same.
IF OLD.Vacancy <> NEW.Vacancy AND NEW.Vacancy = TRUE
AND OLD.RoomID = NEW.RoomID
AND OLD.Amenities = NEW.Amenities
AND OLD.Capacity = NEW.Capacity
AND OLD.RoomType = NEW.RoomType
AND OLD.Pricing = NEW.Pricing THEN
	
    SELECT U.PSpotNum INTO parking_spot
	FROM _Use U, Reserve R
	WHERE U.GuestID = R.GuestID AND R.RoomID = NEW.RoomID;
    
	SELECT PayStatus INTO parking_payment FROM Parking WHERE PSpotNum = parking_spot;
    IF parking_payment = FALSE THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Parking payment hasn't been completed, checkout request denied.";
		END IF;
    END IF;
END //

DELIMITER ;
