-- z161
-- zoomit
-- timer
--******************************************************************************************************************************
-- Example queries for "Tune the query not the plan - Kevan Riley"
--
-- Tested against:
--		AdventureWorks2008R2
--		AdventureWorks2012
--		AdventureWorks2014

--******************************************************************************************************************************
use AdventureWorks2014;
go
set statistics io on;
go
-- turn Actual Excution Plan on (Ctrl-M)

--******************************************************************************************************************************
-- Evil Table Scan?
--******************************************************************************************************************************
-- table scan on heap
select *
from dbo.DatabaseLog;
-- look at logical reads




-- create the clustered index
create clustered index IX_CI_DatabaseLog_DatabaseLogID 
	on dbo.DatabaseLog (DatabaseLogID);





-- clustered index scan
select *
from dbo.DatabaseLog;
-- look at logical reads









--******************************************************************************************************************************
-- Index structure for clustered index on Person.Person
--******************************************************************************************************************************
SELECT OBJECT_NAME(ddips.object_id) AS TableName, i.name, index_level, 
		page_count, record_count, avg_record_size_in_bytes
FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('Person.Person'),1,NULL, 'Detailed') ddips
join sys.indexes i on ddips.object_id = i.object_id and ddips.index_id = i.index_id
where alloc_unit_type_desc = 'IN_ROW_DATA';
--index structure




--look at operator icons for scan and seek 
--Clustered Index Seek
select BusinessEntityID, FirstName, LastName 
from Person.Person
where BusinessEntityID < 10;

--Clustered Index Scan
select BusinessEntityID, FirstName, LastName, Title 
from Person.Person;


SET STATISTICS IO ON;
GO
--******************************************************************************************************************************
--Seek vs Scan - does a scan always read all the table?
--******************************************************************************************************************************
 --obvious scan
select * from Person.Person;

--obvious seek
select * from Person.Person where BusinessEntityID = 917





-- what about this?
-- no predicate so must be scan?
select top (1) * from Person.Person



-- same query?
select top (1) * from Person.Person (nolock)




--same for aggregates on indexed column
select min(BusinessEntityID) from Person.Person
select max(BusinessEntityID) from Person.Person

--scan direction



--******************************************************************************************************************************
--Scan vs Seek - does a seek only read a few rows?
--******************************************************************************************************************************
select * from Person.Person
where BusinessEntityID > 20000




SET STATISTICS IO OFF;
GO
 










--******************************************************************************************************************************
-- Tune the plan?
-- Or confuse the optimizer?
--******************************************************************************************************************************
SET STATISTICS IO ON;
GO

select *
from Production.TransactionHistory
where ModifiedDate > '1 Jan 2014'
-- look at reads and execution plan
 

select *
from Production.TransactionHistory
where ModifiedDate > '1 Jan 2014'
and TransactionID > 0
-- look at reads and execution plan

SET STATISTICS IO OFF;

GO








--******************************************************************************************************************************
-- Ultimate tuning 
-- Optimizer knows best
--******************************************************************************************************************************
set statistics IO on;
go
select *
from Person.Person
where modifiedDate < '1 jan 2006'
-- look at reads and execution plan





-- add a check constraint
if object_id('Person.KevConstraint','C') is not null 
	alter table Person.Person drop constraint KevConstraint;
alter table Person.Person with check
add constraint KevConstraint check (modifiedDate > '1 jan 2006');


--rerun query
select *
from Person.Person
where modifiedDate < '1 jan 2006'

SET STATISTICS IO OFF;
GO










--******************************************************************************************************************************
-- Clean up
--******************************************************************************************************************************
if object_id('Person.KevConstraint','C') is not null alter table Person.Person drop constraint KevConstraint
if exists(select * from sys.indexes where object_id = object_id('dbo.DatabaseLog','U') and name ='IX_CI_DatabaseLog_DatabaseLogID')
    drop index IX_CI_DatabaseLog_DatabaseLogID on dbo.DatabaseLog;

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
