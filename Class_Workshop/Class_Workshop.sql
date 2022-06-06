use [master]
go
drop database if exists Pizzaria
go
create database Pizzaria
go
use [Pizzaria]
go

drop table if exists [User]
drop table if exists [Pizza]
drop table if exists [Order]
drop table if exists [PizzaSize]
drop table if exists [Topping]
drop table if exists [Pizza Toppings]

go

create table [User] 
(
	Id int identity(1,1),
	FirstName nvarchar(100) not null,
	LastName nvarchar(100) not null,
	[Address] nvarchar(100) not null,
	Phone nvarchar(100) not null
	constraint [PK_User] primary key clustered (
		[Id] asc
	)
)
go

create table [Order]
(
	Id int identity(1,1),
	Price decimal not null,
	Delivered bit not null constraint DFT_Delivered default 0,
	UserId int constraint [FK_UserId] foreign key references [User]([Id]),
	constraint [PK_Order] primary key clustered (
		[Id] asc
	)
)
go

create table PizzaSize
(
	Id int identity(1,1),
	[Name] nvarchar(100) not null,
	constraint [PK_PizzaSize] primary key clustered (
		[Id] asc
	)
)
go


create table Pizza
(
	Id int identity (1,1),
	[Name] nvarchar(100) not null,
	Price int not null ,
	PizzaSizeId int constraint [FK_PizzaSize] foreign key references [PizzaSize]([Id]) not null,
	OrderId int constraint [FK_Order] foreign key references [Order]([Id]) not null,
	constraint [PK_Pizza] primary key clustered (
		[Id] asc
	)
)

create table Topping
(
	Id int identity(1,1),
	[Name] nvarchar(100) not null,
	Price int not null,
	constraint [PK_Topping] primary key clustered(
		[Id] asc
	)
)
go

create table PizzaToppings(
	Id int identity(1,1),
	PizzaId int constraint [FK_PizzaId] foreign key references Pizza([Id]) not null,
	ToppingId int constraint [FK_Pizza_ToppingId] foreign key references Topping([Id]) not null,
	constraint [PK_PizzaToppings] primary key clustered (
		[Id] asc
	)
)
go