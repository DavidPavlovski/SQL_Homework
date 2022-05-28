use [SEDCACADEMYDB]
go


--Find all Students  with FirstName = Antonio
select * from [dbo].[Student]
where FirstName = 'Antonio'
go

--Find all Students with DateOfBirth greater than ‘01.01.1999’
select * from [dbo].[Student]
where DateOfBirth > '01.01.1999'
go

--Find all Students with LastName starting With ‘J’ enrolled in January/1998
select * from [dbo].[Student]
where LastName like 'J%' and EnrolledDate like '1998-01%'
go

--List all Students ordered  by FirstName

select * from Student
order by FirstName asc

--List all Teacher  Last Names and Student Last Names in single result set. Remove  duplicates
Select LastName from Student
union 
Select LastName from Teacher
go

--Create  Foreign key constraints  from diagram or with script
alter table [dbo].[Grade]
add constraint [FK_Student_ID] foreign key([StudentID])
references [dbo].[Student]([ID])
go

alter table [dbo].[Grade]
add constraint [FK_Course_ID] foreign key([CourseID])
references [dbo].[Course]([ID])
go

alter table [dbo].[Grade]
add constraint [FK_Teacher_ID] foreign key([TeacherID])
references [dbo].[Teacher]([ID])
go

alter table [dbo].[GradeDetails]
add constraint [FK_GradeID] foreign key([GradeID])
references [dbo].[Grade]([ID])
go

alter table [dbo].[GradeDetails]
add constraint [FK_AchivementID] foreign key([AchivementTypeID])
references [dbo].[AchivementType]([ID])
go

--List all possible combinations  of Courses  names and AchievementType names that can be passed  by student
select c.Name as CourseName , a.Name as AchivementName
from [dbo].[Course] c
cross join [dbo].[AchivementType] a
go

--List all Teachers  without exam Grade

select * from [dbo].[Teacher] t
left join [dbo].[Grade] g on g.TeacherId = t.ID
where g.TeacherID is null
