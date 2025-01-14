CREATE TABLE #TempTable2 (
    ID INT IDENTITY(1,1) PRIMARY KEY, -- Уникальный идентификатор
    Category NVARCHAR(50),           -- Категория
    Amount DECIMAL(10, 2),           -- Сумма
    CreatedDate DATETIME             -- Дата создания
);
DECLARE @Counter INT = 1;

WHILE @Counter <= 10000
BEGIN
    INSERT INTO #TempTable2 (Category, Amount, CreatedDate)
    VALUES (
        CASE WHEN @Counter % 2 = 0 THEN 'CategoryA' ELSE 'CategoryB' END,
        ROUND((RAND() * 1000), 2), 
        DATEADD(DAY, -(@Counter % 365), GETDATE())
    );
    SET @Counter = @Counter + 1;
END;
SELECT Category, COUNT(*) AS RecordCount, AVG(Amount) AS AverageAmount
FROM #TempTable2
WHERE Amount BETWEEN 100 AND 500
GROUP BY Category;
CREATE NONCLUSTERED INDEX IX_Covering_Category_CreatedDate
ON #TempTable2 (Category, CreatedDate)
INCLUDE (Amount);
