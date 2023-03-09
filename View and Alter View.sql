-- Batches.

-- Creating multiple dependent objects requires a GO Seperator 

-- Viwe is used to create a virtual table. 

-- By creating view we no need to write the query repeatedly.

use tempdb;
create table dbo.Test
(
ID int not null, TestName varchar(50) not null
);
Go

create view dbo.vwTest
as
select TestName from dbo.Test;
Go

-- Creating virtual table using join query form Northwind database.

use Northwind
Go

create view dbo.vwProductDetails as (select P.ProductName, C.CategoryName, S.ContactName from dbo.Products as P join dbo.Categories as C on P.CategoryID = C.CategoryID
join dbo.Suppliers as S on P.SupplierID = S.SupplierID);
Go

-- Now we can use the table created by the join query anywhere without writing the query again.

select * from dbo.vwProductDetails;
Go

select ProductName, ContactName from dbo.vwProductDetails where CategoryName = 'Beverages'
Go

-- We can alter the View table by using below Query

-- In the below Query we altered view table by adding SupplierID with it.

Alter View dbo.vwProductDetails as (select P.ProductName, C.CategoryName, S.SupplierID, S.ContactName from dbo.Products as P join dbo.Categories as C on P.CategoryID = C.CategoryID
join dbo.Suppliers as S on P.SupplierID = S.SupplierID);
GO

select * from vwProductDetails order by CategoryName;
Go

