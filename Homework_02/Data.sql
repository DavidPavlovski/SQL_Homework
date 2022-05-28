use [SEDCACADEMYDB]

insert into [dbo].[Student](FirstName , LastName , DateOfBirth , EnrolledDate , Gender , NationalIDNumber , StudentCardNumber)
values	('Bob' , 'Bobsky' ,             '08.24.1991' , '11.11.2021' , 'M',  'AAA111' , '1234556789'),
		('Aleksandar' , 'Aleksandrov' , '04.13.1992' , '02.14.2019' , 'M' , 'AAA222' , '111222333'),
		('Antonio' , 'Banderas' ,       '05.22.1998' , '03.30.2022' , 'M' , 'AAA333' , '789789789'),
		('Jane' , 'Doe' ,               '12.18.2001' , '01.18.2019' , 'F' , 'AAA444' , '456456456'),
		('John' , 'Doe' ,               '10.07.2002' , '12.24.2018' , 'M' , 'AAA555' , '333444555'),
		('Beti' , 'Betsky' ,            '09.04.1997' , '11.15.2016' , 'F' , 'AAA666' , '234234234'),
		('John' , 'Johnsky' ,           '06.29.1999' , '06.17.2020' , 'M' , 'AAA777' , '222333444'),
		('Aleksandra' , 'Janeva' ,      '01.30.1980' , '01.01.1998' , 'F' , 'AAA888' , '123123123')
go

insert into [dbo].[Teacher](FirstName , LastName , DateOfBirth , AcademicRank , HireDate)
values ('Pero' , 'Perovski' , '03.18.1974' , 'Professor' , '01.15.2007'),
		('Jana' , 'Janevska' , '04.20.1983' , 'Assistant Professor' , '03.04.2012'),
		('Biljana','Biljanova','12.30.1965','Professor','10.12.2006'),
		('Toni','Tonevski','10.18.1989','Assistant Professor','06.05.2016')
go

insert into [dbo].[Course] (Name , Credit , AcademicYear , Semester)
values	('basics of web development HTML/CSS' , 5 , 2021, 1),
		('basic javascript' , 5 , 2021 , 1),
		('advanced javascript' , 5 , 2022 , 1),
		('basic c#' , 5 , 2022 , 2),
		('advanced c#' , 5 , 2022 , 2),
		('databases(SQL)' , 5 , 2022 , 2)
go

insert into [dbo].[Grade](StudentID , CourseID , TeacherID , Grade , CreatedDate)
values  (1,1,1,5,'05.28.2022'),
		(2,2,2,3,'01.27.2022'),
		(3,3,1,3,'02.12.2022'),
		(4,3,4,4,'03.24.2022'),
		(5,4,4,5,'03.24.2022'),
		(6,4,1,2,'02.12.2022'),
		(7,5,2,3,'01.27.2022'),
		(8,6,1,4,'02.12.2022')
go

insert into [dbo].[GradeDetails](GradeID , AchivementTypeID , AchivementPoints , AchivementMaxPoints , AchivementDate)
values	(1,3,70,100,'02.12.2022'),
		(2,1,90,100,'03.24.2022'),
		(3,3,65,100,'01.27.2022'),
		(4,2,80,100,'01.27.2022')
go
insert into [dbo].[AchivementType]([Name] , ParticipationRate)
values  ('Very high' , 10),
		('High' , 20),
		('Average' , 40)
go