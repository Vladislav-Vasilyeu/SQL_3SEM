SELECT T.id_������, T.������������_������, T.����
FROM ������ T
WHERE T.���� > ALL (
    SELECT ����
    FROM ������
    WHERE ��������_������ LIKE '%����������%'
);
SELECT T.id_������, T.������������_������, T.����
FROM ������ T
WHERE T.���� > ANY (
    SELECT ����
    FROM ������
    WHERE ��������_������ LIKE '%����������%'
);
