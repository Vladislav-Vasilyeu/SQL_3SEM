DECLARE @point VARCHAR(32);
BEGIN TRY
	BEGIN TRAN;
	CREATE TABLE TEST_TABLE
	(
		id INT PRIMARY KEY,
		name VARCHAR(30),
		age INT
	);
	DECLARE @i INT = 0;
	WHILE @i < 100
	BEGIN
		INSERT INTO TEST_TABLE
		VALUES(@i, CONCAT('student', CAST(@i AS VARCHAR(3))), CAST(RAND() * 100 AS INT));
		SET @i = @i + 1;
	END;
	DELETE FROM TEST_TABLE WHERE id = 1;
	SET @point = 'point1'; SAVE TRAN @point;
	UPDATE TEST_TABLE SET age = age - 1 WHERE id = 3;
	SET @point = 'point2'; SAVE TRAN @point;
	INSERT INTO TEST_TABLE 
	VALUES(2, '2', 2);
	SET @point = 'point3'; SAVE TRAN @point;
	COMMIT TRAN;
	PRINT('Фиксация транзакции');
END TRY
BEGIN CATCH
	PRINT 'Ошибка: ' + CASE WHEN ERROR_NUMBER() = 2627 AND PATINDEX('%TEST_TABLE%', ERROR_MESSAGE()) > 0
					THEN 'Дублирование id!'
					ELSE 'Неизвестная ошибка: ' + CAST(ERROR_NUMBER() AS VARCHAR(5)) + ERROR_MESSAGE()
				END;
	IF @@TRANCOUNT > 0
	BEGIN
		PRINT 'Контрольная точка: ' + @point;
		ROLLBACK TRAN @point;
		COMMIT TRAN;
	END;
END CATCH;
IF(EXISTS(SELECT * 
			FROM SYS.OBJECTS
			WHERE OBJECT_ID = OBJECT_ID(N'dbo.TEST_TABLE')))
BEGIN
	PRINT('Таблица TEST_TABLE существует');
	DROP TABLE TEST_TABLE;
END;
ELSE
BEGIN
	PRINT('Таблица TEST_TABLE не существует');
END;

DECLARE @note INT = 4,
	@idstudent INT = 1016,
	@pdate DATE = GETDATE(),
	@subject VARCHAR(30) = 'СУБД';
BEGIN TRAN
INSERT INTO PROGRESS(IDSTUDENT, NOTE, PDATE, SUBJECT)
VALUES(@idstudent, @note, @pdate, @subject);
IF @note > 5
BEGIN
	ROLLBACK;
	PRINT('Откат транзакции!');
END
ELSE 
BEGIN 
	COMMIT;
END;
SELECT * FROM PROGRESS p
WHERE p.IDSTUDENT = @idstudent;
