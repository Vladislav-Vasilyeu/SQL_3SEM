USE Vas_MyBase;

DECLARE @Count INT;

SELECT @Count = COUNT(*) 
FROM ������
WHERE ���_�������� = N'��������';

IF @Count > 0
BEGIN
    PRINT '���� ������ � ����� �������� "��������".';
    SELECT * 
    FROM ������
    WHERE ���_�������� = N'��������';
END
ELSE
BEGIN
    PRINT '��� ������� � ����� �������� "��������".';
    SELECT * 
    FROM ������;
END;
