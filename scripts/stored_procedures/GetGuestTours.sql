DELIMITER //

CREATE PROCEDURE GetGuestTours(IN guest_name CHAR(20), IN guest_surname CHAR(20))
BEGIN
    SELECT 
        t.Tname AS 'Tour Name', 
        t.TourType AS 'Tour Type', 
        t.Tcompany AS 'Tour Company'
    FROM 
        Guests g
    JOIN 
        Attend a ON g.GuestID = a.GuestID
    JOIN 
        Tours t ON a.TID = t.TID
    WHERE 
        g.Name = guest_name AND g.Surname = guest_surname;
END //

DELIMITER ;