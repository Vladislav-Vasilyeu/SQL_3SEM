BEGIN TRY
    DECLARE @x INT = 10;
    DECLARE @y INT = 0;
    DECLARE @result INT;

    
    SET @result = @x / @y;
END TRY
BEGIN CATCH
    
    PRINT 'Произошла ошибка!';
    PRINT 'Код ошибки: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
    PRINT 'Сообщение об ошибке: ' + ERROR_MESSAGE();
    PRINT 'Номер строки ошибки: ' + CAST(ERROR_LINE() AS NVARCHAR(10));
    PRINT 'Процедура, в которой произошла ошибка: ' + ISNULL(ERROR_PROCEDURE(), 'Не в процедуре');
    PRINT 'Серьезность ошибки: ' + CAST(ERROR_SEVERITY() AS NVARCHAR(10));
    PRINT 'Метка ошибки: ' + CAST(ERROR_STATE() AS NVARCHAR(10));
END CATCH;
