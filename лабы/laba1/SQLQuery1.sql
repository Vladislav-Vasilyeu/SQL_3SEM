SELECT        Наименование_товара
FROM            ЗАКАЗЫ
WHERE        (Дата_поставки > CONVERT(DATETIME, '2024-10-01 00:00:00', 102))