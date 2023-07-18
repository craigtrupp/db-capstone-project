-- Select Created Schema

USE LittleLemonDB;


-- Task 1 : Create OrdersView (OrderID, Quantity, Cost) 
-- Orders where quantity greater than 2 (Generic)
CREATE VIEW OrdersView AS
SELECT OrderID, OrderQuantity, TotalCost
FROM Orders
WHERE OrderQuantity > 2;

-- My View for Schema (Each individual Order has a bookingID so unique menu items would be caught, just a group by and count needed
CREATE VIEW OrdersView_Secondary AS
SELECT
	OrderID,
    SUM(OrderQuantity) AS BookingOrderItemCount,
    SUM(TotalCost) AS BookingTotalBill
FROM Orders
GROUP BY OrderID
HAVING SUM(OrderQuantity) > 2
ORDER BY OrderID;


-- Task 2 : For your second task, Little Lemon need information from four tables on all customers with orders that cost more than $150. 
-- Extract the required information from each of the following tables by using the relevant JOIN clause: 

-- Generic (For Task 2 with Defined Schema They Detailed .. aka the Tables they already declared)
CREATE VIEW OrdersViewGreater150 AS 
SELECT
	c.CustomerID, c.CustomerName,
    o.OrderID, o.TotalCost,
    m.MenuName,
    mi.CourseName, mi.StarterName
FROM Customers AS c
INNER JOIN Orders AS o
	ON c.CustomerID = o.OrderCustomerID
INNER JOIN Menu AS m
	ON o.OrderMenuID = m.MenuID
INNER JOIN MenuItems AS mi
	ON m.MenuID = mi.MenuID
WHERE o.TotalCost > 150;
    
    
-- Now with My Schema
CREATE VIEW OrdersViewGreater150_Secondary AS
WITH customerOrdersGreater150 AS ( 
SELECT
	c.CustomerID, c.CustomerName, o.OrderBookingID, SUM(o.TotalCost) AS OrderTotalCost
FROM Customers AS c
INNER JOIN Orders AS o
	ON c.CustomerID = o.OrderCustomerID
INNER JOIN Menu AS m
	ON o.OrderMenuItemID = m.MenuItemID
GROUP BY c.CustomerID, c.CustomerName, o.OrderBookingID
HAVING SUM(o.TotalCost) > 150
) 
SELECT 
-- First get all fields rom the return and then we just need to self join Orders for the ORderMenuItemID which will use for the Menu Lookup 
	*,
-- Now get the menu items details like courser and starter (mine is detailed as item and category)
    m.MenuItemName, m.MenuItemCategory
FROM customerOrdersGreater150 AS co_150
-- Inner join to 
INNER JOIN Orders AS o
	ON co_150.OrderBookingID = o.OrderBookingID
INNER JOIN Menu AS m
	ON o.OrderMenuItemID = m.MenuItemID;




-- 3 For the third and final task, Little Lemon need you to find all menu items for which more than 2 orders have been placed. 
-- You can carry out this task by creating a subquery that lists the menu names from the menus table for any order quantity with more than 2.

-- Generic Schema 
SELECT Name FROM Menu WHERE MenuID = ANY(SELECT MenuID FROM orders WHERE Quantity>2); 

-- My Schema - Each Row in an order has a master orderBookingID in which item order by a table is aggregated on that value
SELECT MenuItemName FROM Menu WHERE MenuItemID = ANY(
	SELECT OrderMenuItemID
    FROM Orders
    WHERE OrderQuantity > (
		SELECT COUNT(*) AS orderMenuItemBookings 
        FROM Orders
        GROUP BY OrderBookingID, OrderMenuItemID
        HAVING COUNT(*) > 2
        )
    );
