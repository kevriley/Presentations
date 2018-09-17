-- PresentOn
-- zoomit
-- 
--******************************************************************************************************************************
-- Example queries for "Tune the query not the plan - Kevan Riley"
--
-- Tested against:
--		AdventureWorks2008R2
--		AdventureWorks2012
--		AdventureWorks2014
--		AdventureWorks2016
--		AdventureWorks2017



--******************************************************************************************************************************
use AdventureWorks2017;
go
set statistics io on;
go
-- turn Actual Execution Plan on (Ctrl-M)

--******************************************************************************************************************************
-- Evil Table Scan?
--******************************************************************************************************************************
-- table scan on heap
select *
from dbo.DatabaseLog;
-- look at output from statistics io, mainly logical reads and scan count
-- logical reads ~596



-- how do we 'remove' a table scan?
-- create the clustered index
create clustered index IX_CI_DatabaseLog_DatabaseLogID 
	on dbo.DatabaseLog (DatabaseLogID);





-- clustered index scan
select *
from dbo.DatabaseLog;
-- logical reads 




-- recap on index structures




--******************************************************************************************************************************
-- Index structure for clustered index PK_Person_BusinessEntityID on Person.Person
--******************************************************************************************************************************
SELECT OBJECT_NAME(ddips.object_id) AS TableName, i.name, index_level, page_count
FROM 
	sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('Person.Person'),1,NULL, 'Detailed') ddips
join sys.indexes i on ddips.object_id = i.object_id and ddips.index_id = i.index_id
where alloc_unit_type_desc = 'IN_ROW_DATA';
-- this shows index structure 
-- leaf level = 3811
-- intermediate = 8
-- root = 1
-- total = (3811 + 8 + 1) = 3820


--******************************************************************************************************************************
-- Scan vs seek
--******************************************************************************************************************************

--look at operator icons for scan and seek 
-- seeks look light and directed = fast, performance
-- scans look heavy and slower

--Clustered Index Seek
select BusinessEntityID, FirstName, LastName 
from Person.Person
where BusinessEntityID < 10;

--Clustered Index Scan
select BusinessEntityID, FirstName, LastName, Title 
from Person.Person;



--******************************************************************************************************************************
-- Seek vs Scan - does a scan always read all the table?
--******************************************************************************************************************************
 --obvious scan
select * from Person.Person;


--3821 logical reads, that's all the table (plus one extra, likely IAM)

--obvious seek
select * from Person.Person where BusinessEntityID = 917


-- 3 logical reads, 1 per level






-- what about this?
-- no predicate so must be scan?
select top (1) * from Person.Person
-- how many logical reads? 







--same for aggregates on indexed column
select min(BusinessEntityID) from Person.Person
select max(BusinessEntityID) from Person.Person



-- look at the scan direction



--******************************************************************************************************************************
--Scan vs Seek - does a seek only read a few rows?
--******************************************************************************************************************************
select * from Person.Person
where BusinessEntityID > 20000
-- how many logical reads? 













--******************************************************************************************************************************
-- Tune the plan?
-- Or confuse the optimizer?
--******************************************************************************************************************************

select *
from Person.Person
where ModifiedDate > '1 Jan 2014'
-- 5999 rows
-- look at reads and execution plan

-- hmm.... a clustered index scan....
-- 3821 logical reads

-- force a clustered index seek by including a predicate on the indexed column 'BusinessEntityID'
-- but use a condition that is always true, so that it does not filter out any data

select *
from Person.Person
where ModifiedDate > '1 Jan 2014'
and BusinessEntityID > 0
-- look at reads and execution plan
-- added technical debt









--******************************************************************************************************************************
-- Ultimate tuning 
-- Optimizer knows best
--******************************************************************************************************************************

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

