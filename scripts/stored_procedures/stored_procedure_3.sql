DELIMITER //

CREATE PROCEDURE GetGuestTours(IN guest_name CHAR(20), IN guest_surname CHAR(20))
BEGIN
    SELECT 
        g.Name AS 'Guest Name',
        g.Surname AS 'Guest Surname',
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
        BINARY g.Name = guest_name AND BINARY g.Surname = guest_surname;
END //

DELIMITER ;