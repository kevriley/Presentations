use AdventureWorks2008R2
go

/**********************************************************************************************************************************/

--Cardinality estimate warning
SELECT 
	soh.SalesOrderID, OrderDate
from Sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
where convert(datetime,convert (varchar,orderdate,112)) >= '1 jan 2006'































/**********************************************************************************************************************************/

--Cardinality estimate warning - Fixed
SELECT 
	soh.SalesOrderID, OrderDate
from Sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
where orderdate >= '1 jan 2006'





































/**********************************************************************************************************************************/

--Cardinality estimate warning - scenario 2
SELECT 
	soh.SalesOrderID, OrderDate, 'Z'+convert(char(10), soh.SalesOrderID)
from Sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
where orderdate >= '1 jan 2006'















