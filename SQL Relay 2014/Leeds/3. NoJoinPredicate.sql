use AdventureWorks2008R2
go

/**********************************************************************************************************************************/

--Simple Cartesian product

select top 10
	sod.SalesOrderID,
	sod.SalesOrderDetailID,
	sop.ModifiedDate,
	sod.SpecialOfferID,
	sod.ProductID
from 
	Sales.SalesOrderDetail sod
cross join Sales.SpecialOfferProduct sop 
 






































/**********************************************************************************************************************************/

 -- Old join syntax
 select
	sod.SalesOrderID,
	sod.SalesOrderDetailID,
	sop.ModifiedDate,
	sod.SpecialOfferID,
	sod.ProductID
from 
	Sales.SalesOrderDetail sod, Sales.SpecialOfferProduct sop 
where 
--join predicate
	sop.SpecialOfferID = sod.SpecialOfferID 
	AND sop.ProductID = sod.ProductID




































/**********************************************************************************************************************************/

-- predicate
select
	sod.SalesOrderID,
	sod.SalesOrderDetailID,
	sop.ModifiedDate,
	sod.SpecialOfferID,
	sod.ProductID
from
	Sales.SalesOrderDetail sod
join Sales.SpecialOfferProduct sop 
	on sop.SpecialOfferID = sod.SpecialOfferID 
where 
	sod.SpecialOfferID = 16 





























-- complete predicate
select
	sod.SalesOrderID,
	sod.SalesOrderDetailID,
	sop.ModifiedDate,
	sod.SpecialOfferID,
	sod.ProductID
from
	Sales.SalesOrderDetail sod
join Sales.SpecialOfferProduct sop 
	on sop.SpecialOfferID = sod.SpecialOfferID 
	AND sop.ProductID = sod.ProductID
where 
	sod.SpecialOfferID = 16 





