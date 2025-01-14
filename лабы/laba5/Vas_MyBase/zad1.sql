SELECT id_заказа, Количество, Дата_поставки
FROM ЗАКАЗЫ
WHERE id_клиента IN (
    SELECT id_клиента
    FROM КЛИЕНТЫ
    WHERE Адрес = 'ул. Ленина, 10'
);
SELECT З.id_заказа, З.Количество, З.Дата_поставки
FROM ЗАКАЗЫ З
INNER JOIN ТОВАРЫ Т ON Т.id_товара=З.id_товара
WHERE id_клиента IN (SELECT id_клиента FROM КЛИЕНТЫ WHERE Адрес LIKE '%Ленина%' )


SELECT З.id_заказа, З.Количество, З.Дата_поставки
FROM ЗАКАЗЫ З
INNER JOIN КЛИЕНТЫ К ON З.id_клиента = К.id_клиента 
INNER JOIN ТОВАРЫ Т ON Т.id_товара = З.id_товара

WHERE К.Адрес LIKE '%Ленина%'