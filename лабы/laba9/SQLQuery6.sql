DECLARE @FacultyID CHAR(10) = '��'; 

SELECT 
    S.IDSTUDENT AS �������ID,
    S.NAME AS �����������,
    P.SUBJECT AS �������,
    P.NOTE AS ������,
    CASE
        WHEN P.NOTE >= 9 THEN '�������'
        WHEN P.NOTE >= 7 THEN '������'
        WHEN P.NOTE >= 5 THEN '�����������������'
        ELSE '�������������������'
    END AS ���������������
FROM PROGRESS AS P
JOIN STUDENT AS S ON P.IDSTUDENT = S.IDSTUDENT
JOIN GROUPS AS G ON S.IDGROUP = G.IDGROUP
JOIN FACULTY AS F ON G.FACULTY = F.FACULTY
WHERE F.FACULTY = @FacultyID;
