

-- Working with Nulls. 

-- IS NULL ==> Operator.

-- ISNULL ==> Function.

-- ANSI Null is ON by defauld (don't turn it off if it is not necessary).

select CompanyName, City from dbo.Suppliers where Region = Null;

-- Change Settings.

set ANSI_NULLS OFF;

-- Now run the above query again.

set ANSI_NULLS ON;

-- But this work reliably.

select CompanyName, City, ISNULL(Region, '???') AS Region from dbo.Suppliers;


-- Using Nullif to convert Null values.

-- The converse of ISNULL is NULLIF, it replaces actual values with nulls.

-- Usefull to eliminate values form aggregation function to make it accurate.

-- View the UnitsInStock data.

select UnitsInStock from dbo.Products;

-- Several products are out of inventory.

select avg(UnitsInStock) from dbo.Products;

-- Some products in stock are 0, but while doing average, it also taking the zero into account. which means it will divide the total with total number of products in iventory including product not in stock.

select avg(nullif(UnitsInStock, 0)) from dbo.Products;

-- By using nullif we can avoid the out of stock affecting the average products count.
-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Syntax

-- COALESCE (exp1, exp2 [,....n])

select COALESCE (3+Null, 2*Null, 5*2, 7);

select CompanyName, Region, Country, City + ',' + COALESCE(Region, Country) as Location from dbo.Suppliers;