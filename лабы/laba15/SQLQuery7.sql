use UNIVER;

create table TR_AUDIT
(
	ID int identity, -- номер записи
	STMT varchar(20) check (STMT in ('INS', 'DEL', 'UPD')), -- DML оператор
	TRNAME varchar(50), -- имя триггера
	CC varchar(300) -- комментарий
);
create table STUDENTT
(
    STUDENT_ID int primary key,
    STUDENT_NAME varchar(100) not null -- Ограничение NOT NULL
);

create table AUDIT_LOG
(
    LOG_ID int identity primary key,
    EVENT_TYPE varchar(50),
    EVENT_DESC varchar(300),
    EVENT_DATE datetime default getdate()
);


create trigger TR_TEACHERS_INS on TEACHER after INSERT
as
begin
	declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
	set @a1 = (select [TEACHER] from inserted);
	set @a2 = (select [TEACHER_NAME] from inserted);
	set @a3 = (select [GENDER] from inserted);
	set @a4 = (select [PULPIT] from inserted);
	set @in = concat(trim(@a1), ' ', @a2, ' ', @a3, ' ', @a4);
	print 'Вставка значения в таблицу TEACHER: ' + @in;
	insert into TR_AUDIT(STMT, TRNAME, CC) values('INS', 'TR_TEACHERS_INS', @in);
end;
insert into TEACHER(GENDER, PULPIT, TEACHER, TEACHER_NAME)
values('м', 'ИСиТ', 'ТНС', 'Степаненко Арина Владимировна');

select * from TR_AUDIT;


create trigger TR_TEACHERS_DEL on TEACHER after DELETE
as
begin
	declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
	set @a1 = (select [TEACHER] from deleted);
	set @a2 = (select [TEACHER_NAME] from deleted);
	set @a3 = (select [GENDER] from deleted);
	set @a4 = (select [PULPIT] from deleted);
	set @in = concat(trim(@a1), ' ', @a2, ' ', @a3, ' ', @a4);
	print 'Удаление значения из таблицы TEACHER: ' + @in;
	insert into TR_AUDIT(STMT, TRNAME, CC) values('DEL', 'TR_TEACHERS_DEL', @in);
end;

create trigger TR_TEACHERS_UPD on TEACHER after UPDATE
as
begin
	declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
	set @a1 = (select [TEACHER] from deleted);
	set @a2 = (select [TEACHER_NAME] from deleted);
	set @a3 = (select [GENDER] from deleted);
	set @a4 = (select [PULPIT] from deleted);
	set @in = concat(trim(@a1), ' ', @a2, ' ', @a3, ' ', @a4);
	print 'Обновление значения в таблице TEACHER: ' + @in;
	insert into TR_AUDIT(STMT, TRNAME, CC) values('DEL', 'TR_TEACHERS_UPD', @in);
end;

create trigger TR_TEACHER 
on TEACHER 
after INSERT, DELETE, UPDATE
as
begin
    declare @stmt varchar(20);
    declare @comment varchar(300);

    -- Определение типа события
    if exists (select * from inserted) and exists (select * from deleted)
    begin
        set @stmt = 'UPD';
        set @comment = 'Обновление данных в таблице TEACHER.';
    end
    else if exists (select * from inserted)
    begin
        set @stmt = 'INS';
        set @comment = 'Добавление новой записи в таблицу TEACHER.';
    end
    else if exists (select * from deleted)
    begin
        set @stmt = 'DEL';
        set @comment = 'Удаление записи из таблицы TEACHER.';
    end

    -- Запись события в таблицу TR_AUDIT
    insert into TR_AUDIT (STMT, TRNAME, CC)
    values (@stmt, 'TR_TEACHER', @comment);
end
go

insert into TEACHER (GENDER, PULPIT, TEACHER, TEACHER_NAME)
values ('м', 'ИСиТ', 'TNS5', 'Иванов Иван');


update TEACHER
set TEACHER_NAME = 'Петров Петр'
where TEACHER = 'TNS5';


delete from TEACHER where TEACHER = 'TNS5';


create trigger TR_STUDENT_INSERT
on STUDENT
after insert
as
begin
    insert into AUDIT_LOG (EVENT_TYPE, EVENT_DESC)
    values ('INSERT', 'Добавлена запись в таблицу STUDENT.');
end
go

