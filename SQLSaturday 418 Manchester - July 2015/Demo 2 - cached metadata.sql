-- ===================================================================================
-- Demo2_1 - permanent table
-- ===================================================================================
use tempdb;

if object_id('Demo2_1','P') is not null drop proc Demo2_1
go
create procedure dbo.Demo2_1
as
begin
    create table KevTemp (col1 int null);
 
    select ObjectID = object_id(N'tempdb..KevTemp');
 
    drop table KevTemp;
end;
go
execute dbo.Demo2_1;
execute dbo.Demo2_1;
execute dbo.Demo2_1;










-- ===================================================================================
-- Demo2_2 - temporary table with explicit DROP
-- ===================================================================================
use tempdb;

if object_id('Demo2_2','P') is not null drop proc Demo2_2 
go
create procedure dbo.Demo2_2
as
begin
    create table #Temp (col1 int null);
 
    select ObjectID = object_id(N'tempdb..#Temp');
 
    drop table #Temp;
end;
go
execute dbo.Demo2_2;
execute dbo.Demo2_2;
execute dbo.Demo2_2;









-- ===================================================================================
-- Demo2_3 - temporary table with no explicit DROP
-- ===================================================================================
use tempdb;

if object_id('Demo2_3','P') is not null drop proc Demo2_3 
go
create procedure dbo.Demo2_3
as
begin
    create table #Temp (col1 int null);
 
    select ObjectID = object_id(N'tempdb..#Temp');
 
    --DROP TABLE #Temp;
end;
go
execute dbo.Demo2_3;
execute dbo.Demo2_3;
execute dbo.Demo2_3;
-- 
--
--
--
--
--
--
--
--
--
--
--
--
--
-- ===================================================================================
-- Demo2_4 - space taken by types of objects in tempdb
-- ===================================================================================
use tempdb;
select  
	sum(user_object_reserved_page_count) * 8 as [User Objects (KB)] ,
	sum(internal_object_reserved_page_count) * 8 as [Internal Objects (KB)] ,
	sum(version_store_reserved_page_count) * 8 as [Version Stores (KB)]
from    sys.dm_db_file_space_usage;







-- ===================================================================================
-- Demo2_5 - space taken by objects per session
--  adapted from http://blogs.msdn.com/b/deepakbi/archive/2010/04/14/monitoring-tempdb-transactions-and-space-usage.aspx
-- ===================================================================================
use tempdb;
select  sys.dm_exec_sessions.session_id as [SESSION ID],
        db_name(dm_db_session_space_usage.database_id) as [DATABASE Name],
        host_name as [System Name],
        program_name as [Program Name],
        login_name as [USER Name],
        status,
        ( user_objects_alloc_page_count * 8 ) as [Space reserved or allocated for User Objects (KB)],
        ( internal_objects_alloc_page_count * 8 ) as [SPACE Allocated FOR Internal Objects (in KB)],
        case is_user_process
          when 1 then 'user session'
          when 0 then 'system session'
        end as [SESSION Type]
from    
	sys.dm_db_session_space_usage
join sys.dm_exec_sessions on sys.dm_db_session_space_usage.session_id = sys.dm_exec_sessions.session_id
order by [SESSION ID] desc;



