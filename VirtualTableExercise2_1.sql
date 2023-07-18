USE LittleLemonDB;

-- Task 1
-- In the first task, Little Lemon need you to create a virtual table called OrdersView that focuses on OrderID, Quantity and Cost columns 
-- within the Orders table for all orders with a quantity greater than 2. 
CREATE VIEW OrdersView AS 
SELECT 
	OrderID, OrderQuantity, OrderBillAmount 
FROM Orders
WHERE OrderQuantity > 2;


-- Task 2
-- For your second task, Little Lemon need information from four tables on all customers with orders that cost more than $150. 
-- Extract the required information from each of the following tables by using the relevant JOIN clause: 
SELECT 
FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID = O.OrderingCustomerID
INNER JOIN Menu AS M 
ON O.OrderMenuID = M.MenuID
INNER JOIN MenuItems AS MI
ON