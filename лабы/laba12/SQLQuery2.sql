USE UNIVER;

BEGIN TRY
	BEGIN TRAN;
	
	-- Создание таблицы
	CREATE TABLE TEST_TABLE
	(
		id INT PRIMARY KEY,
		name VARCHAR(30),
		age INT
	);
	
	-- Заполнение таблицы
	DECLARE @i INT = 0;
	WHILE @i < 100
	BEGIN
		INSERT INTO TEST_TABLE (id, name, age)
		VALUES (@i, CONCAT('student', CAST(@i AS VARCHAR(3))), CAST(RAND() * 100 AS INT));
		SET @i = @i + 1;
	END;
	
	-- Удаление записей
	DELETE FROM TEST_TABLE WHERE age > 70 AND age < 100;
	
	-- Обновление записей
	UPDATE TEST_TABLE SET age = age + 10 WHERE age > 10 AND age < 20;
	
	-- Вставка с возможным дублированием id
	INSERT INTO TEST_TABLE (id, name, age)
	VALUES (3, '2', 3);
	
	-- Завершение транзакции
	COMMIT TRAN;
	PRINT('Транзакция успешно выполнена');

END TRY
BEGIN CATCH
	-- Обработка ошибок
	PRINT 'Ошибка: ' + 
		CASE
			WHEN ERROR_NUMBER() = 2627 AND PATINDEX('%TEST_TABLE%', ERROR_MESSAGE()) > 0
				THEN 'Дублирование id'
			ELSE 'Неизвестная ошибка: ' + CAST(ERROR_NUMBER() AS VARCHAR(5)) + ' ' + ERROR_MESSAGE()
		END;
	
	-- Откат транзакции при наличии активной
	IF @@TRANCOUNT > 0 
	BEGIN
		ROLLBACK TRAN;
		PRINT('Откат транзакции!');
	END;
END CATCH;

-- Проверка существования таблицы и ее удаление
IF (EXISTS (SELECT * 
			FROM SYS.OBJECTS
			WHERE OBJECT_ID = OBJECT_ID(N'dbo.TEST_TABLE') AND TYPE = 'U'))
BEGIN
	PRINT('Таблица TEST_TABLE существует');
	DROP TABLE TEST_TABLE;
END
ELSE
BEGIN
	PRINT('Таблица TEST_TABLE не существует');
END;
