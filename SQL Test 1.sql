use Northwind;
Go


-- 1. List out the all products that are available.

select ProductName from dbo.Products where UnitsInStock !=0;


-- 2. List out the all products cost less than 50$;

select ProductName from dbo.Products where UnitPrice<50;


-- 3. List out the all products cost More than 100$;

select ProductName from dbo.Products where UnitPrice>100;


-- 4. List out the product details along with their category name and description.

select P.ProductName, C.CategoryName, C.Description from dbo.Products as P join dbo.Categories as C on P.CategoryID = C.CategoryID;


-- 5. List out the product details along with their Category Name and the Contact Name of the supplier who supplied it.

select P.ProductName, C.CategoryName, S.ContactName from dbo.Products as P
join dbo.Categories as C on P.CategoryID = C.CategoryID
join dbo.Suppliers as S on P.SupplierID = S.SupplierID;


-- 6. Find out the second costliest product.

select ProductName, UnitPrice from dbo.Products 
where UnitPrice = (select max(UnitPrice) as [2nd Costliest] from dbo.Products where UnitPrice not in (select max(UnitPrice) from dbo.Products));

select max(UnitPrice) as [2nd Costliest] from dbo.Products where UnitPrice not in (select max(UnitPrice) from dbo.Products);

select max(UnitPrice) as [2nd Costliest] from dbo.Products where UnitPrice < (select max(UnitPrice) from dbo.Products);

-- Nth highest value

select Top 1 ProductName, UnitPrice from (select Top 10 with ties ProductName, UnitPrice from dbo.Products order by UnitPrice desc) as N_Max order by UnitPrice asc;

-- The below query will not work because we cannot give parameters on select statement.

--(declare @i int
--set @i = 10
--select Top 1 ProductName, UnitPrice from (select Top @i with ties ProductName, UnitPrice from dbo.Products order by UnitPrice desc) as N_Max order by UnitPrice asc;)

-- Select Nth highest using dense_rank.
Declare @i int
set @i=5
select ProductName, UnitPrice from (select ProductName, UnitPrice, DENSE_RANK() over (order by UnitPrice desc) as Rank from dbo.Products)
as N_Max Where Rank = @i

-- 7. List out all the customers and the count of the orders that they made.

select CustomerID, Count(*) as [Number of Orders] from dbo.Orders group by CustomerID;


-- 8. Find customer with highest number of orders.

select Top 1 CustomerID, Count(*) as [Number of Orders] from dbo.Orders group by CustomerID order by [Number of Orders] Desc;

declare @j int
set @j = 1
select CustomerID, [Number of Orders] from
(select CustomerID, COUNT(*) as [Number of Orders], DENSE_RANK() over (order by count(*) desc) as Rank from dbo.Orders group by CustomerID) as Max_Ord
where Rank = @j;


-- We can find out by creating view.

create view vwNumOrd as (select CustomerID, Count(*) as [Number of Orders] from dbo.Orders group by CustomerID);
Go

select CustomerID, [Number of Orders] from vwNumOrd where [Number of Orders] = max([Number of Orders]);


-- 9. Find out the customers with second highest orders.

select CustomerID, COUNT(*) as [Total Orders] from dbo.Orders where CustomerID = (select Top 1 CustomerID from 
(select Top 2 CustomerID, COUNT(*) as [Num of Ord] from dbo.Orders
group by CustomerID order by COUNT(*) desc) as Ord_Count group by CustomerID
order by COUNT(*) asc) group by CustomerID;

declare @j int
set @j = 2
select CustomerID, [Number of Orders] from
(select CustomerID, COUNT(*) as [Number of Orders], DENSE_RANK() over (order by count(*) desc) as Rank from dbo.Orders group by CustomerID) as Max_Ord
where Rank = @j;

-- 10. Find the order with highest number of Items.

select top 1 ProductName, UnitsOnOrder from dbo.Products order by UnitsOnOrder desc;

select ProductName, UnitsOnOrder from dbo.Products where UnitsOnOrder = (Select max(UnitsOnOrder) from dbo.Products);

-- 11. Find the customer with the highest order value.

select Top 1 CustomerID, SUM(UnitPrice) as Ord_Value from
(select C.CustomerID, O.OrderID, D.UnitPrice from dbo.Customers as C 
join dbo.Orders as O on C.CustomerID = O.CustomerID
join dbo.[Order Details] as D on O.OrderID = D.OrderID) as Ord_Details group by CustomerID order by Ord_Value desc;

select CustomerID, Price from
(select CustomerID, Sum(UnitPrice) as Price, DENSE_RANK() over (order by Sum(UnitPrice) desc) as Rank from
(select C.CustomerID, O.OrderID, D.UnitPrice from dbo.Customers as C 
join dbo.Orders as O on C.CustomerID = O.CustomerID
join dbo.[Order Details] as D on O.OrderID = D.OrderID) as Ord_value group by CustomerID) as Premium_Cust where Rank = 1 

-- 12. Find the supplier who supplies the highest number of orders.

create view vwSupplier as 
(select S.SupplierID, S.ContactName, P.ProductID from dbo.Suppliers as S join dbo.Products as P on S.SupplierID = P.SupplierID);
Go

select Top 1 with Ties SupplierID, count(*) as [Number of Supplies] from vwSupplier group by SupplierID order by [Number of Supplies] Desc;

-- 13. Which category has highest number of products.

--[select C.CategoryID, C.CategoryName, P.ProductID, Count(*) from dbo.Products as P join dbo.Categories as C on P.CategoryID = C.CategoryID group by C.CategoryID Order by count(*) desc;]

create view vwcategory as 
(select C.CategoryID, C.CategoryName, P.ProductID from dbo.Products as P join dbo.Categories as C on P.CategoryID = C.CategoryID);
Go

select CategoryName, COUNT(*) as [Number of Products] from vwcategory group by CategoryName order by [Number of Products] desc;


select CategoryID, COUNT(*) as [Number of Products] from dbo.Products group by CategoryID order by [Number of Products] desc;

-- [select CategoryName from dbo.Categories where CategoryID = (select CategoryID, COUNT(*) as [Number of Products] from dbo.Products group by CategoryID);]


-- 14. 
