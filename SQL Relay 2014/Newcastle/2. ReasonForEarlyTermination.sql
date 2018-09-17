use AdventureWorks2008R2
go

/**********************************************************************************************************************************/

--Trivial, no attribute
select *
from Sales.SalesPerson



































/**********************************************************************************************************************************/

--Good Enough Plan Found
SELECT 
	p.LastName, 
	p.FirstName,
	a.AddressLine1,
	a.City,
	a.PostalCode
FROM 
	Person.Address AS a
JOIN Person.BusinessEntityAddress AS bea ON a.AddressID = bea.AddressID
JOIN Person.Person AS p ON bea.BusinessEntityID = p.BusinessEntityID
WHERE a.AddressID = 252




































/**********************************************************************************************************************************/

--Timeout
SELECT *
FROM HumanResources.vEmployee AS ve
JOIN Sales.vSalesPerson AS vsp 
	ON ve.BusinessEntityID = vsp.BusinessEntityID
JOIN Sales.vSalesPersonSalesByFiscalYears AS vspsbfy 
	ON vspsbfy.SalesPersonID = vsp.BusinessEntityID
