SELECT Z.id_������, Z.id_�������, Z.id_������, T.������������_������, T.����
FROM ������ Z
INNER JOIN ������ T ON Z.id_������ = T.id_������
WHERE T.���� > (
    SELECT AVG(����)
    FROM ������
);
