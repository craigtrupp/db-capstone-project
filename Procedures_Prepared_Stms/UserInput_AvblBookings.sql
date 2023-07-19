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
    SELECT COUNT(*) INTO FoundBooking FROM Bookings WHERE TableNumber = table_no AND BookingDate = booking_date;
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




-- Task 3
-- For your third and final task, Little Lemon need to verify a booking, and decline any reservations for tables that are already booked under another name. 

-- Since integrity is not optional, Little Lemon need to ensure that every booking attempt includes these verification and decline steps. 
-- However, implementing these steps requires a stored procedure and a transaction. 

-- To implement these steps, you need to create a new procedure called AddValidBooking. 
-- This procedure must use a transaction statement to perform a rollback if a customer reserves a table that’s already booked under another name.  

-- Use the following guidelines to complete this task:

-- The procedure should include two input parameters in the form of booking date and table number. (well this kinda unrealistic ... we need a CustomerID too)

-- It also requires at least one variable and should begin with a START TRANSACTION statement.

-- Your INSERT statement must add a new booking record using the input parameter's values.

-- Use an IF ELSE statement to check if a table is already booked on the given date. 

-- If the table is already booked, then rollback the transaction. If the table is available, then commit the transaction. 

-- Reminder of How our Bookings Table Looks

-- | BookingID | BookingDate | TableNumber | CustomerID |
-- +-----------+-------------+-------------+------------+
-- |         1 | 2022-10-10  |           5 |          1 |
-- |         2 | 2022-11-12  |           3 |          3 |
-- |         3 | 2022-10-11  |           2 |          2 |
-- |         4 | 2022-10-13  |           2 |          1 |


-- Now just for clarity, I'm adding a customer_ID value as well for an argument to fill the booking and will use a select statement to generate a BookingID one greater than the MAX
DELIMITER //
CREATE PROCEDURE AddValidBooking(IN booking_date DATE, IN table_num INT, IN customer_ID INT)
BEGIN
DECLARE bookingID INT;
DECLARE bookingCheck INT; 
DECLARE bookingStatus VARCHAR(150);
    START TRANSACTION;
    SELECT MAX(BookingID) + 1 INTO bookingID FROM Bookings;
    INSERT INTO Bookings VALUES (bookingID, booking_date, table_num, customer_ID);
    SELECT COUNT(*) INTO bookingCheck FROM Bookings WHERE booking_date = BookingDate AND TableNumber = table_num;
IF bookingCheck >= 2 THEN 
    SET bookingStatus = CONCAT('Table ', table_num, ' is already booked for : ', booking_date, ', the attempted booking was cancelled');
    ROLLBACK;
ELSE 
    SET bookingStatus = CONCAT('Table ', table_num, ' was successfully booked for : ', booking_date, ' for customer : ', customer_ID);
END IF;
SELECT bookingStatus;
COMMIT;
END //



-- Try a booking that should be rolled back
CALL AddValidBooking('2022-11-12', 3, 2);

-- +---------------------------------------------------------------------------------+
-- | bookingStatus                                                                   |
-- +---------------------------------------------------------------------------------+
-- | Table 3 is already booked for : 2022-11-12, the attempted booking was cancelled |
-- +---------------------------------------------------------------------------------+

-- Add a booking with no conflicts (will us the same date to make sure our bookingCheck variable is behaivng as expected)

CALL AddValidBooking('2022-11-12', 5, 2);
-- +-------------------------------------------------------------------+
-- | bookingStatus                                                     |
-- +-------------------------------------------------------------------+
-- | Table 5 was successfully booked for : 2022-11-12 for customer : 2 |
-- +-------------------------------------------------------------------+
-- 1 row in set (0.01 sec)

-- Query OK, 0 rows affected (0.05 sec)


-- Finally let's check to see if the return is how we would expect with the BookingID value we're generating in the procedure incrementing up by 1 more than the max BookingID value
SELECT * FROM Bookings;

-- mysql> SELECT * FROM Bookings_Deux;
-- +-----------+-------------+-------------+------------+
-- | BookingID | BookingDate | TableNumber | CustomerID |
-- +-----------+-------------+-------------+------------+
-- |         1 | 2022-10-10  |           5 |          1 |
-- |         2 | 2022-11-12  |           3 |          3 |
-- |         3 | 2022-10-11  |           2 |          2 |
-- |         4 | 2022-10-13  |           2 |          1 |
-- |         5 | 2022-11-12  |           5 |          2 |
-- +-----------+-------------+-------------+------------+
-- 5 rows in set (0.00 sec)










