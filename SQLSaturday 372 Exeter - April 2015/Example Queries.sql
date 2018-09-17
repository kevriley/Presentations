-- Example queries for "Introduction to Execution Plans - Kevan Riley"
--
-- Tested against:
--		AdventureWorks2008R2
--		AdventureWorks2012
--		AdventureWorks2014


use AdventureWorks2012;

--Table Scan
select * from Production.ProductProductPhoto;


--Clustered Index Scan
select * from Sales.Currency;


--Clustered Index Seek
select CustomerID, PersonId from Sales.Customer
where CustomerID < 10;


--Non Clustered Index Scan
select BusinessEntityID, FirstName, LastName 
from Person.Person;


--Non Clustered Index Seek
select BusinessEntityID, FirstName, LastName 
from Person.Person
where LastName = 'Riley';


--RID Lookup
select  DatabaseLogID ,
        DatabaseUser
from dbo.DatabaseLog
where DatabaseLogID = 100;


--Key Lookup
select BusinessEntityID, FirstName, LastName, PersonType
from Person.Person
where LastName = 'Riley';


--Nested Loop Join
select 	
	NationalIDNumber,
	JobTitle
from HumanResources.Employee
join Person.BusinessEntityAddress on Person.BusinessEntityAddress.BusinessEntityID = HumanResources.Employee.BusinessEntityID;


--Merge Join
select *
from Person.Person
join Person.BusinessEntity on Person.BusinessEntity.BusinessEntityID = Person.Person.BusinessEntityID;


--Hash Join
select 
	FirstName,
	LastName
from Person.BusinessEntityAddress 
join Person.Person on Person.Person.BusinessEntityID = Person.BusinessEntityAddress.BusinessEntityID
