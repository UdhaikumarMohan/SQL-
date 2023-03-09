

-- Joins 

-- Inner Join, Left Join, Full Join, Cross Join, Outer Join

Create table Customers (Cid int primary key, Cname varchar(50), Cphone varchar(50))

insert into dbo.Customers values (1, 'Arun', '99420')
insert into dbo.Customers values (2, 'Bharani', '88838')
insert into dbo.Customers values (3, 'Chandran', '72000')
insert into dbo.Customers values (4, 'Dinesh', '85669')
insert into dbo.Customers values (5, 'Edwin', '71225')

select * from dbo.Customers;

Create table Orders (Oid int primary key, Cid int, Product varchar(50), Quantity int)

insert into dbo.Orders values (1, 2, 'Convex Lens', 20)
insert into dbo.Orders values (2, 1, 'Telescope', 10)
insert into dbo.Orders values (3, 1, 'Prism', 12)
insert into dbo.Orders values (4, 2, 'Thermister', 150)
insert into dbo.Orders values (5, 6, 'Thermometer', 75)
insert into dbo.Orders values (6, 3, 'Thermometer', 75)
insert into dbo.Orders values (7, 7, 'Magetic Stirror', 500)
insert into dbo.Orders values (8, 7, 'Crucible', 20)
insert into dbo.Orders values (9, 4, 'Telescope', 18)
insert into dbo.Orders values (10, 5, 'Magnetic Stirror', 320)
insert into dbo.Orders values (11, 6, 'Acetone 1Litre Bottle', 5)

select * from dbo.Orders;

-- Cross Join (Outer Join)

-- We don't use outer join usually. It combines every rows and columns between two tables.

select * from dbo.Customers as C cross join dbo.Orders as O;

-- One more way to use cross join.

select * from dbo.Customers, dbo.Orders;

-- Inner Join

-- Inner Join is a cross join with the condition.

select * from dbo.Customers as C Cross Join dbo.Orders as O where C.Cid = O.Cid;

-- Simple way to use Inner Join.

select * from dbo.Customers join dbo.Orders on dbo.Customers.Cid = dbo.Orders.Cid;

-- Without Join Keyword.

select * from dbo.Customers, dbo.Orders where dbo.Customers.Cid = dbo.Orders.Cid

-- Another Way to do Inner Join

select * from dbo.Customers as C inner Join dbo.Orders as O on C.Cid = O.Cid;

-- Show only Selective Columns.
select C.Cid as CustID, C.CName as Name, C.Cphone as PhoneNumber, O.Oid as OrderID, O.Product as Product, O.Quantity as Quantity
from dbo.Customers as C join dbo.Orders as O on C.Cid = O.Cid;

-- Left Join

select * from dbo.Customers as C left join dbo.Orders as O on C.Cid = O.Cid;

-- Right Join

select C.Cid, O.Oid from dbo.Customers as C right join dbo.Orders as O on C.Cid = O.Cid;

-- Right Join Inverted table names (Actually Left Join)

select C.Cid, O.Oid from dbo.Orders as O right join dbo.Customers as C on C.Cid = O.Cid;

-- Full Join.

select C.Cid as CustID, C.CName as Name, C.Cphone as PhoneNumber, O.Oid as OrderID, O.Product as Product, O.Quantity as Quantity
from dbo.Customers as C full join dbo.Orders as O on C.Cid = O.Cid;

-- Full Join is usefull for admin

select C.Cid as CustID, C.CName as Name, C.Cphone as PhoneNumber, O.Oid as OrderID, O.Product as Product, O.Quantity as Quantity
from dbo.Customers as C full join dbo.Orders as O on C.Cid = O.Cid where C.Cid is Null;