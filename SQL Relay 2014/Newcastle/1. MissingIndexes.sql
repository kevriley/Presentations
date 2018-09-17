use AdventureWorks2008R2
go

/**********************************************************************************************************************************/

-- 1st Query with a missing index
select *  
from Sales.SalesOrderDetail 
where CarrierTrackingNumber = 'F101-4649-85'

--2nd Query with a missing index
select SalesOrderID, UnitPrice
from Sales.SalesOrderDetail 
where UnitPrice > '3000'































/**********************************************************************************************************************************/
--same 2 queries

declare @today date
set @today = getdate()

select *  
from Sales.SalesOrderDetail 
where CarrierTrackingNumber = 'F101-4649-85'

update sales.salesorderdetail set OrderQty = OrderQty where 1=2-1

select SalesOrderID, UnitPrice
from Sales.SalesOrderDetail 
where UnitPrice > '3000'
