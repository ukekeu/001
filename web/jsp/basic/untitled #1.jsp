CREATE    proc excel_to_customer
   @section      varchar(100),
   @filename      varchar(500),
   @pathstr varchar(100)
  --with encryption   
as
   set nocount on
SET ANSI_NULLS on
SET ANSI_WARNINGS on 
declare @sql varchar(1000)
declare @strSQL  varchar(8000) 

 set @sql=' openrowset(''MICROSOFT.JET.OLEDB.4.0'',''Excel 5.0;HDR=NO;DATABASE=d:\'+@pathstr+'\crmv9\jsp\picture\'+@filename+''',sheet1$)'
 exec ('SELECT * into  temp  from '+@sql )
   
 SET ANSI_NULLS   off
 SET ANSI_WARNINGS off
GO
