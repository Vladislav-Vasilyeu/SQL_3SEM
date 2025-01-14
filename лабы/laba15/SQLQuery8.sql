CREATE TABLE ������_������� (
    id_������� INT IDENTITY PRIMARY KEY,
    id_������ INT,
    �������� NVARCHAR(50),
    ����_�������� DATETIME
);

select * from ������_�������;
select * from �����_�������;
CREATE TRIGGER trg_������������������
ON ������
AFTER INSERT
AS
BEGIN
    DECLARE @id_������ INT;
    SELECT @id_������ = id_������ FROM INSERTED;

    INSERT INTO ������_������� (id_������, ��������, ����_��������)
    VALUES (@id_������, 'INSERT', GETDATE());
END;
GO

-- ������ �������, ������� ������� �������
INSERT into ������(id_������, id_�������, id_������, ����������, ����_��������, ���_��������)
VALUES (100, 100, 1, 5, '2025-01-20', '������');

CREATE TRIGGER trg_���������������������
ON ������
AFTER UPDATE
AS
BEGIN
    DECLARE @id_������ INT, @������_���������� INT, @�����_���������� INT;
    
    SELECT @id_������ = id_������, @������_���������� = ���������� FROM DELETED;
    SELECT @�����_���������� = ���������� FROM INSERTED;
    
    IF @������_���������� <> @�����_����������
    BEGIN
        INSERT INTO ������_������� (id_������, ��������, ����_��������)
        VALUES (@id_������, 'UPDATE', GETDATE());
    END
END;
GO

-- ������ ����������, ������� ������� �������
UPDATE ������
SET ���������� = 10
WHERE id_������ = 1;


CREATE TRIGGER trg_�������������������
ON ������
AFTER DELETE
AS
BEGIN
    DECLARE @id_������ INT;
    SELECT @id_������ = id_������ FROM DELETED;

    INSERT INTO ������_������� (id_������, ��������, ����_��������)
    VALUES (@id_������, 'DELETE', GETDATE());
END;
GO

-- ������ ��������, ������� ������� �������
DELETE FROM ������ WHERE id_������ = 1;


CREATE TRIGGER trg_������������������������������
ON ������
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @���������� INT;
    SELECT @���������� = ���������� FROM INSERTED;
    
    IF @���������� < 0
    BEGIN
        PRINT '���������� �� ����� ���� �������������!';
    END
    ELSE
    BEGIN
        INSERT INTO ������ (id_�������, id_������, ����������, ����_��������, ���_��������)
        SELECT id_�������, id_������, ����������, ����_��������, ���_�������� FROM INSERTED;
    END
END;
GO

-- ������ ������� � ������������� �����������, ������� ������� �������
INSERT INTO ������ (id_�������, id_������, ����������, ����_��������, ���_��������)
VALUES (1, 1, -5, '2025-01-20', '������');

CREATE TABLE �����_������� (
    id_������ INT IDENTITY PRIMARY KEY,
    id_������ INT,
    �������� NVARCHAR(50),
    ������_�������� NVARCHAR(255),
    �����_�������� NVARCHAR(255),
    ����_�������� DATETIME
);
CREATE TRIGGER trg_������������
ON ������
FOR INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @id_������ INT, @������_�������� NVARCHAR(255), @�����_�������� NVARCHAR(255), @�������� NVARCHAR(50);
    
    IF EXISTS (SELECT * FROM INSERTED)
    BEGIN
        SELECT @id_������ = id_������ FROM INSERTED;
        SELECT @�����_�������� = CONCAT(id_�������, ', ', id_������, ', ', ����������, ', ', ����_��������) FROM INSERTED;
        SET @�������� = 'INSERT';
    END
    ELSE IF EXISTS (SELECT * FROM DELETED)
    BEGIN
        SELECT @id_������ = id_������ FROM DELETED;
        SELECT @������_�������� = CONCAT(id_�������, ', ', id_������, ', ', ����������, ', ', ����_��������) FROM DELETED;
        SET @�������� = 'DELETE';
    END
    
    INSERT INTO �����_������� (id_������, ��������, ������_��������, �����_��������, ����_��������)
    VALUES (@id_������, @��������, @������_��������, @�����_��������, GETDATE());
END;
GO
