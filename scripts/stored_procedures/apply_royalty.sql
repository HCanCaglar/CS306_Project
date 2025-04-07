DELIMITER //

CREATE PROCEDURE calculate_guest_bill(IN guest_id_param INT)
BEGIN
    DECLARE guest_loyalty VARCHAR(20);
    DECLARE room_id_val INT;
    DECLARE duration_val INT;
    DECLARE room_price DECIMAL(10,2);
    DECLARE total_room_price DECIMAL(10,2);
    DECLARE parking_spot INT;
    DECLARE days_parked INT;
    DECLARE parking_price DECIMAL(10,2);
    DECLARE total_bill DECIMAL(10,2);
    DECLARE final_bill DECIMAL(10,2);
    DECLARE discount_rate DECIMAL(5,2);
    DECLARE is_res_owner BOOLEAN;
    DECLARE has_parking BOOLEAN DEFAULT FALSE;
    
    -- Check if the guest is the ResOwner
    SELECT ResOwner INTO is_res_owner
    FROM Guests
    WHERE GuestID = guest_id_param;
    
    -- error if not RewOwner
    IF is_res_owner = FALSE THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Only reservation owners can view bills';
        -- Exit the procedure
    END IF;
    
    -- Get the loyalty program 
    SELECT LoyaltyProg INTO guest_loyalty
    FROM Guests
    WHERE GuestID = guest_id_param;
    
    -- Get the room details and duration
    SELECT r.RoomID, r.Duration INTO room_id_val, duration_val
    FROM Reserve r
    WHERE r.GuestID = guest_id_param;
    
    -- Get room price
    SELECT Pricing INTO room_price
    FROM Rooms
    WHERE RoomID = room_id_val;
    
    -- total room price
    SET total_room_price = room_price * duration_val;
    
    -- Check if guest has a parking spot
    SELECT COUNT(*) > 0 INTO has_parking
    FROM P_Use
    WHERE GuestID = guest_id_param;
    
    -- Initialize parking variables
    SET parking_spot = NULL;
    SET days_parked = 0;
    SET parking_price = 0;
    
    -- Only calculate parking if the guest has a parking spot
    IF has_parking THEN
        SELECT PSpotNum INTO parking_spot
        FROM P_Use
        WHERE GuestID = guest_id_param;
        
        -- total days parked
        SELECT DaysParked INTO days_parked
        FROM Parking
        WHERE PSpotNum = parking_spot;
        
        -- total parking price (20$ per day)
        SET parking_price = days_parked * 20;
    END IF;
    
    -- total bill before loyalty
    SET total_bill = total_room_price + parking_price;
    
    -- Apply loyalty discount if "Applied"
    IF guest_loyalty = 'Applied' THEN
        SET discount_rate = 0.05; -- 5% discount
        SET final_bill = total_bill * (1 - discount_rate);
    ELSE
        SET final_bill = total_bill;
    END IF;
    
    -- Result table
    SELECT 
        guest_id_param AS GuestID,
        guest_loyalty AS LoyaltyStatus,
        room_id_val AS RoomID,
        room_price AS RoomPricePerDay,
        duration_val AS DaysStayed,
        total_room_price AS TotalRoomPrice,
        parking_spot AS ParkingSpotNumber,
        days_parked AS DaysParked,
        parking_price AS TotalParkingPrice,
        total_bill AS TotalBillBeforeDiscount,
        CASE 
            WHEN guest_loyalty = 'Applied' THEN 'Yes (5%)'
            ELSE 'No'
        END AS DiscountApplied,
        final_bill AS FinalBill;
END //

DELIMITER ;
