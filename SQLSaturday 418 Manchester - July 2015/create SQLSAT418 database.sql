USE [master]
GO
ALTER DATABASE [SQLSAT418] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
/****** Object:  Database [SQLSAT418]    Script Date: 16/07/2015 15:00:15 ******/
DROP DATABASE [SQLSAT418]
GO
CREATE DATABASE [SQLSAT418]
COLLATE SQL_Latin1_General_CP1_CS_AS
GO
USE [SQLSAT418]
GO




use SQLSAT418;
if object_id('Customer','U') is not null drop table Customer
create table dbo.Customer(
	CustomerID int not null,
	PersonID int null,
	StoreID int null,
	TerritoryID int null,
	AccountNumber  varchar(10),
	[rowguid] [uniqueidentifier] rowguidcol  not null,
	ModifiedDate datetime not null,
 constraint PK_Customer_CustomerID primary key clustered (CustomerID asc)
)

go


insert into dbo.Customer
select * from AdventureWorks2012.Sales.Customer