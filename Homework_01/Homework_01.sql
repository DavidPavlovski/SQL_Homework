use [master]
go

drop database if exists [SEDCACADEMYDB]
go

create database [SEDCACADEMYDB]
go
use [SEDCACADEMYDB]
go

drop table if exists [dbo].[Student]
go
create table [Student]
(
	[ID][int] identity(1,1),
	[FirstName] [nvarchar](100) not null,
	[LastName] [nvarchar](100) not null , 
	[DateOfBirth] [date] not null,
	[EnrolledDate] [date] not null,
	[Gender] [char] not null,
	[NationalIDNumber] [nvarchar](100) not null , 
	[StudentCardNumber] [nvarchar](100) not null
	constraint [PK_Student] primary key clustered (
		[ID] asc
	)
)
go

drop table if exists [dbo].[Teacher]
go
create table [Teacher]
(
	[ID][int] identity(1,1),
	[FirstName] [nvarchar](100) not null,
	[LastName] [nvarchar](100) not null,
	[DateOfBirth] [date] not null,
	[AcademicRank] [nvarchar](100) not null,
	[HireDate] [date] not null
	constraint [PK_Teacher] primary key clustered (
		[ID] asc
	)
)
go

drop table if exists [dbo].[Grade]
go
create table [Grade]
(
	[ID][int] identity(1,1),
	[StudentID][int] not null,
	[CourseID] [int] not null,
	[TeacherID] [int] not null,
	[Grade] [int] not null,
	[Comment] [nvarchar](100) null constraint DFT_Comment default 'no comment',
	[CreatedDate] [date] not null,
	constraint [PK_Grade] primary key clustered (
		[ID] asc
	)
)
go

drop table if exists [dbo].[Course]
go
create table [Course]
(
	[ID][int] identity(1,1),
	[Name] [nvarchar] (100) not null,
	[Credit] [int] not null,
	[AcademicYear] [int],
	[Semester] [int] not null
	constraint [PK_Course] primary key clustered (
		[ID] asc
	)
)
go

drop table if exists [dbo].[AchivementType]
go
create table [AchivementType]
(
	[ID][int] identity(1,1),
	[Name] [nvarchar](100) not null,
	[Description] [nvarchar] (100) null constraint DFT_Description default 'no description',
	[ParticipationRate] [int] not null
	constraint [PK_AchivementType] primary key clustered (
		[ID] asc
	)
)
go

drop table if exists [dbo].[GradeDetails]
go
create table [GradeDetails]
(
	[ID][int] identity(1,1),
	[GradeID] [int] not null,
	[AchivementTypeID] [int] not null,
	[AchivementPoints] [int] not null,
	[AchivementMaxPoints] [int] not null,
	[AchivementDate] [date] not null
	constraint [PK_GradeDetails] primary key clustered (
		[ID] asc
	)
 )
go

