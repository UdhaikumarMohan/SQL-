
-- Trigger Test

Create table Employee(empid int primary key, empname varchar(50) not null, empphone varchar(50), empmail varchar(50))

Create table Training(empid int not null,tid int not null, lang varchar(50) not null, primary key(empid, tid))

Create table Training_Status(empid int not null,tid int not null, status varchar(50) not null, primary key(empid, tid))

Create table Languagesknown(empid int not null, lang varchar(50) not null, primary key(empid, lang))

/*Write triggers to automatically update the related tables. 
If an employee completes training then entry for that language should be made in the languages known table. 
Similarly for update and delete in the training table.*/

create procedure STP_Insert_Employee(@empid int, @empname varchar(50), @empphone varchar(50), @empmail varchar(50))
as 
begin
	insert into Employee values(@empid, @empname, @empphone, @empmail)
end

exec STP_Insert_Employee 1, 'Udhai', '12345', 'u@email'

exec STP_Insert_Employee 2, 'Udhai2', '22345', 'u2@email'

select * from Employee

create procedure STP_Insert_Training(@empid int, @tid int, @lang varchar(50))
as 
begin
	insert into Training values(@empid, @tid, @lang)
end

create trigger Trg_Training_Status on Training for insert
as
begin
	declare @empid int
	select @empid = empid from inserted

	declare @tid int
	select @tid = tid from inserted

	declare @status varchar(50)
	set @status = 'In Progress'

	insert into Training_Status values(@empid, @tid, @status)
end

exec STP_Insert_Training @empid = 1, @tid = 1, @lang = 'German'

exec STP_Insert_Training @empid = 2, @tid = 2, @lang = 'German'

exec STP_Insert_Training @empid = 1, @tid = 3, @lang = 'French'

select * from Training
select * from Training_Status

Create trigger Trg_Status_Update on Training_Status for update
as
begin

	declare @empid int
	select @empid = empid from inserted

	declare @tid int
	select @tid = tid from inserted

	declare @lang varchar(50)
	select @lang = lang from Training where (empid = @empid and tid = @tid)

	insert into Languagesknown values(@empid, @lang)
end
	
update Training_Status set status = 'Completed' where (empid = 1 and tid = 1)

update Training_Status set status = 'Completed' where (empid = 1 and tid = 3)

select * from Training_Status

select * from Languagesknown







