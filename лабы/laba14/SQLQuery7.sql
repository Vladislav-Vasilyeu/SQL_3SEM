CREATE FUNCTION dbo.������������������()
RETURNS decimal(10,2)
AS
BEGIN
    DECLARE @����������� decimal(10,2);
    SELECT @����������� = AVG(CAST(���� AS decimal(10,2)))
    FROM ������;
    
    RETURN @�����������;
END;
GO

-- ����� �������
DECLARE @����������� decimal(10,2) = dbo.������������������();
PRINT('������� ���� �������: ' + CAST(@����������� AS varchar(10)));
