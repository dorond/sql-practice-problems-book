/* Q20 */

Select 
    CategoryName,
    TotalProducts = Count(*) 
From 
    Products
Inner Join 
    Categories
        On Products.CategoryID = Categories.CategoryID
Group By
    CategoryName
Order By 
    Count(*) Desc

/* Q21 */

Select 
    Country, 
    City,
    TotalCustomers = Count(*)

From 
    Customers
Group BY
    Country, 
    City   
Order BY
    TotalCustomers Desc

/* Q22 */

Select 
    ProductId, 
    ProductName, 
    UnitsInStock, 
    ReorderLevel
From 
    Products
Where 
    UnitsInStock <= ReorderLevel
Order BY
    ProductID

/* Q23 */

Select 
    ProductId, 
    ProductName, 
    UnitsInStock, 
    UnitsOnOrder,
    ReorderLevel,
    Discontinued
From 
    Products
Where 
    (UnitsInStock + UnitsOnOrder ) <= ReorderLevel And
    Discontinued = 0
Order BY
    ProductID

/* Q24 */

Select 
    CustomerID,
    CompanyName,
    Region 
From Customers 
Order By 
    Case 
        when Region is null then 1 
        else 0 
    End,
    Region,
    CustomerID

/* Q25 */

select Top 3 
    ShipCountry, 
    AverageFreight = AVG(Freight)
from 
    Orders
Group BY
    ShipCountry
Order BY
    AverageFreight Desc

-- OR --

Select 
    ShipCountry 
    ,AverageFreight = AVG(freight) 
From Orders 
Group By ShipCountry 
Order by AverageFreight DESC 
OFFSET 0 ROWS FETCH FIRST 3 ROWS ONLY

/* Q26 */

select Top 3 
    ShipCountry, 
    AverageFreight = AVG(Freight)
From 
    Orders
WHERE
    year(OrderDate) = 2015
Group BY
    ShipCountry
Order BY
    AverageFreight Desc

-- OR

Select Top 3 
    ShipCountry 
    ,AverageFreight = avg(freight) 
From Orders 
Where 
    OrderDate >= '20150101' and OrderDate < '20160101' 
Group By ShipCountry 
Order By AverageFreight desc

/* Q27 */

Select Top 3
    ShipCountry,
    AverageFreight = avg(freight) 
From Orders 
Where OrderDate between '20150101' and '20151231' 
Group By ShipCountry 
Order By AverageFreight desc

Select * from Orders
Where Cast(OrderDate as Date) = '20151231'

/* 10806 is the order Id with the large freight charge on 31 dec 2015 */

/* Q28 */

select Top 3 
    ShipCountry, 
    AverageFreight = AVG(Freight)
From 
    Orders
Where 
    OrderDate >= DATEADD(MONTH, -12, 
        (
            Select MaxDate = Max(OrderDate) From Orders
        ) 
    )
Group BY
    ShipCountry
Order BY
    AverageFreight Desc

-- OR

Select TOP (3) 
    ShipCountry 
    ,AverageFreight = Avg(freight) 
From Orders Where OrderDate >= Dateadd(yy, -1, 
    (Select max(OrderDate) from Orders)) 
Group by ShipCountry 
Order by AverageFreight desc;

/* Q29 */

Select 
    Employees.EmployeeID, 
    Employees.LastName, 
    Orders.OrderID, 
    Products.ProductName, 
    OrderDetails.Quantity
From Employees 
    join Orders 
        on Orders.EmployeeID = Employees.EmployeeID 
    join OrderDetails 
        on Orders.OrderID = OrderDetails.OrderID 
    join Products 
        on Products.ProductID = OrderDetails.ProductID
Order BY
    Orders.OrderID 
    ,Products.ProductID

/* Q30 */

Select 
    Customers_CustomerID = Customers.CustomerID,
    Orders_CustomerID = Orders.CustomerID
from
    Customers 
        Left Join Orders
            On Customers.CustomerID = Orders.CustomerID
Where 
    Orders.CustomerID is null

-- OR

Select CustomerID 
From Customers 
Where CustomerID not in (select CustomerID from Orders)

-- OR

Select CustomerID 
From Customers Where Not Exists 
( 
    Select CustomerID 
    from Orders 
    where Orders.CustomerID = Customers.CustomerID 
)

/* Q31 */

Select 
    Customers.CustomerID,
    Orders.CustomerID
from
    Customers 
        Left Join 
        (
            Select * From Orders
            Where EmployeeID = 4
        ) Orders
            On Customers.CustomerID = Orders.CustomerID
Where 
    Orders.CustomerID is null

-- Or

Select 
    Customers.CustomerID 
    ,Orders.CustomerID 
From Customers 
    left join Orders 
        on Orders.CustomerID = Customers.CustomerID 
        and Orders.EmployeeID = 4 
Where 
    Orders.CustomerID is null