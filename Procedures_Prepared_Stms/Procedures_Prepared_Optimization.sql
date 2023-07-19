-- Task 1
-- In this first task, Little Lemon need you to create a procedure that displays the maximum ordered quantity in the Orders table. 
-- Creating this procedure will allow Little Lemon to reuse the logic implemented in the procedure easily without retyping the same code over again and again to check the maximum quantity. 

DELIMITER //
CREATE Procedure GetMaxQuantity()
BEGIN
    SELECT 
		MAX(OrderQuantity) as MaxQuantityInOrder
	FROM Orders;
END//
DELIMITER ;

-- Procedure Call
CALL GetMaxQuantity();

-- Task 2
-- In the second task, Little Lemon need you to help them to create a prepared statement called GetOrderDetail. This prepared statement will help to reduce the parsing time of queries. 
-- It will also help to secure the database from SQL injections.

-- The prepared statement should accept one input argument, the `CustomerID` value, from a variable. 

-- The statement should return the order id, the quantity and the order cost from the Orders table. 

-- Once you create the prepared statement, you can create a variable called id and assign it value of 1. 

-- Then execute the GetOrderDetail prepared statement 

PREPARE GetOrderDetail FROM 'SELECT OrderID, OrderQuantity, OrderBillAmount FROM Orders WHERE OrderingCustomerID = ?';
SET @id = 1;
EXECUTE GetOrderDetail USING @id;


-- Task 3
-- Your third and final task is to create a stored procedure called CancelOrder. Little Lemon want to use this stored procedure to delete an order record based on the user input of the order id.

-- Creating this procedure will allow Little Lemon to cancel any order by specifying the order id value in the procedure parameter without typing the entire SQL delete statement.  
DELIMITER //
CREATE Procedure CancelOrder(IN orderID INT)
BEGIN
    DECLARE Confirmation VARCHAR(100);
    DELETE FROM Orders WHERE OrderID = orderID;
    SELECT CONCAT('Order ', orderID, ' is cancelled') INTO Confirmation;
    SELECT Confirmation;
END//
DELIMITER ;

-- Procedure Call
CALL CancelOrder(1);