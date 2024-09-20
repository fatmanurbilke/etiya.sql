SELECT Customers.CustomerID, Orders.OrderID, Orders.OrderDate
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID

SELECT Suppliers.SupplierID, Products.ProductName
FROM Suppliers
LEFT JOIN Products
ON Suppliers.SupplierID = Products.SupplierID

SELECT Orders.OrderID, Orders.OrderDate, Employees.FirstName, Employees.LastName
FROM Orders
LEFT JOIN Employees
ON Orders.EmployeeID = Employees.EmployeeID

SELECT Customers.CustomerID, Orders.OrderID, Orders.OrderDate
FROM Customers
FULL OUTER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID

SELECT Products.ProductName, Categories.CategoryName
FROM Products
CROSS JOIN Categories;

SELECT 
    Customers.CustomerID, 
    Orders.OrderID, 
    Orders.OrderDate, 
    Employees.FirstName AS EmployeeFirstName, 
    Employees.LastName AS EmployeeLastName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE YEAR(Orders.OrderDate) = 1998

SELECT 
    Customers.CustomerID, 
    COUNT(Orders.OrderID) AS TotalOrders
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CustomerID
HAVING COUNT(Orders.OrderID) > 5

SELECT 
    Products.ProductName, 
    SUM('Order Details'.Quantity) AS 'Total Quantity Sold', 
    SUM('Order Details'.Quantity * 'Order Details'.UnitPrice) AS 'Total Sales Amount'
FROM 'Order Details'
JOIN Products ON 'Order Details'.ProductID = Products.ProductID
GROUP BY Products.ProductName

SELECT 
    Customers.CustomerName, 
    Orders.OrderID, 
    Orders.OrderDate
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.CustomerName LIKE 'B%'

SELECT 
    Categories.CategoryName,
    Products.ProductName
FROM Categories
LEFT JOIN Products ON Categories.CategoryID = Products.CategoryID
WHERE Products.ProductName IS NULL

SELECT 
    e1.EmployeeID AS EmployeeID,
    e1.FirstName AS EmployeeFirstName,
    e1.LastName AS EmployeeLastName,
    e2.EmployeeID AS ManagerID,
    e2.FirstName AS ManagerFirstName,
    e2.LastName AS ManagerLastName
FROM Employees e1
LEFT JOIN Employees e2 ON e1.ManagerID = e2.EmployeeID

WITH MaxPricePerCategory AS (
    SELECT 
        CategoryID, 
        MAX(UnitPrice) AS MaxPrice
    FROM Products
    GROUP BY CategoryID
)
SELECT 
    p.CategoryID,
    p.ProductID,
    p.ProductName,
    p.UnitPrice
FROM Products p
JOIN MaxPricePerCategory mpc
ON p.CategoryID = mpc.CategoryID AND p.UnitPrice = mpc.MaxPrice

WITH MaxPricePerCategory AS (
    SELECT 
        CategoryID, 
        MAX(UnitPrice) AS MaxPrice
    FROM Products
    GROUP BY CategoryID
),
MostExpensiveProducts AS (
    SELECT 
        p.CategoryID,
        p.ProductID,
        p.ProductName,
        p.UnitPrice
    FROM Products p
    JOIN MaxPricePerCategory mpc
    ON p.CategoryID = mpc.CategoryID AND p.UnitPrice = mpc.MaxPrice
)
SELECT 
    CategoryID,
    COUNT(DISTINCT UnitPrice) AS PriceCount
FROM MostExpensiveProducts
GROUP BY CategoryID
HAVING COUNT(DISTINCT UnitPrice) > 1

SELECT 
    Orders.OrderID,
    Orders.OrderDate,
    OrderDetails.ProductID,
    OrderDetails.Quantity,
    OrderDetails.UnitPrice
FROM Orders
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
ORDER BY Orders.OrderID ASC

SELECT 
    Employees.EmployeeID,
    Employees.FirstName,
    Employees.LastName,
    COUNT(Orders.OrderID) AS NumberOfOrders
FROM Employees
LEFT JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName

SELECT 
    p1.ProductID,
    p1.ProductName,
    p1.UnitPrice,
    p1.CategoryID
FROM Products p1
LEFT JOIN Products p2 
ON p1.CategoryID = p2.CategoryID 
   AND p1.UnitPrice >= p2.UnitPrice
WHERE p2.ProductID IS NULL

WITH MaxPricePerSupplier AS (
    SELECT 
        SupplierID, 
        MAX(UnitPrice) AS MaxPrice
    FROM Products
    GROUP BY SupplierID
)
SELECT 
    s.CompanyName,
    p.ProductID,
    p.ProductName,
    p.UnitPrice
FROM MaxPricePerSupplier mps
JOIN Products p ON mps.SupplierID = p.SupplierID AND mps.MaxPrice = p.UnitPrice
JOIN Suppliers s ON p.SupplierID = s.SupplierID

WITH LatestOrders AS (
    SELECT 
        EmployeeID,
        MAX(OrderDate) AS LatestOrderDate
    FROM Orders
    GROUP BY EmployeeID
)
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    o.OrderID,
    o.OrderDate
FROM LatestOrders lo
JOIN Orders o ON lo.EmployeeID = o.EmployeeID AND lo.LatestOrderDate = o.OrderDate
JOIN Employees e ON o.EmployeeID = e.EmployeeID

SELECT 
    COUNT(*) AS NumberOfProducts
FROM Products
WHERE UnitPrice > 20

SELECT 
    c.CustomerID,
    o.OrderID,
    o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate BETWEEN '1997-01-01' AND '1998-12-31'

SELECT 
    c.CustomerID,
    c.CustomerName
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL

