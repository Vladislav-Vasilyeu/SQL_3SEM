SELECT id_������, ����������, ����_��������
FROM ������
WHERE id_������� IN (
    SELECT id_�������
    FROM �������
    WHERE ����� = '��. ������, 10'
);
SELECT �.id_������, �.����������, �.����_��������
FROM ������ �
INNER JOIN ������ � ON �.id_������=�.id_������
WHERE id_������� IN (SELECT id_������� FROM ������� WHERE ����� LIKE '%������%' )


SELECT �.id_������, �.����������, �.����_��������
FROM ������ �
INNER JOIN ������� � ON �.id_������� = �.id_������� 
INNER JOIN ������ � ON �.id_������ = �.id_������

WHERE �.����� LIKE '%������%'