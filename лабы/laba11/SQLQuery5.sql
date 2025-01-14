DECLARE groups CURSOR LOCAL DYNAMIC  
FOR  
SELECT p.PROFESSION_NAME  
FROM dbo.PROFESSION p  
WHERE p.FACULTY = N'ИТ'; 

DECLARE @result NVARCHAR(500) = '',  
        @stroke NVARCHAR(60) = '';  

OPEN groups;  


PRINT N'Количество строк: ' + CAST(@@CURSOR_ROWS AS NVARCHAR(5));  


INSERT INTO PROFESSION  
VALUES ('223', N'ИТ', N'Динамический курсор', N'Лалал');  

FETCH NEXT FROM groups INTO @stroke;  

WHILE @@FETCH_STATUS = 0  
BEGIN  
   
    SET @result = RTRIM(@stroke) + N', ' + @result;  
    FETCH NEXT FROM groups INTO @stroke;  
END;  


PRINT @result;  

CLOSE groups;  
DEALLOCATE groups;  


DELETE FROM PROFESSION WHERE PROFESSION.PROFESSION_NAME = '223';
