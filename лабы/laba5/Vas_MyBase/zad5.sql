SELECT К.Наименование_фирмы_заказчика, К.Контактное_лицо
FROM КЛИЕНТЫ К
WHERE  EXISTS (
    SELECT 1
    FROM ЗАКАЗЫ З
    WHERE З.id_клиента = К.id_клиента
);
