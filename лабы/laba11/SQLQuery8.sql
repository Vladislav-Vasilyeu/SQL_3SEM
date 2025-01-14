DECLARE @idStudent VARCHAR(50) = '',
        @note INT,
        @subject VARCHAR(10) = '',
        @datet DATETIME;

DECLARE test CURSOR LOCAL DYNAMIC
    FOR
        SELECT p.IDSTUDENT, p.NOTE, p.PDATE, p.SUBJECT
        FROM GROUPS g
        INNER JOIN STUDENT s ON g.IDGROUP = s.IDGROUP
        INNER JOIN PROGRESS p ON p.IDSTUDENT = s.IDSTUDENT AND s.IDGROUP = g.IDGROUP
        WHERE p.NOTE < 4 FOR UPDATE;

OPEN test;

FETCH NEXT FROM test INTO @idStudent, @note, @datet, @subject;

PRINT @idStudent + ' ' + CAST(@note AS VARCHAR(2)) + ' ' + CAST(@datet AS VARCHAR(10)) + ' ' + @subject;

WHILE @@FETCH_STATUS = 0
BEGIN
    DELETE FROM PROGRESS WHERE CURRENT OF test;

    PRINT 'Строка удалена: ' + @idStudent + ' ' + CAST(@note AS VARCHAR(2)) + ' ' + CAST(@datet AS VARCHAR(10)) + ' ' + @subject;

    FETCH NEXT FROM test INTO @idStudent, @note, @datet, @subject;
END;

SELECT p.IDSTUDENT, p.NOTE, p.PDATE, p.SUBJECT
FROM GROUPS g
INNER JOIN STUDENT s ON g.IDGROUP = s.IDGROUP
INNER JOIN PROGRESS p ON p.IDSTUDENT = s.IDSTUDENT AND s.IDGROUP = g.IDGROUP
WHERE p.NOTE < 4;

CLOSE test;
DEALLOCATE test;
