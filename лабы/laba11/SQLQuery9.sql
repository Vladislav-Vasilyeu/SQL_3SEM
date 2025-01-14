DECLARE @idStudent VARCHAR(50) = '',
        @note INT,
        @subject VARCHAR(10) = '',
        @datet DATETIME;

DECLARE test2 CURSOR LOCAL DYNAMIC 
    FOR 
        SELECT p.IDSTUDENT, p.NOTE, p.PDATE, p.SUBJECT
        FROM PROGRESS p
        WHERE p.IDSTUDENT = 1005 FOR UPDATE;

OPEN test2;
FETCH NEXT FROM test2 INTO @idStudent, @note, @datet, @subject;
PRINT @idStudent + ' ' + CAST(@note AS VARCHAR(2)) + ' ' + CAST(@datet AS VARCHAR(10)) + ' ' + @subject;

UPDATE PROGRESS SET PROGRESS.NOTE = PROGRESS.NOTE + 1 WHERE CURRENT OF test2;

SELECT p.IDSTUDENT, p.NOTE, p.PDATE, p.SUBJECT
FROM PROGRESS p
WHERE p.IDSTUDENT = 1005;

CLOSE test2;
DEALLOCATE test2;

DECLARE Auditorium CURSOR 
    FOR 
        SELECT a.AUDITORIUM_CAPACITY, a.AUDITORIUM_NAME
        FROM AUDITORIUM a
        WHERE a.AUDITORIUM_NAME LIKE '301-1';

DECLARE @data_single VARCHAR(10) = '',
        @result_string VARCHAR(500) = ''; 

OPEN Auditorium;
FETCH NEXT FROM Auditorium INTO @data_single, @result_string;
PRINT 'Вместимость аудитории 301-1 - ' + @data_single;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @result_string = @data_single;
    PRINT @result_string;
    FETCH NEXT FROM Auditorium INTO @data_single, @result_string;
END;

CLOSE Auditorium;
DEALLOCATE Auditorium;
