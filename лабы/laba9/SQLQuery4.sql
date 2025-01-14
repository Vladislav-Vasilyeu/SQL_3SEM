
DECLARE @t FLOAT = 3.0; 
DECLARE @x FLOAT = 2.0; 
DECLARE @z FLOAT;


IF @t > @x
    SET @z = POWER(SIN(@t), 2); 
ELSE IF @t < @x
    SET @z = 4 * (@t + @x); 
ELSE IF @t = @x
    SET @z = 1 - EXP(-POWER(@x, 2)); 


PRINT 'Значение z: ' + CAST(@z AS VARCHAR);





 DECLARE @FullName NVARCHAR(100) = 'Макейчик Татьяна Леонидовна'; 
DECLARE @LastName NVARCHAR(50);  
DECLARE @FirstName NVARCHAR(50); 
DECLARE @MiddleName NVARCHAR(50); 
DECLARE @ShortName NVARCHAR(100); 


SET @LastName = LEFT(@FullName, CHARINDEX(' ', @FullName) - 1);
SET @FirstName = SUBSTRING(@FullName, CHARINDEX(' ', @FullName) + 1, CHARINDEX(' ', SUBSTRING(@FullName, CHARINDEX(' ', @FullName) + 1, LEN(@FullName))) - 1);
SET @MiddleName = RIGHT(@FullName, LEN(@FullName) - CHARINDEX(' ', SUBSTRING(@FullName, CHARINDEX(' ', @FullName) + 1, LEN(@FullName))) - CHARINDEX(' ', @FullName));


SET @ShortName = @LastName + ' ' + LEFT(@FirstName, 1) + '. ' + LEFT(@MiddleName, 1) + '.';


PRINT @ShortName;



DECLARE @CurrentDate DATE = GETDATE();
DECLARE @NextMonth INT = MONTH(@CurrentDate) + 1;
DECLARE @NextYear INT = YEAR(@CurrentDate);

IF @NextMonth = 13
BEGIN
    SET @NextMonth = 1;
    SET @NextYear = @NextYear + 1;
END;

SELECT 
    IDSTUDENT, 
    NAME,
    BDAY,
    DATEDIFF(YEAR, BDAY, @CurrentDate) - 
        CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, BDAY, @CurrentDate), BDAY) > @CurrentDate THEN 1 ELSE 0 END AS Age
FROM STUDENT
WHERE MONTH(BDAY) = @NextMonth;








	DECLARE @GroupID INT = 6; 

SELECT 
    DATENAME(WEEKDAY, P.PDATE) AS ExamDay, 
    P.PDATE
FROM PROGRESS AS P
JOIN STUDENT AS S ON P.IDSTUDENT = S.IDSTUDENT
WHERE 
    S.IDGROUP = @GroupID
    AND P.SUBJECT = 'БД';
