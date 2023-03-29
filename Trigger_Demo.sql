/*
Triggers:

Two types of Triggers:

DDL Triggers (Data Definition Language Triggers)
DML Triggers (Data Manipulation Language Triggers)
 - Afrer Trigger: Runs after original action takes place.
 - Instead Trigger: Performs actions defined in the triggers instead of the original action.
 */

 create table students(studid int primary key, studname varchar(50), status varchar(50))

insert into students values(1,'anand1','active')
insert into students values(2,'anand2','active')
insert into students values(3,'anand3','active')
insert into students values(4,'anand4','active')

select * from students

delete from students where studid=3

select * from deleted

--DML Trigger Demo--

--Default Template--
--create/alter trigger Triggername on Tablename for/instead of  delete/insert/update
--as
--begin
--statements--
--end

--After Trigger--

--dont allow delete instead view contents of deleted table
create trigger trg_students_delete on students for delete
as
begin
select * from deleted
rollback transaction
end

delete from students where studid=3

select * from students


--dont allow deletetion of multiple entries
alter trigger trg_students_delete on students for delete
as
begin
if(select count(*) from deleted)>1
begin
raiserror('cannot delete multiple entries',1,1)
rollback transaction
end
end

delete from students

select * from students

--to drop the existing trigger
drop trigger trg_students_delete

--Instead of Trigger--

--an instead of trigger to change status to discontinued
Alter trigger trg_students_insteadofdelete on students instead of delete
as
begin
update students set status='discontinued'
end

drop trigger trg_students_insteadofdelete

delete from students where studid=1

select * from students

truncate table students

-- correct update trigger using deleted table
create trigger trg_students_insteadofdelete on students instead of delete
as
begin
update students set status='discontinued' from deleted join students on deleted.studid=students.studid
end

--ddl triggers
--Default Template

--create/alter trigger Triggername on database/server for Drop_Table --(Create or alter on Table, Procedure, Trigger...)
--as
--begin
---Statements---
--end


--no instead of triggers in ddl

create trigger trg_ddl_blockdrop on database for Drop_Table
as
begin
raiserror('You cannot drop tables',1,1)
rollback transaction
end

create table emp(empid int)

drop table emp

create table logevents(logid int identity(1,1) primary key, logevent xml)

select * from logevents


create trigger trg_logevents on database for create_Table
as
begin
declare @action xml
set @action=Eventdata()
insert into logevents values(@action)
end

create table emp1(empid int)

create table stud1(studid int, studname varchar(50))

select * from logevents

-- for all database level ddl statements
alter trigger trg_logevents on database for ddl_database_level_events
as
begin
declare @action xml
set @action=Eventdata()
insert into logevents values(@action)
end

create table Demo(did int)

select * from logevents

drop trigger trg_ddl_blockdrop on database

drop table Demo

select * from logevents