-- Database itself and seeded values:
DROP SCHEMA IF EXISTS hotel_management;
CREATE SCHEMA hotel_management;
USE hotel_management;


CREATE TABLE IF NOT EXISTS Guests
(GuestID INTEGER,
Name CHAR(20),
Surname CHAR(20),
ResOwner BOOL,
LoyaltyProg CHAR(20),
BookingHist INTEGER,
DateOfBirth DATE,
PRIMARY KEY(GuestID));

CREATE TABLE IF NOT EXISTS Rooms 
(RoomID INTEGER,
Vacancy BOOL,
Amenities CHAR(200),
Capacity INTEGER, 
RoomType CHAR(30),
Pricing INTEGER,
PRIMARY KEY(RoomID));

CREATE TABLE IF NOT EXISTS Employees
(WorkingDays CHAR(25),
EmpRank CHAR(40),
EmpRole CHAR(40),
EmpSurname Char(20),
EmpName Char(20),
SSN INTEGER,
PRIMARY KEY(SSN));

CREATE TABLE IF NOT EXISTS Departments
(DepartmentID INTEGER,
DepartName Char(30),
PRIMARY KEY(DepartmentID));

CREATE TABLE IF NOT EXISTS Payments
(TransactionID INTEGER,
Amount REAL,
TransType CHAR(20),
Date DATE,
ResOwner BOOL,
Promotion REAL,
PRIMARY KEY(TransactionID));

CREATE TABLE IF NOT EXISTS Services
(SID INTEGER,
Status CHAR(20),
Timestamp DATETIME,
AvailableDays CHAR(20),
ServType CHAR(40),
PRIMARY KEY(SID));

CREATE TABLE IF NOT EXISTS Parking
(PlateNumber CHAR(20),
PayStatus BOOL,
PSpotNum INTEGER,
DaysParked INTEGER,
PRIMARY KEY(PSpotNum));

CREATE TABLE IF NOT EXISTS Tours
(TID INTEGER,
Tcompany CHAR(40),
Tname CHAR(40),
TourType CHAR(20),
PRIMARY KEY(TID));


CREATE TABLE IF NOT EXISTS Belong
(SSN INTEGER NOT NULL,
DepartmentID INTEGER NOT NULL,
PRIMARY KEY(SSN),
FOREIGN KEY(SSN) REFERENCES Employees(SSN),
FOREIGN KEY(DepartmentID) REFERENCES Departments(DepartmentID));

CREATE TABLE IF NOT EXISTS Work
(SSN INTEGER,
SID INTEGER,
PRIMARY KEY(SID),
FOREIGN KEY(SSN) REFERENCES Employees(SSN),
FOREIGN KEY(SID) REFERENCES Services(SID));

CREATE TABLE IF NOT EXISTS Have
(RoomID INTEGER NOT NULL,
SID INTEGER,
PRIMARY KEY(RoomID,SID),
FOREIGN KEY(SID) REFERENCES Services(SID),
FOREIGN KEY(RoomID) REFERENCES Rooms(RoomID));

CREATE TABLE IF NOT EXISTS Reserve
(Duration INTEGER,
BookingDate DATE,
ResStatus CHAR(40),
RoomID INTEGER,
GuestID INTEGER NOT NULL,
PRIMARY KEY(RoomID,GuestID),
FOREIGN KEY(RoomID) REFERENCES Rooms(RoomID),
FOREIGN KEY(GuestID) REFERENCES Guests(GuestID));

CREATE TABLE IF NOT EXISTS Make
(GuestID INTEGER NOT NULL,
TransactionID INTEGER NOT NULL UNIQUE,
PRIMARY KEY(TransactionID),
FOREIGN KEY(GuestID) REFERENCES Guests(GuestID),
FOREIGN KEY(TransactionID) REFERENCES Payments(TransactionID));

CREATE TABLE IF NOT EXISTS P_Use
(PSpotNum INTEGER,
GuestID INTEGER UNIQUE,
PRIMARY KEY(PSpotNum),
FOREIGN KEY(GuestID) REFERENCES Guests(GuestID),
FOREIGN KEY(PSpotNum) REFERENCES Parking(PSpotNum));

