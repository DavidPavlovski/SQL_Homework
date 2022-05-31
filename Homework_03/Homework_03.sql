use [SEDCACADEMYDB]
go

--Calculate the count of all grades per Teacher in the system
select t.FirstName + ' ' + t.LastName as TeacherName , COUNT(Grade) as NumberOfGrades
from Grade g
join [dbo].[Teacher] t on g.TeacherID = t.ID
group by t.FirstName + ' ' + t.LastName
go

--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)
select t.FirstName + ' ' + t.LastName as TeacherName , COUNT(Grade) as NumberOfGrades
from Grade g
join [dbo].[Teacher] t on g.TeacherID = t.ID
where g.StudentID < 100
group by t.FirstName + ' ' + t.LastName
go

--Find the Maximal Grade, and the Average Grade per Student on all grades in the system
select s.FirstName + ' ' +  s.LastName as StudentName , max(Grade) as HighestGrade , min(Grade) as LowestGrade , avg(Grade) as AverageGrade
from Grade g 
join [dbo].[Student] s on g.StudentID = s.Id
group by s.FirstName + ' ' +  s.LastName
go

--Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200
select t.FirstName + ' ' + t.LastName as TeacherName , COUNT(Grade) as NumberOfGrades
from Grade g
join [dbo].[Teacher] t on g.TeacherID = t.ID
group by t.FirstName + ' ' + t.LastName
having count(Grade) > 200
go

--Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. Filter only records where Maximal Grade is equal to Average Grade
select s.FirstName + ' ' +  s.LastName as StudentName , max(Grade) as HighestGrade , min(Grade) as LowestGrade , avg(Grade) as AverageGrade
from Grade g 
join [dbo].[Student] s on g.StudentID = s.Id
group by s.FirstName + ' ' +  s.LastName
having max(grade) = avg(grade)
go

--Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student
create or alter view vv_StudentGrades
as
select s.Id as StudentId, COUNT(g.Grade) as NumberOfGrades
from [dbo].[Grade] g 
join [dbo].[Student] s on g.StudentID = s.Id
group by s.Id
go
select * from vv_StudentGrades
go

--Change the view to show Student First and Last Names instead of StudentID
create or alter view vv_StudentGrades
as
select s.FirstName + ' ' + s.LastName as StudentName, COUNT(g.Grade) as NumberOfGrades
from [dbo].[Grade] g
join [dbo].[Student] s on g.StudentID = s.Id
group by s.FirstName + ' ' + s.LastName
go
select * from vv_StudentGrades
go

--List all rows from view ordered by biggest Grade Count

select * from vv_StudentGrades
order by NumberOfGrades desc