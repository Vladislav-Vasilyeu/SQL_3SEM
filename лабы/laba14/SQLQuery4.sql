CREATE FUNCTION dbo.������������������� (@id_������� int)
RETURNS int
AS
BEGIN
    DECLARE @����� int;
    SELECT @����� = SUM(���������� * T.����)
    FROM ������ Z
    JOIN ������ T ON Z.id_������ = T.id_������
    WHERE Z.id_������� = @id_�������;
    
    RETURN ISNULL(@�����, 0);
END;
GO

-- ����� �������
DECLARE @����� int = dbo.�������������������(2);
PRINT('����� ����� ������� �������: ' + CAST(@����� AS varchar(20)));
