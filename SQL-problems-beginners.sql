/* Q1 */

SELECT * FROM Shippers

/* Q2 */

SELECT CategoryName, Description 
FROM Categories

/* Q3 */

SELECT FirstName, LastName, HireDate 
FROM Employees 
WHERE Title = 'Sales Representative'

/* Q4 */

SELECT FirstName, LastName, HireDate 
FROM Employees 
WHERE Title = 'Sales Representative' AND Country = 'USA'

/* Q5 */

SELECT OrderID, OrderDate 
FROM Orders
WHERE EmployeeID = 5

/* Q6 */

SELECT SupplierID, ContactName, ContactTitle 
FROM Suppliers
WHERE ContactTitle != 'Marketing Manager'

/* Q7 */

SELECT ProductID, ProductName 
FROM Products
WHERE ProductName LIKE '%Queso%'

/* Q8 */

SELECT OrderID, CustomerID, ShipCountry 
FROM Orders
WHERE ShipCountry = 'France' OR ShipCountry = 'Belgium'

/* Q9 */

SELECT OrderID, CustomerID, ShipCountry 
FROM Orders
WHERE  ShipCountry IN ('Brazil', 'Mexico', 'Argentina', 'Venezuela')

/* Q10 */

SELECT FirstName, LastName, Title, BirthDate 
FROM Employees
ORDER BY BirthDate

/* Q11 */

SELECT FirstName, LastName, Title, CAST(BirthDate as Date) DateOnlyBirthDate 
FROM Employees
ORDER BY BirthDate

/* Q12 */

SELECT e.FirstName, e.LastName, e.FirstName + ' ' + e.LastName FullName
FROM Employees e

/* Q13 */

SELECT od.OrderID, od.ProductID, od.UnitPrice, od.Quantity, FORMAT(od.UnitPrice * od.Quantity, 'N') TotalPrice
FROM OrderDetails od
ORDER BY od.OrderID, od.ProductID

/* Q14 */

SELECT COUNT(*) TotalCustomers 
FROM Customers

/* Q15 */

SELECT TOP 1 OrderDate FirstOrder
FROM Orders
ORDER BY OrderDate

/* Q16 */

SELECT DISTINCT(c.Country)
FROM Customers c

/* Q17 */

SELECT c.ContactTitle, COUNT(*) TotalContactTitle
FROM Customers c
GROUP BY c.ContactTitle
ORDER BY TotalContactTitle DESC

/* Q18 */

SELECT p.ProductID, p.ProductName, s.CompanyName Supplier
FROM Products p INNER JOIN Suppliers s
ON p.SupplierID = s.SupplierID
ORDER BY p.ProductID

/* Q19 */

SELECT o.OrderID, CAST(o.OrderDate AS Date), s.CompanyName Shipper
FROM Orders o INNER JOIN Shippers s
ON s.ShipperID = o.ShipVia
WHERE o.OrderID < 10270
ORDER BY o.OrderID