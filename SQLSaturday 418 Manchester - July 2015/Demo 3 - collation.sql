-- ===================================================================================
-- Demo3 - collation
-- ===================================================================================
select databasepropertyex('tempdb','collation');
select databasepropertyex('SQLSAT418','collation');













-- ===================================================================================
-- Demo3 - collation error
-- ===================================================================================
use SQLSAT418;

if object_id('tempdb..#Temp1','U') is not null drop table #Temp1;
create table #Temp1 (AccountNumber varchar(10));

insert #Temp1
select AccountNumber from dbo.Customer where TerritoryID = 10;

select *
from dbo.Customer Customer
join #Temp1 Territory10 
	on Territory10.AccountNumber = Customer.AccountNumber;

go









-- ===================================================================================
-- Demo3 - resolve collation error with explicit collation on table creation
-- ===================================================================================
use SQLSAT418;

if object_id('tempdb..#Temp2','U') is not null drop table #Temp2;
create table #Temp2 (AccountNumber varchar(10) collate SQL_Latin1_General_CP1_CS_AS);

insert #Temp2
select AccountNumber from dbo.Customer where TerritoryID = 10;

select *
from dbo.Customer Customer
join #Temp2 Territory10 
	on Territory10.AccountNumber = Customer.AccountNumber;

go
















-- ===================================================================================
-- Demo3 - resolve collation error with collate database_default option
-- ===================================================================================
use SQLSAT418;

if object_id('tempdb..#Temp3','U') is not null drop table #Temp3;
create table #Temp3 (AccountNumber varchar(10));

insert #Temp3
select AccountNumber from dbo.Customer where TerritoryID = 10;

select *
from dbo.Customer Customer
join #Temp3 Territory10 
	on Territory10.AccountNumber = Customer.AccountNumber 
		collate database_default;
