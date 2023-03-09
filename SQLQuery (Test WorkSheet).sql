

select * from dbo.Products;

select * from dbo.Categories;

select * from dbo.Suppliers;

select * from dbo.[Order Details];

select * from dbo.Orders;

select * from dbo.Customers;



select P.ProductName, C.CategoryName, S.ContactName from dbo.Products as P join dbo.Categories as C on P.CategoryID = C.CategoryID
join dbo.Suppliers as S on P.SupplierID = S.SupplierID;