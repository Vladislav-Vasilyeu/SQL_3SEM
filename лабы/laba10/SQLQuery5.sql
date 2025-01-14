CREATE TABLE #TempTable5 (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Value NVARCHAR(100)
);

-- Наполнение таблицы данными
INSERT INTO #TempTable5 (Value)
SELECT TOP (100000) NEWID()
FROM sys.objects o1
CROSS JOIN sys.objects o2;

-- Создание некластеризованного индекса
CREATE NONCLUSTERED INDEX IX_TempTable_Value ON #TempTable5 (Value);

-- Оценка начальной фрагментации
SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
                                    OBJECT_ID('tempdb..#TempTable5'), 
                                    NULL, NULL, 'DETAILED') ss
JOIN sys.indexes ii 
    ON ss.object_id = ii.object_id 
   AND ss.index_id = ii.index_id
WHERE name IS NOT NULL;

-- Генерация фрагментации
DECLARE @Counter INT = 0;

WHILE @Counter < 1000
BEGIN
    DELETE TOP (100) FROM #TempTable5 WHERE ABS(CHECKSUM(NEWID())) % 100 = 0;
    INSERT INTO #TempTable5 (Value) 
    SELECT 'RandomValue' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR)
    FROM sys.objects AS o1
    CROSS JOIN sys.objects AS o2;
    SET @Counter = @Counter + 1;
END

-- Повторная оценка фрагментации
SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
                                    OBJECT_ID('tempdb..#TempTable5'), 
                                    NULL, NULL, 'DETAILED') ss
JOIN sys.indexes ii 
    ON ss.object_id = ii.object_id 
   AND ss.index_id = ii.index_id
WHERE name IS NOT NULL;
