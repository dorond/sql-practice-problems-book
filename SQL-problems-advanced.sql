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