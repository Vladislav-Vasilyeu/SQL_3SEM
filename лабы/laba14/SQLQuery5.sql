CREATE FUNCTION dbo.������������� (@id_������� int)
RETURNS TABLE
AS
RETURN
(
    SELECT Z.id_������, T.������������_������, Z.����������, Z.����_��������
    FROM ������ Z
    JOIN ������ T ON Z.id_������ = T.id_������
    WHERE Z.id_������� = @id_�������
);
GO

-- ����� �������
SELECT * FROM dbo.�������������(2);
