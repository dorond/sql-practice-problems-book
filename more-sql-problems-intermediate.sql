-- Q1

Select 
    ProductID
    ,TotalPriceChanges = Count(*)
From 
    ProductCostHistory
Group By
    ProductID

-- Q2
Select 
    CustomerID
    ,TotalOrders = Count(*)
From 
    SalesOrderHeader
Group By 
    CustomerID
Order By 
    TotalOrders Desc

-- Q3
SELECT
    ProductID
    ,FirstOrder = Convert(date, Min(OrderDate))
    ,LastOrder = Convert(date, Max(OrderDate))
From 
    SalesOrderDetail
     Join SalesOrderHeader
        On SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
Group BY
    ProductID
Order BY
    ProductID

-- Q4
-- CTE Solution
;With ProductFirstLastOrders As 
(
    SELECT
        ProductID
        ,FirstOrder = Convert(date, Min(OrderDate))
        ,LastOrder = Convert(date, Max(OrderDate))
    From 
        SalesOrderDetail
            Join SalesOrderHeader
                On SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
    Group BY
        ProductID
)

Select 
    Product.ProductID
    ,ProductName
    ,FirstOrder
    ,LastOrder
From ProductFirstLastOrders
    Join Product 
        On Product.ProductID = ProductFirstLastOrders.ProductID

-- Subquery Solution
Select 
    Product.ProductID
    ,ProductName
    ,FirstOrder
    ,LastOrder
From 
    (
        SELECT
            ProductID
            ,FirstOrder = Convert(date, Min(OrderDate))
            ,LastOrder = Convert(date, Max(OrderDate))
        From 
            SalesOrderDetail
                Join SalesOrderHeader
                    On SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
        Group BY
            ProductID
    ) ProductFirstLastOrders
    Join Product 
        On Product.ProductID = ProductFirstLastOrders.ProductID