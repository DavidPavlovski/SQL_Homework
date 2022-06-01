use [SEDCACADEMYDB]
select * from Student
go


--Declare scalar variable for storing FirstName values
--Assign value ‘Antonio’ to the FirstName variable
--Find all Students having FirstName same as the variable
declare @StudentName nvarchar(50) = 'Antonio'
select * from Student s 
where s.FirstName = @StudentName
go

--Declare table variable that will contain StudentId, StudentName and DateOfBirth
--Fill the table variable with all Female students

declare @FemaleStudents table(StudentId int , StudentName nvarchar(100) , DateOfBirth date)
insert into @FemaleStudents(StudentId , StudentName , DateOfBirth)
select s.Id ,concat(s.FirstName , ' ' , s.LastName) , s.DateOfBirth
from Student s 
where Gender = 'F'
select * from @FemaleStudents
go

--Declare temp table that will contain LastName and EnrolledDate columns
--Fill the temp table with all Male students having First Name starting with ‘A’
--Retrieve the students from the table which last name is with 7 characters
drop table if exists #StudentList
create table #StudentList(LastName nvarchar(100) , EnrolledDate date)
insert into #StudentList(LastName , EnrolledDate)
select s.LastName , s.EnrolledDate
from Student s 
where Gender = 'M' and FirstName like 'A%'
select * from #StudentList
go


--Find all teachers whose FirstName length is less than 5 and
--the first 3 characters of their FirstName and LastName are the same
drop table if exists #TeacherList
create table #TeacherList(TeacherId int , TeacherFirstName nvarchar(100) , TeacherLastName nvarchar(100) , TeacherCode nvarchar(50))
insert into #TeacherList(TeacherId , TeacherFirstName, TeacherLastName , TeacherCode)
select t.Id, t.FirstName , t.LastName , CONCAT(t.Id , '-',left(t.FirstName,3) , '-' , left(t.LastName ,3))
from Teacher t 
where len(t.FirstName) > 5 and left(t.FirstName,3) = left(t.LastName,3)
select * from #TeacherList
go