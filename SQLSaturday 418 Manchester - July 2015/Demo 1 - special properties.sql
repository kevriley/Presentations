-- ===================================================================================
-- Demo1 - tempdb
-- ===================================================================================
use master;
drop database tempdb;


use tempdb;
-- change the recovery model
	alter database tempdb set recovery full;




-- change the owner of tempdb
	use tempdb;
	exec sp_changedbowner 'AnotherUser'; 




-- full backup of tempdb database
backup database tempdb;



--restore
use [master];
restore database tempdb 
from  disk = N'C:\SQLBackups\sandpit.bak' with  file = 1;


-- what about dbcc commands?
use tempdb;
dbcc checkdb;