CREATE TABLE IF NOT EXISTS Attend
(GuestID INTEGER,
TID INTEGER,
PRIMARY KEY(GuestID,TID),
FOREIGN KEY(GuestID) REFERENCES Guests(GuestID),
FOREIGN KEY(TID) REFERENCES Tours(TID));

INSERT INTO Guests (GuestID, Name, Surname, DateOfBirth, BookingHist, LoyaltyProg, ResOwner)
VALUES
(1, 'John', 'Smith', '2005-08-12', 1, 'Not Applied', TRUE),
(2, 'Emma', 'Johnson', '1999-03-25', 0, 'Not Applied', FALSE),
(3, 'Michael', 'Williams', '2003-11-17', 1, 'Not Applied', TRUE),
(4, 'Olivia', 'Brown', '2000-07-04', 0, 'Not Applied', FALSE),
(5, 'James', 'Davis', '1995-12-30', 1, 'Not Applied', TRUE),
(6, 'Sophia', 'Miller', '1998-05-14', 2, 'Not Applied', TRUE),
(7, 'William', 'Wilson', '2004-09-08', 1, 'Not Applied', FALSE),
(8, 'Emily', 'Moore', '2006-01-19', 3, 'Applied', TRUE),
(9, 'Benjamin', 'Taylor', '1997-06-22', 7, 'Not Applied', FALSE),
(10, 'Charlotte', 'Anderson', '2001-10-05', 4, 'Applied', TRUE),
(11, 'John', 'Doe', '2018-08-12', 1, 'Not Applied', FALSE),
(12, 'Jane', 'Smith', '1999-03-15', 2, 'Not Applied', FALSE);

INSERT INTO Rooms(RoomID, Amenities, Pricing, RoomType, Capacity, Vacancy)
VALUES
(101, 'WiFi, TV, Mini Fridge, Air Conditioning, Coffee Maker', 120, 'Standard', 2, false),
(102, 'WiFi, TV, Mini Fridge, Air Conditioning, Coffee Maker, Balcony', 140, 'Standard', 2, false),
(201, 'WiFi, TV, Mini Fridge, Air Conditioning, Coffee Maker, Desk, Couch', 180, 'Deluxe', 2, false),
(202, 'WiFi, TV, Mini Fridge, Air Conditioning, Coffee Maker, Desk, Balcony, City View', 200, 'Deluxe', 3, true),
(301, 'WiFi, Smart TV, Mini Bar, Air Conditioning, Coffee Maker, Desk, Couch, Balcony, Ocean View', 300, 'Executive', 2, false),
(302, 'WiFi, Smart TV, Mini Bar, Air Conditioning, Coffee Maker, Desk, Lounge Area, Balcony, Ocean View', 320, 'Executive', 2, false),
(401, 'WiFi, Smart TV, Mini Bar, Air Conditioning, Coffee Maker, Desk, Separate Living Room, Jacuzzi, Mountain View', 450, 'Suite', 4, false),
(402, 'WiFi, Smart TV, Full Bar, Air Conditioning, Coffee Machine, Office Space, Living Room, Kitchen, Jacuzzi, Panoramic View', 550, 'Suite', 4, false),
(501, 'WiFi, Smart TV, Full Bar, Air Conditioning, Espresso Machine, Office Space, Living Room, Kitchen, Jacuzzi, Private Pool, Panoramic View', 800, 'Presidential Suite', 6, false),
(502, 'WiFi, Smart TV, Full Bar, Air Conditioning, Espresso Machine, Office Space, Multiple Living Rooms, Full Kitchen, Multiple Bathrooms, Jacuzzi, Private Pool, 360-Degree View', 1200, 'Penthouse', 8, false),
(601, 'WiFi, TV, Mini Fridge, Air Conditioning, Coffee Maker', 120, 'Standard', 2, true),
(602, 'WiFi, TV, Mini Fridge, Air Conditioning, Coffee Maker, Balcony', 140, 'Standard', 2, true);

