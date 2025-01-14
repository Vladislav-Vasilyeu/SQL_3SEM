CREATE TABLE #TempTable3 (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Category NVARCHAR(50),
    Amount DECIMAL(10, 2),
    Status NVARCHAR(20)
);



DECLARE @Counter INT = 1;
WHILE @Counter <= 10000
BEGIN
    INSERT INTO #TempTable3 (Category, Amount, Status)
    VALUES (
        CASE WHEN @Counter % 2 = 0 THEN 'CategoryA' ELSE 'CategoryB' END,
        ROUND((RAND() * 1000), 2),
        CASE WHEN @Counter % 3 = 0 THEN 'Active' ELSE 'Inactive' END
    );
    SET @Counter = @Counter + 1;
END;

SELECT Category, Status, AVG(Amount) AS AverageAmount
FROM #TempTable3
WHERE Category = 'CategoryA' AND Status = 'Active'
GROUP BY Category, Status;


CREATE NONCLUSTERED INDEX IX_Filtered_Category_Status
ON #TempTable3 (Category, Status)
INCLUDE (Amount)
WHERE Category = 'CategoryA' AND Status = 'Active';