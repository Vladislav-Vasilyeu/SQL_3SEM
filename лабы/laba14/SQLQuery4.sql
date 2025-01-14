CREATE FUNCTION dbo.СуммаЗаказовКлиента (@id_клиента int)
RETURNS int
AS
BEGIN
    DECLARE @Сумма int;
    SELECT @Сумма = SUM(Количество * T.Цена)
    FROM ЗАКАЗЫ Z
    JOIN ТОВАРЫ T ON Z.id_товара = T.id_товара
    WHERE Z.id_клиента = @id_клиента;
    
    RETURN ISNULL(@Сумма, 0);
END;
GO

-- Вызов функции
DECLARE @Сумма int = dbo.СуммаЗаказовКлиента(2);
PRINT('Общая сумма заказов клиента: ' + CAST(@Сумма AS varchar(20)));
