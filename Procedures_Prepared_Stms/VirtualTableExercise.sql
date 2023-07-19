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
	C.CustomerID, C.CustomerName, O.OrderID, O.OrderBillAmount,
    M.MenuName, MI.Course, MI.Starter
FROM Customers AS C
INNER JOIN Orders AS O
	ON C.CustomerID = O.OrderingCustomerID
INNER JOIN Menu AS M 
	ON O.OrderMenuID = M.MenuID
INNER JOIN MenuItems AS MI
	ON M.MenuID = MI.BaseMenuID
WHERE O.OrderBillAmount > 150
ORDER BY O.OrderBillAmount;


-- Task 3
-- For the third and final task, Little Lemon need you to find all menu items for which more than 2 orders have been placed. 
-- You can carry out this task by creating a subquery that lists the menu names from the menus table for any order quantity with more than 2.
SELECT MenuName FROM Menu WHERE MenuID = ANY(SELECT OrderMenuID FROM Orders WHERE OrderQuantity > 2)