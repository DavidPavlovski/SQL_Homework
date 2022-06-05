use [SEDCACADEMYDB]

select * from Grade
select * from AchievementType
select * from GradeDetails
go


create or alter procedure CreateGrade (@StudentId int , @CourseId int , @TeacherId int , @Grade int , @Comment nvarchar(100) = '' , @CreatedDate date )
as
begin

insert into Grade(StudentID , CourseID , TeacherID , Grade , Comment , CreatedDate)
values(@StudentId , @CourseId , @TeacherId , @Grade , @Comment , @CreatedDate)

select count(g.Grade) as NumberOfGrades
from Grade g
join Student s on g.StudentID = s.ID
where g.StudentID = @StudentId

select max(g.Grade) as MaxGrade 
from Grade g
join Student s on g.StudentID = s.ID
where g.TeacherID = @TeacherId and g.StudentID = @StudentId

end
go

create or alter procedure CreateGradeDetail(@GradeId int , @AchievementTypeId int , @AchievementPoints int , @AchievementMaxPoints int , @AchievementDate date , @Result decimal(18,2) output)
as
begin 

insert into GradeDetails(GradeID , AchievementTypeID , AchievementPoints , AchievementMaxPoints , AchievementDate)
values (@GradeID , @AchievementTypeId , @AchievementPoints , @AchievementMaxPoints , @AchievementDate)

declare @ParticipationRate int = (select a.ParticipationRate from AchievementType a where a.ID = @AchievementTypeId)
select @ParticipationRate as pr

set @Result = (cast(@AchievementPoints as float) / cast(@AchievementMaxPoints as float)) * cast(@ParticipationRate as float)

end
go

declare @OutResult decimal (18,2)
execute CreateGradeDetail 4,5,72,100,'06.05.2022',@OutResult output
select @OutResult as result
