use AdventureWorks2008R2
go

/**********************************************************************************************************************************/

-- comparison operators between different columns of the same table
select *
from Sales.SalesOrderHeader
where DueDate > ShipDate
order by OrderDate

















































/**********************************************************************************************************************************/

-- local variable
declare @OrderDate date
set @OrderDate = '1 Jan 2001'

select *
from Sales.SalesOrderHeader
where OrderDate > @OrderDate
order by DueDate