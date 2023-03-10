use Northwind;
Go


-- 1. List out the all products that are available.

select ProductName from dbo.Products where UnitsInStock !=0;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






-- 2. List out the all products cost less than 50$;

select ProductName from dbo.Products where UnitPrice<50;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






-- 3. List out the all products cost More than 100$;

select ProductName from dbo.Products where UnitPrice>100;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






-- 4. List out the product details along with their category name and description.

select P.ProductName, C.CategoryName, C.Description from dbo.Products as P join dbo.Categories as C on P.CategoryID = C.CategoryID;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






-- 5. List out the product details along with their Category Name and the Contact Name of the supplier who supplied it.

select P.ProductName, C.CategoryName, S.ContactName from dbo.Products as P
join dbo.Categories as C on P.CategoryID = C.CategoryID
join dbo.Suppliers as S on P.SupplierID = S.SupplierID;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






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
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




-- 7. List out all the customers and the count of the orders that they made.

select CustomerID, Count(*) as [Number of Orders] from dbo.Orders group by CustomerID;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






-- 8. Find customer with highest number of orders.

select Top 1 CustomerID, Count(*) as [Number of Orders] from dbo.Orders group by CustomerID order by [Number of Orders] Desc;

declare @j int
set @j = 1
select CustomerID, [Number of Orders] from
(select CustomerID, COUNT(*) as [Number of Orders], DENSE_RANK() over (order by count(*) desc) as Rank from dbo.Orders group by CustomerID) as Max_Ord
where Rank = @j;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





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
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





-- 10. Find the order with highest number of Items.

select top 1 ProductName, UnitsOnOrder from dbo.Products order by UnitsOnOrder desc;



select ProductName, UnitsOnOrder from dbo.Products where UnitsOnOrder = (Select max(UnitsOnOrder) from dbo.Products);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






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
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






-- 12. Find the supplier who supplies the highest number of orders.

select top 1 SupplierID, CompanyName, COUNT(OrderID) as Supp_Ord from
(select S.SupplierID, S.CompanyName, P.ProductID, O.OrderID from dbo.Suppliers as S
join dbo.Products as P on S.SupplierID = P.SupplierID 
join dbo.[Order Details]as O on P.ProductID = O.ProductID)
as Ord_Count group by SupplierID, CompanyName order by Supp_Ord desc;



Declare @i int = 1
select SupplierID, CompanyName, Ord_by_Supplier from 
(select SupplierID, CompanyName, Count(SupplierID) as Ord_by_Supplier, dense_rank() over (Order by Count(SupplierID) desc) as Rank from
(select S.SupplierID, S.CompanyName, P.ProductID, O.OrderID from dbo.Suppliers as S
join dbo.Products as P on S.SupplierID = P.SupplierID 
join dbo.[Order Details]as O on P.ProductID = O.ProductID)
as Ord_Count group by SupplierID, CompanyName) as Top_Company where Rank = @i;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






-- 13. Which category has highest number of products.

select CategoryID, CategoryName from dbo.Categories where CategoryID = 
(select Top 1 CategoryID from
(select CategoryID, COUNT(ProductID) as [Count of Products] from dbo.Products group by CategoryID) as Top_Category order by [Count of Products] desc);



select Top 1 CategoryID, CategoryName, Count_of_Prod from
(select C.CategoryID, C.CategoryName, count(P.ProductID) as Count_of_Prod from dbo.Categories as C join dbo.Products as P on C.CategoryID = P.CategoryID
group by C.CategoryID, CategoryName) as Top_Category order by Count_of_Prod desc;



select CategoryID, CategoryName as Top_Category from dbo.Categories where CategoryID = 
(select CategoryID from
(select CategoryID, COUNT(ProductID) as [Count of Products], DENSE_RANK() over (order by Count(ProductID) desc) 
as Rank from dbo.Products group by CategoryID) as First_Category where Rank = 1);



Declare @K int =5
select CategoryID, CategoryName, Count_of_Prod from
(select C.CategoryID, C.CategoryName, count(P.ProductID) as Count_of_Prod, DENSE_RANK() over (order by count(P.ProductID) desc) as Rank
from dbo.Categories as C 
join dbo.Products as P on C.CategoryID = P.CategoryID
group by C.CategoryID, CategoryName) as Top_Category where Rank = @K;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





-- 14. Which Category is selling Highest.

Declare @N int = 2
select CategoryID, CategoryName, [Products Sold from the Category]  from
(select CategoryID, CategoryName,
SUM(Quantity) as [Products Sold from the Category],
DENSE_RANK() over (order by SUM(Quantity) desc) as Rank from
(select C.CategoryID, C.CategoryName, P.ProductID, O.Quantity from dbo.Categories as C
join dbo.Products as P on C.CategoryID = P.CategoryID
join dbo.[Order Details] as O on P.ProductID = O.ProductID)
as Categories_Sold group by CategoryID, CategoryName)
as Top_Categories where Rank = (((select COUNT(*) from dbo.Categories)+1)-@N)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





-- 15. From which region do we have the highest number of customers.

select * from dbo.Customers;
select CompanyName, City, ISNULL(Region, 'No Data') AS Region from dbo.Suppliers;

Declare @R int = 6
select Region, [Customers from Region] from
(select ISNULL(Region, 'No Data') as Region, COUNT(Distinct CustomerID) as [Customers from Region],
DENSE_RANK() over (order by COUNT(Distinct CustomerID) desc)
as Rank from dbo.Customers group by Region) as Regional_Count where Rank = @R
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






-- 16. List all the regions and the count of customers from that region.

select ISNULL(Region, 'No Data') as Region, COUNT(Distinct CustomerID) as [Customers from Region] from dbo.Customers group by Region;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





-- 17. For a given order id, display the order id, customer id, customer name, employee id, employee name, order date and the total number of products in that order.

select OrderID, CustomerID, ContactName, EmployeeID, [Employee Name], OrderDate, [Total Number of Products in the OrderID] from 
(select O.OrderID, C.CustomerID, C.ContactName,
E.EmployeeID, E.FirstName + ' ' + E.LastName as [Employee Name],
O.OrderDate, sum(D.ProductID)
as [Total Number of Products in the OrderID] from dbo.Orders as O
join dbo.Customers as C on O.CustomerID = C.CustomerID
join dbo.Employees as E on O.EmployeeID = E.EmployeeID
join dbo.[Order Details] as D on O.OrderID = D.OrderID
group by O.OrderID, C.CustomerID, C.ContactName, E.EmployeeID,
E.FirstName + ' ' + E.LastName, O.OrderDate) as Final_Result where OrderID = 10248;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





-- 18. List out all orders that were delivered before the requested date?

select OrderID, RequiredDate, ShippedDate, [DATE Difference] from
(select OrderID, RequiredDate, ShippedDate, DATEDIFF(dd, ShippedDate, RequiredDate) as [Date Difference] from dbo.Orders)
as Deliveries where [Date Difference] < 0;
