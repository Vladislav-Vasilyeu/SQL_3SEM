USE Vas_MyBase;

SELECT 
    �������.id_�������,
    �������.������������_�����_���������,
    ROUND(CAST(AVG(������.���� * ������.����������) AS FLOAT), 2) AS [������� ��������� ������]
FROM 
    ������
INNER JOIN 
    ������ ON ������.id_������ = ������.id_������
INNER JOIN 
    ������� ON ������.id_������� = �������.id_�������
WHERE ������.���� > 7000
GROUP BY 
    �������.id_�������, 
    �������.������������_�����_���������;
