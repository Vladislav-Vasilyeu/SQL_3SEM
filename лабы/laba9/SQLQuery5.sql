USE Vas_MyBase;

DECLARE @Count INT;

SELECT @Count = COUNT(*) 
FROM ЗАКАЗЫ
WHERE Вид_доставки = N'Экспресс';

IF @Count > 0
BEGIN
    PRINT 'Есть заказы с видом доставки "Экспресс".';
    SELECT * 
    FROM ЗАКАЗЫ
    WHERE Вид_доставки = N'Экспресс';
END
ELSE
BEGIN
    PRINT 'Нет заказов с видом доставки "Экспресс".';
    SELECT * 
    FROM ЗАКАЗЫ;
END;
