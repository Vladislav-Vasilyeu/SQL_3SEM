CREATE FUNCTION dbo.������������()
RETURNS @������������� TABLE
(
    �������������_������ nvarchar(50),
    ���� int
)
AS
BEGIN
    INSERT INTO @�������������
    SELECT TOP 1 ������������_������, ����
    FROM ������
    ORDER BY ���� ASC;

    INSERT INTO @�������������
    SELECT TOP 1 ������������_������, ����
    FROM ������
    ORDER BY ���� DESC;

    RETURN;
END;
GO

-- ����� �������
SELECT * FROM dbo.������������();
