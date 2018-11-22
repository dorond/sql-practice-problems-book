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
