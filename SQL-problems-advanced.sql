-- Q32

-- at least 1 order of $1000 or more, not included discount from 2016

Select 
    Customers.CustomerID,
    Customers.CompanyName,
    Orders.OrderID,
    TotalOrderAmount
FROM
    Customers 
        Join 
            (
                Select * 
                From Orders
                Where year(OrderDate) = 2016  
            ) Orders
            On Orders.CustomerID = Customers.CustomerID
        Join 
            (
                Select 
                    OrderID
                    ,TotalOrderAmount = Sum(UnitPrice * Quantity)
                From 
                    OrderDetails
                Group By
                    OrderID
                Having
                    Sum(UnitPrice * Quantity) >= 10000
            ) OrderDetails 
            On OrderDetails.OrderID = Orders.OrderID

-- OR

Select 
    Customers.CustomerID 
    ,Customers.CompanyName 
    ,Orders.OrderID 
    ,TotalOrderAmount = SUM(Quantity * UnitPrice)
From 
    Customers 
        Join Orders 
            on Orders.CustomerID = Customers.CustomerID 
        Join OrderDetails 
            on Orders.OrderID = OrderDetails.OrderID 
Where 
    OrderDate >= '20160101' 
    and OrderDate < '20170101' 
Group by 
    Customers.CustomerID 
    ,Customers.CompanyName 
    ,Orders.Orderid 
Having Sum(Quantity * UnitPrice) > 10000 
Order by TotalOrderAmount DESC

-- Q33

-- Customers whose total 2016 orders are $15,000 or greater
Select 
    Customers.CustomerID 
    ,Customers.CompanyName 
    ,TotalOrderAmount = SUM(Quantity * UnitPrice)
From 
    Customers 
        Join Orders 
            on Orders.CustomerID = Customers.CustomerID 
        Join OrderDetails 
            on Orders.OrderID = OrderDetails.OrderID 
Where 
    OrderDate >= '20160101' 
    and OrderDate < '20170101' 
Group by 
    Customers.CustomerID 
    ,Customers.CompanyName  
Having Sum(Quantity * UnitPrice) > 15000 
Order by TotalOrderAmount DESC

-- Q34

-- Use discount to calc high value customer
-- Order by total incl. discount

Select 
    Customers.CustomerID 
    ,Customers.CompanyName
    ,TotalsWithoutDiscount = SUM(Quantity * UnitPrice)
    ,TotalsWithDiscount = SUM(Quantity * UnitPrice * (1-Discount))
From 
    Customers 
        Join Orders 
            on Orders.CustomerID = Customers.CustomerID 
        Join OrderDetails 
            on Orders.OrderID = OrderDetails.OrderID 
Where 
    OrderDate >= '20160101' 
    and OrderDate < '20170101' 
Group by 
    Customers.CustomerID 
    ,Customers.CompanyName  
Having SUM(Quantity * UnitPrice * (1-Discount)) > 10000 
Order by TotalsWithDiscount DESC

-- Q35
-- All orders on last day of month ordered by employee id and order id

Select 
    EmployeeID
    ,OrderID
    ,OrderDate
From 
    Orders
Where 
    --Cast(OrderDate as Date) = EOMONTH(Cast(OrderDate as Date))
    OrderDate = EOMONTH(OrderDate)
Order By 
    EmployeeID,
    OrderID

-- Q36
-- Show top 10 orders with the most line items.

Select top 10 with ties
    OrderDetails.OrderID
    ,TotalOrderDetails = COUNT(*)
From 
    OrderDetails
Group by 
    OrderID
Order BY
    Count(*) Desc

-- Q37

Select Top 2 percent 
    OrderID
From Orders
Order By NewID()

-- Q38
-- OrderID's with line items quantity 60+ but diff product ID's

Select 
    OrderID
    --,Quantity
    --,Count(*)
From 
    OrderDetails
Where 
    Quantity >= 60
Group By
    OrderID, Quantity
Having 
    Count(*) >= 2
Order BY
    OrderID

-- Q39

Select 
    OrderID
    ,ProductID
    ,UnitPrice
    ,Quantity
    ,Discount
From 
    OrderDetails
Where OrderID In 
(
    Select
        OrderID
    From 
        OrderDetails
    Where 
        Quantity >= 60
    Group By
        OrderID, Quantity
    Having 
        Count(*) >= 2
)
Order BY
    OrderID
    ,Quantity

-- OR

;with PotentialDuplicates as ( 
    Select 
        OrderID 
    From OrderDetails 
    Where Quantity >= 60 
    Group By OrderID, Quantity 
    Having Count(*) > 1 
    ) 
Select 
    OrderID 
    ,ProductID 
    ,UnitPrice 
    ,Quantity 
    ,Discount 
From OrderDetails 
Where 
    OrderID in (Select OrderID from PotentialDuplicates) 
Order by 
    OrderID 
    ,Quantity