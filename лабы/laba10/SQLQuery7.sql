CREATE NONCLUSTERED INDEX IX_Клиенты_Наименование_фирмы_заказчика
ON КЛИЕНТЫ (Наименование_фирмы_заказчика);

CREATE NONCLUSTERED INDEX IX_Клиенты_Телефон
ON КЛИЕНТЫ (Телефон);

CREATE NONCLUSTERED INDEX IX_Товары_Наименование_товара
ON ТОВАРЫ (Наименование_товара);

CREATE NONCLUSTERED INDEX IX_Товары_Цена
ON ТОВАРЫ (Цена);

CREATE NONCLUSTERED INDEX IX_Заказы_id_клиента
ON ЗАКАЗЫ (id_клиента);

CREATE NONCLUSTERED INDEX IX_Заказы_Дата_поставки
ON ЗАКАЗЫ (Дата_поставки);

CREATE NONCLUSTERED INDEX IX_Заказы_Вид_доставки
ON ЗАКАЗЫ (Вид_доставки);

SELECT * 
FROM КЛИЕНТЫ
WHERE Наименование_фирмы_заказчика = 'Компания ABC';

SELECT * 
FROM ЗАКАЗЫ
WHERE id_клиента = 1;

SELECT * 
FROM ТОВАРЫ
WHERE Цена > 1000;
