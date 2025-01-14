BEGIN TRY
    DECLARE @x INT = 10;
    DECLARE @y INT = 0;
    DECLARE @result INT;

    
    SET @result = @x / @y;
END TRY
BEGIN CATCH
    
    PRINT '��������� ������!';
    PRINT '��� ������: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
    PRINT '��������� �� ������: ' + ERROR_MESSAGE();
    PRINT '����� ������ ������: ' + CAST(ERROR_LINE() AS NVARCHAR(10));
    PRINT '���������, � ������� ��������� ������: ' + ISNULL(ERROR_PROCEDURE(), '�� � ���������');
    PRINT '����������� ������: ' + CAST(ERROR_SEVERITY() AS NVARCHAR(10));
    PRINT '����� ������: ' + CAST(ERROR_STATE() AS NVARCHAR(10));
END CATCH;
