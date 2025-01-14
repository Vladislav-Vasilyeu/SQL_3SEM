CREATE TABLE #TempTable1 (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50),
    Value INT,
    CreatedDate DATETIME
);
DECLARE @Counter INT = 1;

WHILE @Counter <= 10000
BEGIN
    INSERT INTO #TempTable1 (Name, Value, CreatedDate)
    VALUES ('Name' + CAST(@Counter AS NVARCHAR), @Counter % 100, DATEADD(DAY, -(@Counter % 365), GETDATE()));
    SET @Counter = @Counter + 1;
END;
SELECT ID, Name, Value, CreatedDate
FROM #TempTable1
WHERE Value BETWEEN 10 AND 50;
CREATE NONCLUSTERED INDEX IX_TempTable_Value_CreatedDate
ON #TempTable1 (Value, CreatedDate);
