use UNIVER
SELECT 
    PULPIT.PULPIT_NAME AS �������,
    ISNULL(TEACHER.TEACHER_NAME, '***') AS �������������
FROM 
    PULPIT
LEFT OUTER JOIN 
    TEACHER ON PULPIT.PULPIT = TEACHER.PULPIT
ORDER BY 
    PULPIT.PULPIT_NAME DESC;
