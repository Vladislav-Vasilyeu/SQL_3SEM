SET NOCOUNT ON;


IF (EXISTS(SELECT * 
           FROM SYS.objects
           WHERE object_id = OBJECT_ID(N'dbo.temp')))
BEGIN
    DROP TABLE temp;
END;


DECLARE @c INT,
        @flag CHAR(1) = 'r';


SET IMPLICIT_TRANSACTIONS ON;


CREATE TABLE temp (
    name VARCHAR(40)
);


INSERT INTO temp (name)
VALUES ('hahahaah'),
       ('hehehhe'),
       ('hohoho');


SET @c = (SELECT COUNT(*) FROM temp);
PRINT 'Количество строк в таблице temp: ' + CAST(@c AS VARCHAR(3));


IF @flag = 'c'
BEGIN
    COMMIT;
END
ELSE
BEGIN
    ROLLBACK;
END;


SET IMPLICIT_TRANSACTIONS OFF;


IF EXISTS(SELECT * 
          FROM SYS.objects
          WHERE object_id = OBJECT_ID(N'dbo.temp'))
BEGIN
    PRINT('Таблица temp существует');
END
ELSE
BEGIN
    PRINT('Таблица temp не существует');
END;
