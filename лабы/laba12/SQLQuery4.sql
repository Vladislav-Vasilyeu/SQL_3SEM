-- 4 ЗАДАНИЕ --

-- ТРАНЗАКЦИИ А --

-- Неподтвержденное чтение --
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
BEGIN TRANSACTION
SELECT * FROM product WHERE id_product = 1;
WAITFOR DELAY '00:00:04';
SELECT * FROM product WHERE id_product = 1;
COMMIT;

-- Неповторяющееся чтение --
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION
SELECT * FROM product WHERE id_product = 2;
WAITFOR DELAY '00:00:02';
SELECT * FROM product WHERE id_product = 2;
COMMIT;

-- Фантомное чтение --
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
BEGIN TRANSACTION
SELECT * FROM product WHERE id_product = 4;
WAITFOR DELAY '00:00:03';
SELECT * FROM product WHERE id_product = 4;
COMMIT;

-- 5 ЗАДАНИЕ --

-- ТРАНЗАКЦИИ А --

-- Неподтвержденное чтение --
SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
BEGIN TRANSACTION
SELECT * FROM product WHERE id_product = 1;
WAITFOR DELAY '00:00:02';
SELECT * FROM product WHERE id_product = 1;
COMMIT;

-- Неповторяющееся чтение --
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
SELECT * FROM product WHERE id_product = 2;
WAITFOR DELAY '00:00:02';
SELECT * FROM product WHERE id_product = 2;
COMMIT;

-- Фантомное чтение --
SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
BEGIN TRANSACTION
SELECT * FROM product WHERE id_product = 4;
WAITFOR DELAY '00:00:02';
SELECT * FROM product WHERE id_product = 4;
COMMIT;

-- 6 ЗАДАНИЕ --

-- ТРАНЗАКЦИИ А --

-- Неподтвержденное чтение --
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
BEGIN TRANSACTION
SELECT * FROM product WHERE id_product = 1;
WAITFOR DELAY '00:00:02';
SELECT * FROM product WHERE id_product = 1;
COMMIT;

-- Неповторяющееся чтение --
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
BEGIN TRANSACTION
SELECT * FROM product WHERE id_product = 2;
WAITFOR DELAY '00:00:02';
SELECT * FROM product WHERE id_product = 2;
COMMIT;

-- Фантомное чтение --
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
BEGIN TRANSACTION
SELECT * FROM product WHERE id_product = 4;
WAITFOR DELAY '00:00:02';
SELECT * FROM product WHERE id_product = 4;
COMMIT;

-- 7 ЗАДАНИЕ --

-- ТРАНЗАКЦИИ А --

-- Неподтвержденное чтение --
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE 
BEGIN TRANSACTION
SELECT * FROM product WHERE id_product = 1;
WAITFOR DELAY '00:00:02';
SELECT * FROM product WHERE id_product = 1;
COMMIT;

-- Неповторяющееся чтение --
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE 
BEGIN TRANSACTION
SELECT * FROM product WHERE id_product = 2;
WAITFOR DELAY '00:00:02';
SELECT * FROM product WHERE id_product = 2;
COMMIT;

-- Фантомное чтение --
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE 
BEGIN TRANSACTION
SELECT * FROM product WHERE id_product = 4;
WAITFOR DELAY '00:00:02';
SELECT * FROM product WHERE id_product = 4;
COMMIT;

-- 8 ЗАДАНИЕ --

-- Оператор COMMIT вложенной транзакции действует только 
-- на внутренние операции вложенной транзакции; 

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
BEGIN TRANSACTION
INSERT INTO product
	VALUES(4, 'FANTOM', 696969);
SELECT * FROM product WHERE id_product = 4;

	BEGIN TRANSACTION
	UPDATE product SET price = 0 WHERE id_product = 4;
	COMMIT;

	SELECT * FROM product WHERE id_product = 4;
COMMIT;

DELETE FROM product WHERE id_product = 4;

-- Уровень изоляции транзакции наследуется от родительской транзакции

-- Оператор ROLLBACK внешней транзакции отменяет зафиксированные 
-- операции внутренней транзакции; 

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
BEGIN TRANSACTION

INSERT INTO product
	VALUES(4, 'FANTOM', 696969);
SELECT * FROM product WHERE id_product = 4;

	BEGIN TRANSACTION
	UPDATE product SET price = 0 WHERE id_product = 4;
	INSERT INTO product
		VALUES(5, 'FANTOM', 696969);
	COMMIT;

	SELECT * FROM product WHERE id_product = 4;
	SELECT * FROM product WHERE id_product = 5;

ROLLBACK;
SELECT * FROM product WHERE id_product = 4;
SELECT * FROM product WHERE id_product = 5;

-- Оператор ROLLBACK вложенной транзакции 
-- действует на операции внешней и внутренней транзакции, а 
-- также завершает обе транзакции; 

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
BEGIN TRANSACTION
INSERT INTO product
	VALUES(4, 'FANTOM', 696969);
SELECT * FROM product WHERE id_product = 4;

	BEGIN TRANSACTION
		UPDATE product SET price = 0 WHERE id_product = 4;
		INSERT INTO product
			VALUES(5, 'FANTOM', 696969);
		SELECT * FROM product WHERE id_product = 5;
	ROLLBACK;

	SELECT * FROM product WHERE id_product = 4;
	SELECT * FROM product WHERE id_product = 5;
COMMIT;

SELECT * FROM product WHERE id_product = 4;
SELECT * FROM product WHERE id_product = 5;

-- Уровень вложенности транзакции можно определить с помощью 
-- системной функции @@TRANCOUNT. 

BEGIN TRANSACTION

	BEGIN TRANSACTION
		SELECT @@TRANCOUNT;
	COMMIT TRANSACTION;

COMMIT TRANSACTION;