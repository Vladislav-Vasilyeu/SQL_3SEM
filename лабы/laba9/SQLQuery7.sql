CREATE TABLE #TempTable (
    ID INT,
    Name NVARCHAR(50),
    Value INT
);

DECLARE @Counter INT = 1;

WHILE @Counter <= 10
BEGIN
    INSERT INTO #TempTable (ID, Name, Value)
    VALUES (@Counter, 'Name' + CAST(@Counter AS NVARCHAR(10)), @Counter * 10);

    SET @Counter = @Counter + 1;
END

SELECT * FROM #TempTable;

DROP TABLE #TempTable;
