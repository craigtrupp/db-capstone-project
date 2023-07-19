-- Task 1
-- Little Lemon wants to populate the Bookings table of their database with some records of data. Your first task is to replicate the list of records in the following table by adding them to the Little Lemon booking table. 

-- You can use simple INSERT statements to complete this task.

-- Could simply not declare columns as all values appear to be seen in the Screenshot for the Exercise ... but Nevertheless
INSERT INTO Bookings (BookingID, BookingDate, TableNumber, CustomerID) 
VALUES 
(1, '2022-10-10', 5, 1),
(2, '2022-11-12', 3, 3),
(3, '2022-10-11', 2, 2),
(4, '2022-10-13', 2, 1);


-- Task 2
-- For your second task, Little Lemon need you to create a stored procedure called CheckBooking to check whether a table in the restaurant is already booked. 
-- Creating this procedure helps to minimize the effort involved in repeatedly coding the same SQL statements.

-- The procedure should have two input parameters in the form of booking date and table number. You can also create a variable in the procedure to check the status of each table.


DELIMITER //
CREATE PROCEDURE CheckBooking(IN table_no INT, IN booking_date DATE)
BEGIN
DECLARE BookingStatus VARCHAR(150);
DECLARE FoundBooking INT;
    SELECT COUNT(*) INTO FoundBooking FROM Bookings_Deux WHERE TableNumber = table_no AND BookingDate = booking_date;
    IF FoundBooking >= 1 THEN SET BookingStatus = CONCAT('Table ', table_no, ' is already booked for ', booking_date);
    ELSE SET BookingStatus = CONCAT('Table ', table_no, ' is available for booking on ', booking_date, '!');
    END IF;
    SELECT BookingStatus;
END//


-- mysql> CALL CheckBooking(3, '2022-11-12');
-- +------------------------------------------+
-- | BookingStatus                            |
-- +------------------------------------------+
-- | Table 3 is already booked for 2022-11-12 |
-- +------------------------------------------+
-- 1 row in set (0.01 sec)

-- mysql> CALL CheckBooking(3, '2022-11-13');
-- +-------------------------------------------------+
-- | BookingStatus                                   |
-- +-------------------------------------------------+
-- | Table 3 is available for booking on 2022-11-13! |
-- +-------------------------------------------------+
-- 1 row in set (0.05 sec)

-- Query OK, 0 rows affected (0.05 sec)