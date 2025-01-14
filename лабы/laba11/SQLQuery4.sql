DECLARE groups CURSOR LOCAL STATIC  
FOR  
SELECT p.PROFESSION_NAME  
FROM dbo.PROFESSION p  
WHERE p.FACULTY = '��'; 

DECLARE @result NVARCHAR(500) = '',  
        @stroke NVARCHAR(60) = '';  

OPEN groups;  

PRINT N'���������� �����: ' + CAST(@@CURSOR_ROWS AS NVARCHAR(5));  

INSERT INTO PROFESSION  
VALUES ('22', N'��', N'� ����������� ������', N'���');  

FETCH NEXT FROM groups INTO @stroke;  

WHILE @@FETCH_STATUS = 0  
BEGIN  
    SET @result = RTRIM(@stroke) + N', ' + @result;  
    FETCH NEXT FROM groups INTO @stroke;  
END;  

PRINT @result;  

DELETE FROM PROFESSION WHERE PROFESSION.PROFESSION_NAME = '22';  

CLOSE groups;  
DEALLOCATE groups;