INSERT INTO Employees (WorkingDays, EmpRank, EmpRole, EmpSurname, EmpName, SSN) 
VALUES
('Mon,Thu,Fri', 'Employee', 'Receptionist', 'Adler', 'Alice', 1),
('Mon,Tue,Thu,Fri', 'Manager', 'Chef', 'Smith', 'Tom', 2),
('Tue,Wed,Fri,Sun', 'Employee', 'Concierge', 'Wilson', 'Bill', 3),
('Mon,Wed,Fri,Sun', 'Manager', 'Hotel Manager', 'Green', 'Steve', 4),
('Tue,Thu,Sat,Sun', 'Manager', 'Hotel Manager', 'Atkins', 'Gabriel', 5),
('Mon,Tue,Wed,Thu,Fri,Sat', 'Employee', 'Chef', 'Craft', 'Connor', 6),
('Mon,Tue,Wed,Thu,Fri', 'Manager', 'Spa', 'Shepheard', 'Jack', 7),
('Mon,Tue,Wed,Thu,Fri', 'Manager', 'Housekeeping', 'North', 'Sharon', 8),
('MonThu,Sat,Sun', 'Manager', 'Human Resources', 'Watson', 'Rory', 9),
('Mon,Tue,Wed,Thu,Fri', 'Employee', 'Human Resources', 'Stone', 'Robert', 10);

INSERT INTO Departments (DepartmentID, DepartName) 
VALUES
(01, 'Front Desk'),
(02, 'Housekeeping'),
(03, 'Food and Beverage'),
(04, 'Maintenance'),
(05, 'Sales and Marketing'),
(06, 'Human Resources'),
(07, 'Finance and Accounting'),
(08, 'Security'),
(09, 'Event Management'),
(10, 'Spa and Wellness');

INSERT INTO Payments (TransactionID, ResOwner, Date, TransType, Promotion, Amount) VALUES 
(1, 0, '2025-02-28', 'Received', 0, 835),
(2, 1, '2025-02-24', 'Received', 5, 1235), 
(3, 1, '2025-02-25', 'Received', 0, 465),
(4, 0, '2025-02-26', 'Pending', 0, 350),
(5, 1, '2025-02-27', 'Received', 0, 1075),
(6, 0, '2025-02-28', 'Refunded', 0, 235),
(7, 1, '2025-02-24', 'Received', 0, 2345),
(8, 1, '2025-02-25', 'Received', 0, 1349), -- 5% discount applied to 1420
(9, 0, '2025-02-26', 'Pending', 0, 970),
(10, 1, '2025-02-27', 'Received', 5, 5557.5); -- 5% discount applied to 5850


INSERT INTO Services (SID, Status, Timestamp, AvailableDays, ServType) 
VALUES
(201, 'done', '2025-02-15 09:30:00', 'Mon,Wed,Fri', 'Guide Service'),
(202, 'not done', '2025-02-20 14:00:00', 'Tue,Thu,Sat,Sun', 'Transportation'),
(203, 'in progress', '2025-02-18 10:15:00', 'Daily', 'Hotel Transfer'),
(204, 'done', '2025-02-10 08:45:00', 'Weekends', 'Equipment Rental'),
(205, 'not done', '2025-02-25 16:30:00', 'Mon,Tue,Wed', 'Photo Package'),
(206, 'in progress', '2025-02-22 11:00:00', 'Thu,Fri,Sat', 'Meal Service'),
(207, 'done', '2025-02-12 13:20:00', 'Daily', 'Audio Guide'),
(208, 'not done', '2025-02-28 15:45:00', 'Weekdays', 'VIP Access'),
(209, 'in progress', '2025-02-19 12:30:00', 'Sat,Sun', 'Translation Service'),
(210, 'done', '2025-02-14 10:00:00', 'Mon,Wed,Fri,Sun', 'Souvenir Package');


INSERT INTO Parking (PSpotNum, PlateNumber, PayStatus,daysParked) VALUES 
(1, 'ABC-1234', FALSE,3),
(2, 'XJY-9876', FALSE,5),
(3, 'MNP-4567', FALSE,2),
(4, 'ZQX-8523', FALSE,7),
(5, 'RTY-7410', FALSE,1),
(6, 'PLM-3692', FALSE,4),
(7, 'WDC-1598', FALSE,6),
(8, 'GHT-7532', FALSE,2),
(9, 'LKS-8421', TRUE,10),
(10, 'BNC-6204', TRUE,8);


