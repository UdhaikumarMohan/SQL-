create table employee(empid int primary key not null, empname varchar(50) not null, empage int)

insert into employee values(1, 'Udhai', 27)
insert into employee values(2, 'Mani', 28)
insert into employee values(3, 'Naveen', 26)
insert into employee values(4, 'Ajith', 27)
insert into employee values(5, 'Raju', 26)

select * from employee where empage = 27

--Practice:

create table Ranks(Name varchar(50) primary key, Marks varchar(50), Rank int) 

alter table Ranks alter column Name varchar(50) not null

insert into Ranks values('Pavithra', '89%', 1)
insert into Ranks values('Rini', '88%', 2)
insert into Ranks values('Udhai', '75', 3)
insert into Ranks values('Iniyan', '70', 4)
insert into Ranks values('Sundar', '69', 5)

Select * from Ranks where Name like 'Udhai'