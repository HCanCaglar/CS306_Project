-- Unsure about its necessity: USE hotel_reservation_db;


-- Stored Procedure(Royalty Giver)
DELIMITER //
CREATE PROCEDURE RoyaltyGiver(
IN guest_id INT
)
BEGIN
-- Check whether the entered guest name is valid.
DECLARE id_check INT;
DECLARE hist INT;

SELECT COUNT(*) INTO id_check
FROM Guests
WHERE GuestID = guest_id;

-- In case of a wrong id, stop the execution.
IF id_check = 0 THEN
	SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "This id does not exist in the database.";
    END IF;

-- Get the amount of times a customer stayed at the hotel
SELECT BookingHist INTO hist
FROM Guests
WHERE GuestID = guest_id;

IF hist >= 5 THEN
	UPDATE Guests SET LoyaltyProg = "Applied" WHERE GuestID = guest_id;
    SELECT "You are eligible for our royalty program";
ELSE
	SELECT "You aren't eligible for our royalty program";
END IF;
END //
DELIMITER ;
