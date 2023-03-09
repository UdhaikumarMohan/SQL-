create table students (studid int identity (2023001,1) not null primary key, studname varchar(50),studage int)

insert into students values('Meera', 28)
insert into students values('Ashik', 29)
insert into students values('Giant', 30)
insert into students values('Karikalan', 26)
insert into students values('Prakash', 28)

select studname from students where studid = 2023001

--Practice

--"Identity" is a keyword which is used to ID automatically.
--Consists two arguments, one is for seed number and other is for increment.

create table Price_List (Item_No int identity(001, 1) primary key not null,  Item varchar(50) not null,
Price int not null)

insert into Price_List values('Idly', 10)
insert into Price_List values('Dosa', 30)
insert into Price_List values('Vada', 5)
insert into Price_List values('Samosa', 5)
insert into Price_List values('Bajji', 5)
insert into Price_List values('Poori', 10)
insert into Price_List values('Parotta', 10)

select * from dbo.Price_List

select Item from dbo.Price_List where Price = 5

-- Create table with date as columm. Use Datetime keyword. (Date format (YYYYMMDD))

create table Cust(Cid int primary key not null, CustName varchar(50) not null,
CustPh varchar(50), CustDOB datetime)

alter table Cust alter column CustDOB date

insert into dbo.Cust values(1, 'AnandRaj', '988788', '19950108')
insert into dbo.Cust values(2, 'Naveen', '998788', '19960515')
insert into dbo.Cust values(3, 'Sathish', '987788', '19950108')

-- We can give data to the selected columns.

insert into dbo.Cust(Cid, CustName, CustDOB) values (4, 'Sathish', '19970730')
insert into dbo.Cust(Cid, CustName, CustPh) values (5, 'Prakash', '883877')

select * from Cust

-- To Bring Null data we should use IS keyword

select (CustName) from dbo.Cust where CustPh is Null


-- To Set Multiple Primary Keys.

create table studmark (studid int not null, examtype varchar(50) not null, examyear int not null, mark int,
primary key(studid, examtype, examyear))

insert into studmark values(1, 'sem1', 2018, 60)

select * from studmark