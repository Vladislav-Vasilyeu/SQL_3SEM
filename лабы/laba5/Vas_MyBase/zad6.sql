SELECT Z.id_заказа, Z.id_клиента, Z.id_товара, T.Наименование_товара, T.Цена
FROM ЗАКАЗЫ Z
INNER JOIN ТОВАРЫ T ON Z.id_товара = T.id_товара
WHERE T.Цена > (
    SELECT AVG(Цена)
    FROM ТОВАРЫ
);
