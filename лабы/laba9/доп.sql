DECLARE @a FLOAT = 1.4e-3;
DECLARE @b FLOAT = 5.4;
CREATE TABLE #InputData (
    a FLOAT,
    j FLOAT,
    b FLOAT,
    y FLOAT
);

INSERT INTO #InputData (a, j, b, y)
VALUES 
    (@a, 0.7, @b, 7),
    (@a, 0.7, @b, 7.2),
    (@a, 0.7, @b, 7.4),
    (@a, 0.7, @b, 7.6),
    (@a, 0.7, @b, 7.8),
    (@a, 0.7, @b, 8),
    (@a, -2, @b, 7),
    (@a, -2, @b, 7.2),
    (@a, -2, @b, 7.4),
    (@a, -2, @b, 7.6),
    (@a, -2, @b, 7.8),
    (@a, -2, @b, 8),
    (@a, 2.9, @b, 7),
    (@a, 2.9, @b, 7.2),
    (@a, 2.9, @b, 7.4),
    (@a, 2.9, @b, 7.6),
    (@a, 2.9, @b, 7.8),
    (@a, 2.9, @b, 8);

SELECT * FROM #InputData;


CREATE TABLE #ResultData (
    a FLOAT,
    j FLOAT,
    b FLOAT,
    y FLOAT,
    z FLOAT
);

INSERT INTO #ResultData (a, j, b, y, z)
SELECT 
    a,
    j,
    b,
    y,
    CASE 
        WHEN j > 0 AND (a - 4) >= 0 THEN  
            (3 * y + SQRT(a - 4) * j * ABS(b))
        WHEN j <= 0 AND a > 0 AND POWER(j, 3) > 0 THEN 
            (EXP(-j * 0.1 * y) + LOG(a * POWER(j, 3)))
        ELSE
            NULL  
    END AS z
FROM #InputData;
select * from #ResultData
