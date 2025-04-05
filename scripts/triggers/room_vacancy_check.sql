
DELIMITER //

CREATE TRIGGER check_room_vacancy 
BEFORE INSERT ON Reserve 
FOR EACH ROW 
BEGIN 
    DECLARE room_is_vacant BOOLEAN;
    DECLARE existing_reservation VARCHAR(40);
    
    -- Check if the room is vacant in the Rooms table
    SELECT Vacancy INTO room_is_vacant 
    FROM Rooms 
    WHERE RoomID = NEW.RoomID;
    
    -- Check if there's already an active reservation for this room
    SELECT ResStatus INTO existing_reservation
    FROM Reserve
    WHERE RoomID = NEW.RoomID
    AND ResStatus IN ('Confirmed', 'Pending', 'Waiting List')
    LIMIT 1;
    
    -- If room is not vacant raise the 45000
    IF room_is_vacant = FALSE OR existing_reservation IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot reserve room: Room is already occupied or reserved';
    END IF;
    
    -- If new reservation is not set to 'Cancelled', update room vacancy to false
    IF NEW.ResStatus IN ('Confirmed', 'Pending', 'Waiting List') THEN
        UPDATE Rooms SET Vacancy = FALSE WHERE RoomID = NEW.RoomID;
    END IF;
END //

DELIMITER ;
