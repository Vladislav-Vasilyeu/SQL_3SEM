INSERT INTO PROFESSION
    VALUES('22', 'ИТ', 'Я динамический курсор', 'ККК');
INSERT INTO PROFESSION
    VALUES('223', 'ИТ', 'Я динамический курсор 2', 'ККК2');

DECLARE @prof VARCHAR(40) = '',
        @id_prof VARCHAR(5) = '';			

DECLARE test CURSOR LOCAL DYNAMIC
    FOR SELECT p.PROFESSION, p.PROFESSION_NAME
        FROM PROFESSION p 
        WHERE p.PROFESSION LIKE '22' OR p.PROFESSION LIKE '223' FOR UPDATE;

OPEN test;

FETCH test INTO @id_prof, @prof;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT(@id_prof + ' - ' + @prof);

    
    DELETE PROFESSION WHERE CURRENT OF test;

    
    FETCH test INTO @id_prof, @prof;
END;


INSERT INTO PROFESSION
    VALUES('223', 'ИТ', 'Я динамический курсор 2', 'ККК2');

FETCH test INTO @id_prof, @prof;

IF @@FETCH_STATUS = 0
BEGIN
    PRINT(@id_prof + ' - ' + @prof);

    
    UPDATE PROFESSION SET PROFESSION.PROFESSION = '323' WHERE CURRENT OF test;

    SELECT * FROM PROFESSION p WHERE p.PROFESSION LIKE '323';
END
ELSE
    PRINT('Курсор больше не содержит строк.');

CLOSE test;


DELETE PROFESSION WHERE PROFESSION.PROFESSION LIKE '323';
