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
    UnitsInStock < ReorderLevel
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
    (UnitsInStock + UnitsOnOrder ) < ReorderLevel And
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

