SELECT �.������������_�����_���������, �.����������_����
FROM ������� �
WHERE  EXISTS (
    SELECT 1
    FROM ������ �
    WHERE �.id_������� = �.id_�������
);
