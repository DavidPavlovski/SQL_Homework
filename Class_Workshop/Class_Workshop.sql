use [master]
drop database if exists Pizzaria
create database Pizzaria
use [Pizzaria]
go

drop table if exists [User]
drop table if exists [Pizza]
drop table if exists [Order]
drop table if exists [PizzaSize]
drop table if exists [Topping]
drop table if exists [PizzaToppings]
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
	IsDelivered bit not null constraint DFT_Delivered default 0,
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
go

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

create or alter function FullName(@UserId int)
returns nvarchar(255)
as
begin

declare @FullName nvarchar(255)
select @FullName = CONCAT(FirstName , ' ' , LastName) from [User]
where [User].Id = @UserId
return @FullName
end
go

create or alter view vv_NotDelivered 
as
select p.OrderId as OrderId,p.PizzaSizeId , dbo.FullName(u.Id) as FullName, p.Name as PizzaName 
from [Order] o
join [User] u on o.UserId = u.Id
join [Pizza] p on o.Id = p.OrderId
where o.IsDelivered = 0
go

select * from vv_NotDelivered
go

create or alter procedure GetOrderPrice(@OrderId int ,@DeliveryCost decimal, @TotalPrice decimal(4,2) output)
as
begin

set @TotalPrice = (select sum(t.Price + p.Price + @DeliveryCost)
from PizzaToppings pt
join Pizza p on pt.PizzaId = p.Id	
join Topping t on pt.ToppingId = t.Id
where p.OrderId = @OrderId)

end
go

create or alter view vv_MostPopularPizzas
as
select p.Name , COUNT(p.name) as OrdersCount
from [Order] o
join Pizza p on o.Id = p.OrderId
group by p.Name
go

select * from vv_MostPopularPizzas
order by OrdersCount desc
go

create or alter view vv_MostPopularToppings
as
select t.Name as ToppingName,COUNT(t.Name) as ToppingOrderCount 
from PizzaToppings pt
join Pizza p on pt.PizzaId = p.Id
join Topping t on pt.ToppingId = t.Id
group by t.Name , t.Id
go

select * from vv_MostPopularToppings
order by ToppingOrderCount desc
go

create or alter view vv_PizzaOrdersByUser
as
select dbo.FullName(u.Id) as CustomerName , count(u.Id) as NumberOfPizzasOrdered
from [Order] o 
join [User] u on o.UserId = u.Id
join [Pizza] p on o.Id = p.OrderId
group by dbo.FullName(u.Id) , u.Id
go

select * from vv_PizzaOrdersByUser
order by NumberOfPizzasOrdered desc