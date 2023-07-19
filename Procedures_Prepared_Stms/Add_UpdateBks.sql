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

-- Quick Reminder on table outlook before updated


-- Task 1
-- In this first task you need to create a new procedure called AddBooking to add a new table booking record.

-- The procedure should include four input parameters in the form of the following bookings parameters:
    -- booking id, 
    -- customer id, 
    -- booking date,
    -- and table number.

DELIMITER //
CREATE PROCEDURE AddBooking(IN booking_id INT, IN booking_date DATE, IN table_num INT, IN customer_ID INT)
BEGIN
DECLARE returnStmt VARCHAR(150);
IF booking_id NOT IN (SELECT DISTINCT BookingID FROM Bookings)
    THEN 
        INSERT INTO Bookings
        VALUES(booking_id, booking_date, table_num, customer_ID);
    SET returnStmt = 'New booking added';
ELSE
    SET returnStmt = 'Duplicate booking found, insertion attempt aborted';
END IF;
SELECT returnStmt;
END //



-- Task 2
-- For your second task, Little Lemon need you to create a new procedure called UpdateBooking that they can use to update existing bookings in the booking table.

-- The procedure should have two input parameters in the form of booking id and booking date. You must also include an UPDATE statement inside the procedure.

DELIMITER //
CREATE PROCEDURE UpdateBooking(IN booking_id INT, IN booking_date DATE)
BEGIN 
DECLARE returnStmt VARCHAR(150);
IF booking_id IN (SELECT DISTINCT BookingID FROM Bookings)
    THEN 
        UPDATE Bookings SET BookingID = booking_id, BookingDate = booking_date WHERE BookingID = booking_id;
    SET returnStmt = CONCAT('Booking : ', booking_id, ' was updated');
ELSE
    SET returnStmt = CONCAT('No booking value found for provided BookingID : ', booking_id);
END IF; 
SELECT returnStmt;
END //


-- Task 3
-- For the third and final task, Little Lemon need you to create a new procedure called CancelBooking that they can use to cancel or remove a booking.

-- The procedure should have one input parameter in the form of booking id. You must also write a DELETE statement inside the procedure.
DELIMITER //
CREATE PROCEDURE CancelBooking(IN booking_id INT)
BEGIN  
DECLARE returnStmt VARCHAR(150);
IF booking_id IN (SELECT DISTINCT BookingID FROM Bookings)
    THEN 
        DELETE FROM Bookings WHERE BookingID = booking_id;
    SET returnStmt = CONCAT('Booking : ', booking_id, ' was cancelled');
ELSE
    SET returnStmt = CONCAT('Booking : ', booking_id, ' could not be found in the table');
END IF;
SELECT returnStmt;
END //