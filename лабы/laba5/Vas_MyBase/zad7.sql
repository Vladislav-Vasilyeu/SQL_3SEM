SELECT T.id_товара, T.Наименование_товара, T.Цена
FROM ТОВАРЫ T
WHERE T.Цена > ALL (
    SELECT Цена
    FROM ТОВАРЫ
    WHERE Описание_товара LIKE '%Деревянный%'
);
SELECT T.id_товара, T.Наименование_товара, T.Цена
FROM ТОВАРЫ T
WHERE T.Цена > ANY (
    SELECT Цена
    FROM ТОВАРЫ
    WHERE Описание_товара LIKE '%Деревянный%'
);
