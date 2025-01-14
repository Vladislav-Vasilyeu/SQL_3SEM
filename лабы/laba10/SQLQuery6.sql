CREATE TABLE #TempTable6 (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100),
    Value INT
);

INSERT INTO #TempTable6 (Name, Value)
SELECT TOP (100000) 
    'Name_' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(10)),
    ABS(CHECKSUM(NEWID())) % 1000
FROM sys.objects o1
CROSS JOIN sys.objects o2;

CREATE NONCLUSTERED INDEX IX_TempTable_Value_FF50 
ON #TempTable6 (Value)
WITH (FILLFACTOR = 50);

SELECT name AS [Индекс], avg_fragmentation_in_percent AS [Фрагментация (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('tempdb..#TempTable6'), NULL, NULL, 'DETAILED') AS stats
JOIN sys.indexes AS idx ON stats.object_id = idx.object_id AND stats.index_id = idx.index_id
WHERE idx.name = 'IX_TempTable_Value_FF50';

DECLARE @Counter INT = 0;
WHILE @Counter < 1000
BEGIN
    INSERT INTO #TempTable6 (Name, Value)
    SELECT TOP (1000) 
        'NewName_' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(10)),
        ABS(CHECKSUM(NEWID())) % 1000
    FROM sys.objects o1
    CROSS JOIN sys.objects o2;

    SET @Counter = @Counter + 1;
END

SELECT name AS [Индекс], avg_fragmentation_in_percent AS [Фрагментация (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('tempdb..#TempTable6'), NULL, NULL, 'DETAILED') AS stats
JOIN sys.indexes AS idx ON stats.object_id = idx.object_id AND stats.index_id = idx.index_id
WHERE idx.name = 'IX_TempTable_Value_FF50';

ALTER INDEX IX_TempTable_Value_FF50 
ON #TempTable6 REBUILD WITH (FILLFACTOR = 80);

SELECT name AS [Индекс], avg_fragmentation_in_percent AS [Фрагментация (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('tempdb..#TempTable6'), NULL, NULL, 'DETAILED') AS stats
JOIN sys.indexes AS idx ON stats.object_id = idx.object_id AND stats.index_id = idx.index_id
WHERE idx.name = 'IX_TempTable_Value_FF50';

DROP TABLE #TempTable6;