INSERT INTO Tours (TID, Tname, Tcompany, TourType) 
VALUES 
(101, 'NYC Skyline Tour', 'City Explorers', 'Sightseeing'),
(102, 'Manhattan Food Walk', 'Taste of NYC', 'Culinary'),
(103, 'Broadway Behind the Scenes', 'Theater Tours', 'Entertainment'),
(104, 'Central Park Bike Adventure', 'NYC Outdoors', 'Recreational'),
(105, 'Historical Harlem Walking Tour', 'Heritage Walks', 'Historical'),
(106, 'Brooklyn Street Art Tour', 'Urban Artistry', 'Cultural'),
(107, 'NYC Museums Expedition', 'City Explorers', 'Educational'),
(108, 'NYC by Night Photography Tour', 'Capture NYC', 'Photography'),
(109, 'Hudson River Sunset Cruise', 'City Sailors', 'Leisure'),
(110, 'New York Architectural Marvels', 'Urban Designs', 'Architectural');


-- Sample Values for Relationship Tables:
INSERT INTO Belong(SSN, DepartmentID)
VALUES
(1, 01),
(2, 02),
(3, 03),
(4, 04),
(10, 10),
(5, 05),
(6, 06),
(7, 07),
(8, 08),
(9, 09);

INSERT INTO Work(SSN, SID)
VALUES
(1, 208),
(2, 206),
(3, 203),
(4, 210),
(5, 204),
(6, 202),
(7, 205),
(8, 207),
(9, 209),
(10, 201);

INSERT INTO Have(RoomID, SID)
VALUES
(101, 201),
(102, 202),
(201, 203),
(202, 204),
(301, 205),
(302, 206),
(401, 207),
(402, 208),
(501, 209),
(502, 210);

INSERT INTO Reserve(GuestID, RoomID, BookingDate, Duration, ResStatus)
VALUES
(1, 501, '2025-04-05', 1, 'Confirmed'),
(2, 502, '2025-04-10', 1, 'Confirmed'),
(3, 101, '2025-03-01', 3, 'Confirmed'),
(4, 102, '2025-03-05', 2, 'Pending'),
(5, 201, '2025-03-10', 5, 'Confirmed'),
(6, 202, '2025-03-15', 1, 'Cancelled'),
(7, 301, '2025-03-20', 7, 'Confirmed'),
(8, 302, '2025-04-01', 4, 'Confirmed'),
(9, 401, '2025-04-05', 2, 'Waiting List'),
(10, 402, '2025-04-10', 10, 'Confirmed');

INSERT INTO Make(GuestID, TransactionID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO P_Use(PSpotNum, GuestID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO Attend(GuestID, TID)
VALUES
(1, 101),
(2, 102),
(3, 104),
(4, 103),
(5, 110),
(6, 110),
(7, 105),
(8, 101),
(9, 108),
(10, 109);

-- Stored Procedures:
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
    FROM P_Use    -- p_use or _use
    WHERE GuestID = guest_id_param;
    
    -- Initialize parking variables
    SET parking_spot = NULL;
    SET days_parked = 0;
    SET parking_price = 0;
    
    -- Only calculate parking if the guest has a parking spot
    IF has_parking THEN
        SELECT PSpotNum INTO parking_spot
        FROM P_Use    -- p_use or _use
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
	FROM P_Use U, Reserve R -- p_use or _use
	WHERE U.GuestID = R.GuestID AND R.RoomID = NEW.RoomID;
    
	SELECT PayStatus INTO parking_payment FROM Parking WHERE PSpotNum = parking_spot;
    IF parking_payment = FALSE THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Parking payment hasn't been completed, checkout request denied.";
		END IF;
    END IF;
END //

DELIMITER ;



DELIMITER //
CREATE TRIGGER room_vacancy_check 
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








