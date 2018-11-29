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

-- Q5
Select 
    ProductID
    ,StandardCost 
from ProductCostHistory
Where 
    '2012-04-15' between StartDate and EndDate
Order BY
    ProductID

-- Q6
Select 
    ProductID
    ,StandardCost 
from ProductCostHistory
Where 
    '2014-04-15' between StartDate and isNull(EndDate, getdate())
Order BY
    ProductID

-- Q7
--select * from ProductListPriceHistory
-- CTE Solution
;With ProductsChangesByMonth as 
(
    Select 
        ProductListPriceMonth = Convert(varchar, Year(StartDate)) + '/' + Convert(varchar, MONTH(StartDate))
    FROM    
        ProductListPriceHistory
)

Select 
    ProductListPriceMonth
    ,TotalRows = Count(*)
From 
    ProductsChangesByMonth
Group BY    
    ProductListPriceMonth

-- Subquery Solution
Select 
    ProductListPriceMonth
    ,TotalRows = Count(*)
From 
    (
        Select 
            ProductListPriceMonth = Convert(varchar, Year(StartDate)) + '/' + Convert(varchar, MONTH(StartDate))
        FROM    
            ProductListPriceHistory
    ) ProductsChangesByMonth
Group BY    
    ProductListPriceMonth

-- Or
Select
    ProductListPriceMonth = Format( StartDate, 'yyyy/MM')
    ,TotalRows = Count(*)
From 
    ProductListPriceHistory
Group by 
    Format( StartDate, 'yyyy/MM')
Order by 
    ProductListPriceMonth

-- Or

Select
    ProductListPriceMonth = Convert(varchar(7), StartDate, 111)
    ,TotalRows = Count(*)
From 
    ProductListPriceHistory
Group by 
    Convert(varchar(7), StartDate, 111)
Order by 
    ProductListPriceMonth

-- Q8
Select
    CalendarMonth
    ,TotalRows = Count(ProductListPriceHistory.StartDate )
From 
    Calendar
        left join ProductListPriceHistory
            on ProductListPriceHistory.StartDate = Calendar.CalendarDate
Where
    Calendar.CalendarDate >=
    (   
        Select Min(StartDate) 
        from ProductListPriceHistory
    )
    and 
    Calendar.CalendarDate <=
    (   
        Select Max(StartDate) 
        from ProductListPriceHistory
    )
Group by
    CalendarMonth
Order by 
    CalendarMonth
