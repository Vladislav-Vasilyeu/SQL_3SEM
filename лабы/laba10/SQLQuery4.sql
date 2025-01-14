CREATE TABLE #TempTable (
    ID INT IDENTITY(1,1) PRIMARY KEY, 
    Data NVARCHAR(100)
);


INSERT INTO #TempTable (Data)
SELECT TOP (10000) 
    REPLICATE(CHAR(65 + (ABS(CHECKSUM(NEWID())) % 26)), 50)
FROM sys.all_objects a
CROSS JOIN sys.all_objects b;