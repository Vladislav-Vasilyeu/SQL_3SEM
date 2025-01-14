CREATE FUNCTION dbo.ЗаказыКлиента (@id_клиента int)
RETURNS TABLE
AS
RETURN
(
    SELECT Z.id_заказа, T.Наименование_товара, Z.Количество, Z.Дата_поставки
    FROM ЗАКАЗЫ Z
    JOIN ТОВАРЫ T ON Z.id_товара = T.id_товара
    WHERE Z.id_клиента = @id_клиента
);
GO

-- Вызов функции
SELECT * FROM dbo.ЗаказыКлиента(2);
