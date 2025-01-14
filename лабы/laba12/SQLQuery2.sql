USE UNIVER;

BEGIN TRY
	BEGIN TRAN;
	
	-- �������� �������
	CREATE TABLE TEST_TABLE
	(
		id INT PRIMARY KEY,
		name VARCHAR(30),
		age INT
	);
	
	-- ���������� �������
	DECLARE @i INT = 0;
	WHILE @i < 100
	BEGIN
		INSERT INTO TEST_TABLE (id, name, age)
		VALUES (@i, CONCAT('student', CAST(@i AS VARCHAR(3))), CAST(RAND() * 100 AS INT));
		SET @i = @i + 1;
	END;
	
	-- �������� �������
	DELETE FROM TEST_TABLE WHERE age > 70 AND age < 100;
	
	-- ���������� �������
	UPDATE TEST_TABLE SET age = age + 10 WHERE age > 10 AND age < 20;
	
	-- ������� � ��������� ������������� id
	INSERT INTO TEST_TABLE (id, name, age)
	VALUES (3, '2', 3);
	
	-- ���������� ����������
	COMMIT TRAN;
	PRINT('���������� ������� ���������');

END TRY
BEGIN CATCH
	-- ��������� ������
	PRINT '������: ' + 
		CASE
			WHEN ERROR_NUMBER() = 2627 AND PATINDEX('%TEST_TABLE%', ERROR_MESSAGE()) > 0
				THEN '������������ id'
			ELSE '����������� ������: ' + CAST(ERROR_NUMBER() AS VARCHAR(5)) + ' ' + ERROR_MESSAGE()
		END;
	
	-- ����� ���������� ��� ������� ��������
	IF @@TRANCOUNT > 0 
	BEGIN
		ROLLBACK TRAN;
		PRINT('����� ����������!');
	END;
END CATCH;

-- �������� ������������� ������� � �� ��������
IF (EXISTS (SELECT * 
			FROM SYS.OBJECTS
			WHERE OBJECT_ID = OBJECT_ID(N'dbo.TEST_TABLE') AND TYPE = 'U'))
BEGIN
	PRINT('������� TEST_TABLE ����������');
	DROP TABLE TEST_TABLE;
END
ELSE
BEGIN
	PRINT('������� TEST_TABLE �� ����������');
END;