insert into STUDENTT (STUDENT_ID, STUDENT_NAME)
values (1, NULL);

insert into STUDENTT(STUDENT_ID, STUDENT_NAME)
values (2, 'Иван Иванов');



CREATE TRIGGER TR_TEACHER_DEL1
ON TEACHER
AFTER DELETE
AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    VALUES ('DEL', 'TR_TEACHER_DEL1', 'Удаление записи из TEACHER');
END;


CREATE TRIGGER TR_TEACHER_DEL2
ON TEACHER
AFTER DELETE
AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    VALUES ('DEL', 'TR_TEACHER_DEL2', 'Удаление записи из TEACHER');
END;


CREATE TRIGGER TR_TEACHER_DEL3
ON TEACHER
AFTER DELETE
AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    VALUES ('DEL', 'TR_TEACHER_DEL3', 'Удаление записи из TEACHER');
END;


EXEC sp_settriggerorder 
    @triggername = 'TR_TEACHER_DEL3', 
    @order = 'FIRST', 
    @stmttype = 'DELETE';

EXEC sp_settriggerorder 
    @triggername = 'TR_TEACHER_DEL2', 
    @order = 'LAST', 
    @stmttype = 'DELETE';

SELECT 
    tr.name AS TriggerName, 
    tr.type_desc, 
    te.type_desc AS EventType
FROM sys.triggers tr
JOIN sys.trigger_events te ON tr.object_id = te.object_id
WHERE tr.parent_id = OBJECT_ID('TEACHER');


CREATE TRIGGER TR_TEACHER_AFTER_DELETE
ON TEACHER
AFTER DELETE
AS
BEGIN
    DECLARE @TEACHER_NAME VARCHAR(100);
    
    -- Получаем имя преподавателя, которого удалили
    SELECT @TEACHER_NAME = TEACHER_NAME FROM DELETED;
    
    -- Записываем информацию о удалении в AUDIT_LOG
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    VALUES ('DELETE', 'Teacher ' + @TEACHER_NAME + ' was deleted.', GETDATE());
END;


BEGIN TRANSACTION;
DELETE FROM TEACHER WHERE TEACHER = 'T123';
SELECT * FROM AUDIT_LOG;
ROLLBACK TRANSACTION;
SELECT * FROM AUDIT_LOG;



CREATE TRIGGER TR_FACULTY_INSTEAD_OF_DELETE
ON FACULTY
INSTEAD OF DELETE
AS
BEGIN
    PRINT 'Delete operation is not allowed on FACULTY table.';
END;


INSERT INTO FACULTY (FACULTY, FACULTY_NAME)
VALUES ('F001', 'Mathematics');
DELETE FROM FACULTY WHERE FACULTY = 'F001';
SELECT * FROM FACULTY WHERE FACULTY = 'F001';

CREATE TRIGGER DDL_BLOCK_CREATE_DROP
ON DATABASE
FOR CREATE_TABLE, DROP_TABLE
AS
BEGIN
    -- Извлечение данных о типе события, имени объекта и типе объекта
    DECLARE @eventType NVARCHAR(50);
    DECLARE @objectName NVARCHAR(50);
    DECLARE @objectType NVARCHAR(50);

    -- Извлечение значений с использованием EVENTDATA и преобразования типов
    SET @eventType = (SELECT CAST(EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(50)') AS NVARCHAR(50)));
    SET @objectName = (SELECT CAST(EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(50)') AS NVARCHAR(50)));
    SET @objectType = (SELECT CAST(EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'NVARCHAR(50)') AS NVARCHAR(50)));

    -- Печать информации о событии
    PRINT 'Тип события: ' + @eventType;
    PRINT 'Имя объекта: ' + @objectName;
    PRINT 'Тип объекта: ' + @objectType;

    -- Запрещаем создание или удаление таблиц
    IF @eventType IN ('CREATE_TABLE', 'DROP_TABLE')
    BEGIN
        -- Если попытка создать или удалить таблицу, выводим сообщение об ошибке
        RAISERROR(N'Операции по созданию или удалению таблиц запрещены в базе данных UNIVER.', 16, 1);
        
        -- Откатываем транзакцию, блокируя выполнение операции
        ROLLBACK;
    END
END;

CREATE TABLE TestTable (
    ID INT PRIMARY KEY,
    Name VARCHAR(50)
);

DROP TABLE TestTable;