-- Data Definition Language

create table Emp(empid int, empname varchar(50))

-- Change empid into varchar(50) from Int.

alter table emp alter column empid varchar (50)

-- Add a new column to the table.

alter table emp add empage int

-- Drop a column form the table emp

alter table emp drop column empage

create table Stud(studid int primary key, studname varchar(50))

-- Drop a constrain by name.

alter table stud drop constraint PK__Stud__E270950B7AF42FE3

-- Create constrain with Name

create table cust(custid int constraint My_Key1 primary key, custname varchar(50),
age int constraint age_check check(age>18))

-- My_Key1 is the constraint Name for the Primary Key and age check is the constraint name for the check

alter table cust drop constraint age_check

-- Creating a table.

create table customer(custid int primary key, cname varchar(50) not null, cphone varchar(50))

-- Create a table with foreign key.

create table orders(ordid int primary key, cid int foreign key references customer(custid), quantity int)

-- Create foreign key with name

create table order1(ordid int constraint My_Key2 primary key, cid int constraint My_Order foreign key references
customer(custid), quantity int)


create table mycust(custid int, Cname varchar(50), constraint my_Pk1 primary key (custid))

-- Primary and foreign keys with alter table commands.

create table mycust1(custid int not null, custname varchar(50))

alter table mycust1 add constraint my_Pk2 primary key(custid)

create table myord1(oid int primary key, cid int, quantity int)

alter table myord1 add constraint my_fk2 foreign key (cid) references mycust1(custid)

-- Changing name of the primary key.

create table Ocean (Ocid int identity(1,1) primary key not null, Fish_name varchar(50))

insert into Ocean values('Blue Whale')
insert into Ocean values('Shark')
insert into Ocean values('Dolphin')
insert into Ocean values('Turtles')

alter table Ocean drop constraint PK__Ocean__59A1EBB288464609

alter table Ocean drop column ocid

alter table Ocean add OCID int identity(1001,1) constraint My_Ocean primary key not null 

select * from Ocean



