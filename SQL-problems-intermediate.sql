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