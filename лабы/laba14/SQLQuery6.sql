CREATE FUNCTION dbo.МиниМаксЦена()
RETURNS @ТоварыТаблица TABLE
(
    Наименоввание_товара nvarchar(50),
    Цена int
)
AS
BEGIN
    INSERT INTO @ТоварыТаблица
    SELECT TOP 1 Наименование_товара, Цена
    FROM ТОВАРЫ
    ORDER BY Цена ASC;

    INSERT INTO @ТоварыТаблица
    SELECT TOP 1 Наименование_товара, Цена
    FROM ТОВАРЫ
    ORDER BY Цена DESC;

    RETURN;
END;
GO

-- Вызов функции
SELECT * FROM dbo.МиниМаксЦена();
