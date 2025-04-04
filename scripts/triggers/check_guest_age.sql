DELIMITER //

CREATE TRIGGER check_guest_age
BEFORE INSERT ON Reserve
FOR EACH ROW
BEGIN
    DECLARE guest_age INT;
    DECLARE guest_birthdate DATE;

    -- Get the age of the guest
    SELECT DateOfBirth INTO guest_birthdate
    FROM Guests
    WHERE GuestID = NEW.GuestID;

    -- Calculate the age
    SET guest_age = TIMESTAMPDIFF(YEAR, guest_birthdate, CURDATE());

    -- Check if the guest is under 18
    IF guest_age < 18 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Guest must be at least 18 years old to make a reservation.';
    END IF;
END //

DELIMITER ;