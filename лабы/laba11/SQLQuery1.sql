use UNIVER
DECLARE @SubjectList NVARCHAR(MAX); 
SET @SubjectList = ''; 

DECLARE SubjectCursor CURSOR FOR
SELECT RTRIM(SUBJECT) 
FROM SUBJECT
WHERE PULPIT = 'ศั่า'; 

OPEN SubjectCursor;

DECLARE @CurrentSubject CHAR(10); 
FETCH NEXT FROM SubjectCursor INTO @CurrentSubject;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SubjectList = @SubjectList + @CurrentSubject + ', ';
    FETCH NEXT FROM SubjectCursor INTO @CurrentSubject;
END;
CLOSE SubjectCursor;


DEALLOCATE SubjectCursor;
SET @SubjectList = RTRIM(@SubjectList);
SET @SubjectList = LEFT(@SubjectList, LEN(@SubjectList) - 1);
PRINT @SubjectList;
