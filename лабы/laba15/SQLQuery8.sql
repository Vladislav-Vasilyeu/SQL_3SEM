CREATE TABLE ЖУРНАЛ_ЗАКАЗОВ (
    id_журнала INT IDENTITY PRIMARY KEY,
    id_заказа INT,
    Операция NVARCHAR(50),
    Дата_операции DATETIME
);

select * from ЖУРНАЛ_ЗАКАЗОВ;
select * from АУДИТ_ЗАКАЗОВ;
CREATE TRIGGER trg_ПослеВставкиЗаказа
ON ЗАКАЗЫ
AFTER INSERT
AS
BEGIN
    DECLARE @id_заказа INT;
    SELECT @id_заказа = id_заказа FROM INSERTED;

    INSERT INTO ЖУРНАЛ_ЗАКАЗОВ (id_заказа, Операция, Дата_операции)
    VALUES (@id_заказа, 'INSERT', GETDATE());
END;
GO

-- Пример вставки, который вызовет триггер
INSERT into ЗАКАЗЫ(id_заказа, id_клиента, id_товара, Количество, Дата_поставки, Вид_доставки)
VALUES (100, 100, 1, 5, '2025-01-20', 'Курьер');

CREATE TRIGGER trg_ПослеОбновленияЗаказа
ON ЗАКАЗЫ
AFTER UPDATE
AS
BEGIN
    DECLARE @id_заказа INT, @старое_количество INT, @новое_количество INT;
    
    SELECT @id_заказа = id_заказа, @старое_количество = Количество FROM DELETED;
    SELECT @новое_количество = Количество FROM INSERTED;
    
    IF @старое_количество <> @новое_количество
    BEGIN
        INSERT INTO ЖУРНАЛ_ЗАКАЗОВ (id_заказа, Операция, Дата_операции)
        VALUES (@id_заказа, 'UPDATE', GETDATE());
    END
END;
GO

-- Пример обновления, который вызовет триггер
UPDATE ЗАКАЗЫ
SET Количество = 10
WHERE id_заказа = 1;


CREATE TRIGGER trg_ПослеУдаленияЗаказа
ON ЗАКАЗЫ
AFTER DELETE
AS
BEGIN
    DECLARE @id_заказа INT;
    SELECT @id_заказа = id_заказа FROM DELETED;

    INSERT INTO ЖУРНАЛ_ЗАКАЗОВ (id_заказа, Операция, Дата_операции)
    VALUES (@id_заказа, 'DELETE', GETDATE());
END;
GO

-- Пример удаления, который вызовет триггер
DELETE FROM ЗАКАЗЫ WHERE id_заказа = 1;


CREATE TRIGGER trg_ЗапретОтрицательногоКоличества
ON ЗАКАЗЫ
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @Количество INT;
    SELECT @Количество = Количество FROM INSERTED;
    
    IF @Количество < 0
    BEGIN
        PRINT 'Количество не может быть отрицательным!';
    END
    ELSE
    BEGIN
        INSERT INTO ЗАКАЗЫ (id_клиента, id_товара, Количество, Дата_поставки, Вид_доставки)
        SELECT id_клиента, id_товара, Количество, Дата_поставки, Вид_доставки FROM INSERTED;
    END
END;
GO

-- Пример вставки с отрицательным количеством, который вызовет триггер
INSERT INTO ЗАКАЗЫ (id_клиента, id_товара, Количество, Дата_поставки, Вид_доставки)
VALUES (1, 1, -5, '2025-01-20', 'Курьер');

CREATE TABLE АУДИТ_ЗАКАЗОВ (
    id_аудита INT IDENTITY PRIMARY KEY,
    id_заказа INT,
    Операция NVARCHAR(50),
    Старое_значение NVARCHAR(255),
    Новое_значение NVARCHAR(255),
    Дата_операции DATETIME
);
CREATE TRIGGER trg_АудитЗаказов
ON ЗАКАЗЫ
FOR INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @id_заказа INT, @старое_значение NVARCHAR(255), @новое_значение NVARCHAR(255), @операция NVARCHAR(50);
    
    IF EXISTS (SELECT * FROM INSERTED)
    BEGIN
        SELECT @id_заказа = id_заказа FROM INSERTED;
        SELECT @новое_значение = CONCAT(id_клиента, ', ', id_товара, ', ', Количество, ', ', Дата_поставки) FROM INSERTED;
        SET @операция = 'INSERT';
    END
    ELSE IF EXISTS (SELECT * FROM DELETED)
    BEGIN
        SELECT @id_заказа = id_заказа FROM DELETED;
        SELECT @старое_значение = CONCAT(id_клиента, ', ', id_товара, ', ', Количество, ', ', Дата_поставки) FROM DELETED;
        SET @операция = 'DELETE';
    END
    
    INSERT INTO АУДИТ_ЗАКАЗОВ (id_заказа, Операция, Старое_значение, Новое_значение, Дата_операции)
    VALUES (@id_заказа, @операция, @старое_значение, @новое_значение, GETDATE());
END;
GO
