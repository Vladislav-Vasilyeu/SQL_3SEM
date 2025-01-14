DECLARE @FacultyID CHAR(10) = 'ИТ'; 

SELECT 
    S.IDSTUDENT AS СтудентID,
    S.NAME AS ИмяСтудента,
    P.SUBJECT AS Предмет,
    P.NOTE AS Оценка,
    CASE
        WHEN P.NOTE >= 9 THEN 'Отлично'
        WHEN P.NOTE >= 7 THEN 'Хорошо'
        WHEN P.NOTE >= 5 THEN 'Удовлетворительно'
        ELSE 'Неудовлетворительно'
    END AS КатегорияОценки
FROM PROGRESS AS P
JOIN STUDENT AS S ON P.IDSTUDENT = S.IDSTUDENT
JOIN GROUPS AS G ON S.IDGROUP = G.IDGROUP
JOIN FACULTY AS F ON G.FACULTY = F.FACULTY
WHERE F.FACULTY = @FacultyID;
