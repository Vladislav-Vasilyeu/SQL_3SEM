DECLARE @Value INT = 3;

IF @Value < 5
BEGIN
    PRINT 'Значение меньше 5';
    RETURN;  
END

PRINT 'Значение больше или равно 5';
