
-- Creating table for Customer Details.

Create table QD_Customers (Customer_ID varchar(50) constraint QD_PK_Customer_ID primary key not null, Company_Name varchar(50) not null, Contact_Name varchar(50),
Contact_Title varchar(50), Address Varchar(50), City varchar(50), Region varchar(50), Postal_Code varchar(50), Country varchar(50), 
Phone varchar(50), Fax varchar(50))

Insert into QD_Customers values ('QDC0001', 'Surya Stores', 'Manikandan Surya', 'Owner', '21 Railway Station Road', 'Jaffna',
'Northern Region', 'SLNR005', 'SriLanka', '+95-955482', '105-42510') 

Insert into QD_Customers values ('QDC0002', 'Bajanlal & Co', 'Gupta Vikas', 'Regional Manager', '041 Pink Garden', 'Jaipur',
'Rajasthan', 'IRJ0023', 'India', '+91-994582', '0120-320025') 

Insert into QD_Customers values ('QDC0003', 'Deccan Enterprises', 'Nizamudeen Rajmohammed', 'CEO', '01 Nizam Market', 'Hyderabad',
'Telengana', 'IHT0008', 'India', '+91-81225', '0129-345875')

Insert into QD_Customers (Customer_ID, Company_Name, Address, City, Postal_Code, Country, Phone, Fax) values ('QDC0004', 
'Bon App', '12 rue des Bouchers', 'Marseille', '13008', 'France', '91.24.45.40', '91.24.45.40')

Insert into QD_Customers (Customer_ID, Contact_Name, Contact_Title, Company_Name, Address, City, Region, Postal_Code, Country, Phone)
values ('QDC0005', 'Smith Antony', 'Regional Manager', 'Trail`s Head Gourmet Provisioners', '722 DaVinci Blvd', 'Huston', 'Texas', '98034', 'USA', '(206) 555-8257')

select * from QD_Customers





-- Creating table for Employees.

Create table QD_Employees (Employee_ID int constraint QD_PK_Employee_ID primary key not null,
LastName varchar(50) not null, FirstName varchar(50) not null, Title varchar(50), DoB Date, DoH Date,
Address varchar(50), City varchar(50), Region varchar(50), Post_Code varchar(50), Country varchar(50),
Reports int constraint QD_FK_Employee_Self foreign key references QD_Employees(Employee_ID))

alter table QD_Employees add constraint QD_CK_DOB check(DOB> '01011950')





-- Creating table for Shippers.

Create table QD_Shippers (Shipper_ID int identity(1,1) constraint QD_PK_Shipper_ID primary key not null,
Company_Name varchar(50) not null, Phone varchar(50))






-- Creating table for Orders.

Create table QD_Orders (Order_ID int identity (1001, 1) Constraint QD_PK_Order_ID primary key not null,
Customer_ID varchar(50) Constraint QD_FK_Customer_ID foreign key references QD_Customers(Customer_ID),
Employee_ID int Constraint QD_FK_Employee_ID foreign key references QD_Employees(Employee_ID),
Order_Date Date, Shipped_Date Date, Ship_via int constraint QD_FK_Ship_via foreign key references QD_Shippers(Shipper_ID),
Ship_Name varchar(50), Ship_Address varchar(50), Ship_City varchar(50), Ship_Region varchar(50), Ship_PostalCode varchar(50),
Ship_Country varchar(50))





-- Creating table for Suppliers.

Create table QD_Suppliers (Supplier_ID int constraint QD_PK_Supplier_ID primary key not null,
Company_Name varchar(50), Contact_Name varchar(50), Chapter_Title varchar(50), Address varchar(50),
City varchar(50), Region varchar(50), Postal_Code varchar(50), Country varchar(50), Phone varchar(50),
Fax varchar(50))





-- Creating table for Categories.

Create table QD_Categories (Category_ID int constraint QD_PK_Category_ID primary key not null, Category_Name varchar(50))





-- Creating table for Products.

Create table QD_Products (Product_ID int constraint QD_PK_Product_ID primary key not null, Product_Name varchar(50) not null, 
Supplier_ID int constraint QD_FK_Supplier_ID foreign key references QD_Suppliers(Supplier_ID),
Category_ID int constraint QD_FK_Category_ID foreign key references QD_Categories(Category_ID),
Quantity_Per_Unit varchar(50), 
Unit_Price money constraint QD_DF_Unit_Price Default 10.0 constraint QD_Unit_Price_CK check (Unit_Price>10.0),
Unit_in_Stock smallint constraint QD_CK_Unit_in_Stock Default 0)




-- Creating table for Order details.

Create table QD_Order_Details (Order_ID int not null constraint QD_FK_Order_ID foreign key references QD_Orders(Order_ID), 
Product_ID int not null constraint QD_FK_Product_ID foreign key references QD_Products(Product_ID),
Unit_Price money not null constraint QD_CK_Unit_Price_Order check (Unit_Price > 0) constraint QD_DF_Unit_Price_Order Default 10.0,
Quantity smallint not null constraint QD_CK_Quantity check (Quantity > 0) constraint QD_DF_Quantity Default 1,
Discount real not null constraint QD_CK_Discount check (Discount !< 0) constraint QD_DF_Discount Default 0,
constraint QD_PK_Order_and_Product_ID primary key (Order_ID, Product_ID)) 


