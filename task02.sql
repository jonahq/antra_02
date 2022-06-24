--1
USE AdventureWorks2019
GO
SELECT c.Name AS Country, s.Name AS Province
FROM person.CountryRegion c, person.StateProvince s
WHERE c.CountryRegionCode = s.CountryRegionCode
--2
SELECT c.Name AS Country, s.Name AS Province
FROM person.CountryRegion c JOIN person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode 
WHERE c.Name IN ('Canada', 'Germany') 
--3
USE Northwind
GO
declare @date datetime
SELECT @date = GETDATE()
SELECT DISTINCT p.ProductName
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID
WHERE DATEDIFF(year, o.OrderDate, @date) <= 25
--4
declare @date datetime
SELECT @date = GETDATE()
SELECT TOP 5 o.ShipPostalCode
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID
WHERE DATEDIFF(year, o.OrderDate, @date) <= 25
GROUP BY o.ShipPostalCode
ORDER BY COUNT(o.ShipPostalCode) DESC

--5
SELECT c.City, COUNT(c.City) AS count
FROM Customers c
GROUP BY c.City

--6
SELECT c.City, COUNT(c.City) AS count
FROM Customers c
GROUP BY c.City
HAVING COUNT(c.City) > 2

--7
SELECT c.ContactName, COUNT(o.CustomerID) AS count
FROM Orders o JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY o.CustomerID, c.ContactName

--8
SELECT c.ContactName, COUNT(o.CustomerID) AS count
FROM Orders o JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY o.CustomerID, c.ContactName
HAVING COUNT(c.CustomerID) > 100

--9
SELECT su.CompanyName AS [Supplier Company Name], sh.CompanyName AS [Shipping Company Name] 
FROM Suppliers su CROSS JOIN Shippers sh

--10
SELECT o.OrderDate, p.ProductName
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY o.OrderDate, p.ProductName

--11
SELECT DISTINCT e1.FirstName + ' ' + e1.LastName, e2.FirstName + ' ' + e2.LastName
FROM Employees e1 JOIN Employees e2 ON e1.Title = e2.Title AND e1.EmployeeID != e2.EmployeeID

--12
SELECT e1.EmployeeID FROM Employees e1 JOIN Employees e2 ON e1.EmployeeID = e2.ReportsTo
GROUP BY e1.EmployeeID HAVING COUNT(e1.EmployeeID) > 2 

--13
SELECT c.City AS [City Name], c.ContactName AS [Contact Name], 'Customer' AS Type FROM Customers c
UNION
SELECT s.City AS [City Name], s.ContactName AS [Contact Name], 'Supplier' AS Type FROM Suppliers s


--14
SELECT DISTINCT c.City FROM Customers c JOIN Suppliers s ON c.City = s.City 

--15 a
SELECT DISTINCT c.City FROM Customers c WHERE c.City NOT IN (SELECT s.City FROM Suppliers s) 

--15 b
SELECT DISTINCT c.City FROM Customers c LEFT JOIN Suppliers s ON c.City = s.City WHERE s.City IS NULL  

--16
SELECT p.ProductID, SUM(od.Quantity)
FROM [Order Details] od JOIN Products p ON od.ProductID = p.ProductID 
GROUP BY p.ProductID

--17 a
SELECT DISTINCT c.City FROM
(SELECT c1.ContactName, c1.City FROM Customers c1
UNION SELECT c2.ContactName, c2.City FROM Customers c2) c

--17 b
SELECT DISTINCT c1.City FROM Customers c1 JOIN Customers c2 ON c1.ContactName != c2.ContactName

--18
SELECT DISTINCT c.City
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.City, p.ProductID
HAVING COUNT(p.ProductID) > 1

--19
SELECT p.ProductName, AVG(p.UnitPrice) FROM Products p 
GROUP BY p.ProductName, p.UnitPrice ORDER BY COUNT(p.ProductName)

--20
SELECT s1.City FROM (SELECT TOP 1 e.City FROM Employees e JOIN Orders o ON e.EmployeeID = o.EmployeeID GROUP BY e.City ORDER BY COUNT(e.City))s1 JOIN
(SELECT TOP 1 c.City FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID GROUP BY c.City ORDER BY COUNT(c.City))s2 ON
s1.City = s2.City

--21
--select distinct 









