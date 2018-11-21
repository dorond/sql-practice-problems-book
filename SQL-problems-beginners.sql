/* Q1 */

SELECT * FROM Shippers

/* Q2 */

SELECT CategoryName, Description FROM Categories

/* Q3 */

SELECT FirstName, LastName, HireDate FROM Employees 
WHERE Title = 'Sales Representative'

/* Q4 */

SELECT FirstName, LastName, HireDate FROM Employees 
WHERE Title = 'Sales Representative' AND Country = 'USA'

/* Q5 */

SELECT OrderID, OrderDate FROM Orders
WHERE EmployeeID = 5

/* Q6 */

SELECT SupplierID, ContactName, ContactTitle FROM Suppliers
WHERE ContactTitle != 'Marketing Manager'

/* Q7 */

SELECT ProductID, ProductName FROM Products
WHERE ProductName LIKE '%Queso%'

/* Q8 */

SELECT OrderID, CustomerID, ShipCountry FROM Orders
WHERE ShipCountry = 'France' OR ShipCountry = 'Belgium'

/* Q9 */

SELECT OrderID, CustomerID, ShipCountry FROM Orders
WHERE  ShipCountry IN ('Brazil', 'Mexico', 'Argentina', 'Venezuela')

/* Q10 */

