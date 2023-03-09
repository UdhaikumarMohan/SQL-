-- Constrains
-- In some instance to avoid Null values we can use default keyword.
-- chek keyword used to define some condition for the column.
-- Unique Keyword is used to set a unique value to that column.

create table Cars(carid varchar(50) not null primary key, Carcolor varchar(50) not null default 'White',
carprice int not null check (carprice>10000), regno varchar(50) not null unique)

insert into Cars values(1, 'Blue', 15000, 'AT8757')

insert into Cars(carid, carprice, regno) values (2, 11000, 'BC2338')
insert into Cars(carid, carprice, regno) values (3, 12000, 'BC2339')
insert into Cars values(4, 'Green', 15000, 'AT9757')

select * from dbo.Cars

-- Update the column data.

update Cars set carprice=20000 where carid = 4

select * from Cars

-- Delete the entire row form the table.

Delete from Cars where carid = 2

select * from dbo.Cars