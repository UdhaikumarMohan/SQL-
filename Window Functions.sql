Select * from Products

--Window functions

select categoryId, Count(productID) from Products group by CategoryID

select categoryId, Productname, Count(productID) from Products group by CategoryID, ProductName

select categoryID, Productname, count(productid) over (partition by CategoryID) as TotalProducts from Products order by CategoryID

select categoryID, Productname, count(productid) over () as TotalProducts from Products order by CategoryID

select supplierid, Productname, count(productid) over (partition by supplierid) as TotalProducts from Products order by SupplierID


--Bill Display with Percentage Contribution

select * from [Order Details]

select OrderID, Productid, format(unitprice, 'C2') as Price, quantity, format(Sum(Unitprice * Quantity) over (partition by Productid, orderid), 'C2')
as ProductTotal, format(Sum(Unitprice * Quantity) over (partition by orderid), 'C2') 
as OrderTotal, format(Unitprice * Quantity / Sum(Unitprice * Quantity) over (partition by orderid), 'P') 
as ProductPercent  from [Order Details] order by OrderID asc

select OrderID, Productid, format(unitprice, 'C2'), quantity, format(Sum(Unitprice * Quantity) over (partition by Productid, orderid), 'C2')
as ProductTotal, format(Sum(Unitprice * Quantity) over (partition by orderid), 'C2') 
as OrderTotal, format(Unitprice * Quantity / Sum(Unitprice * Quantity) over (partition by orderid), 'P') 
as ProductPercent  from [Order Details]  where orderid=10248


select OrderID, Productid, format(unitprice, 'C2') as Price, quantity,
format(Sum(Unitprice * Quantity) over (partition by Productid, orderid), 'C2') as OrderProductTotal,
format(Sum(Unitprice * Quantity) over (partition by orderid), 'C2') as OrderTotal, 
format(Sum(Unitprice * Quantity) over (partition by Productid), 'C2') as OverallProductTotal, 
format(Sum(Unitprice * Quantity) over (partition by Productid, orderid)/Sum(Unitprice * Quantity) over (partition by Productid), 'P') as ProductShareInOverallPercentage,  
format(Unitprice * Quantity / Sum(Unitprice * Quantity) over (partition by orderid), 'P') as ProductShareInOrderPercent  
from [Order Details] order by OrderID asc


--------------------------
-- Using Ranking Functions
--------------------------
-- Ranked by UnitPrice and listed by UnitPrice.
SELECT ProductName, UnitPrice,
	ROW_NUMBER() OVER (ORDER BY UnitPrice DESC) AS RowNumber,
	RANK() OVER (ORDER BY UnitPrice DESC) AS Rank,
	DENSE_RANK() OVER (ORDER BY UnitPrice DESC) AS DenseRank,
	NTILE(50) OVER (ORDER BY UnitPrice DESC) AS NTILE50
FROM dbo.Products
ORDER BY UnitPrice DESC;

-- Ranked by UnitPrice but listed by ProductName
SELECT ProductName, UnitPrice,
	ROW_NUMBER() OVER (ORDER BY UnitPrice DESC) AS RowNumber,
	RANK() OVER (ORDER BY UnitPrice DESC) AS Rank,
	DENSE_RANK() OVER (ORDER BY UnitPrice DESC) AS DenseRank,
	NTILE(50) OVER (ORDER BY UnitPrice DESC) AS NTILE50
FROM dbo.Products
ORDER BY ProductName;

-- Ranked within each category using PARTITION BY 
SELECT ProductName, CategoryID, UnitPrice,
	DENSE_RANK() OVER (PARTITION BY CategoryID 
		ORDER BY UnitPrice DESC) AS DenseRank
FROM dbo.Products
ORDER BY CategoryID, UnitPrice DESC;

-- Ranked by category and overall, listed alphabetically
SELECT ProductName, CategoryID, UnitPrice,
	DENSE_RANK() OVER (PARTITION BY CategoryID 
		ORDER BY UnitPrice DESC) AS DenseRankByCategory,
	DENSE_RANK() OVER (ORDER BY UnitPrice DESC) AS OverallDenseRank,
	DENSE_RANK() OVER (ORDER BY UnitsOnOrder DESC) AS OverallByUnitsOnOrder
FROM dbo.Products
ORDER BY ProductName;
