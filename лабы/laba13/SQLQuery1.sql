------ Создание процедуры PSUBJECT --------

----- 1 Процедура ------

use UNIVER;

go

create procedure PSUBJECT
as
begin
    declare GetStr cursor local static 
        for select s.SUBJECT, s.SUBJECT_NAME, s.PULPIT from SUBJECT s;
    declare @countStr int = (select count(*) from SUBJECT),
            @code varchar(10) = '',
            @nameSubj varchar(100) = '',
            @namePulpit varchar(50) = '',
            @N int = 1;
    print('N' + space(3) + 'Код' + space(7) + 'Название' + space(46) + 'Кафедра');
    open GetStr;
    fetch GetStr into @code, @nameSubj, @namePulpit;
    while(@@FETCH_STATUS = 0)
    begin
        print(cast(@N as varchar(3)) + space(4 - len(cast(@N as varchar(3)))) + trim(@code) + space(11 - len(trim(@code))) + trim(@nameSubj) + 
        space(56 - len(trim(@nameSubj))) + trim(@namePulpit));
        fetch GetStr into @code, @nameSubj, @namePulpit;
        set @N = @N + 1;
    end;
    close GetStr;
    return @countStr;
end;

declare @ret int = 0;

exec @ret = PSUBJECT;
print('Количество записей: ' + cast(@ret as varchar(3)));

drop procedure PSUBJECT;

----- 2 Процедура ------

alter procedure PSUBJECT @p varchar(20) = null, @c int output
as
begin
    print('Параметры: @p = ' + @p + ' @c = ' + cast(@c as varchar(3)));
    declare GetStr cursor local static 
        for select s.SUBJECT, s.SUBJECT_NAME, s.PULPIT from SUBJECT s;
    declare @countStr int = (select count(*) from SUBJECT s),
            @code varchar(10) = '',
            @nameSubj varchar(100) = '',
            @namePulpit varchar(50) = '',
            @N int = 1;
    print('N' + space(3) + 'Код' + space(7) + 'Название' + space(46) + 'Кафедра');
    open GetStr;
    fetch GetStr into @code, @nameSubj, @namePulpit;
    while(@@FETCH_STATUS = 0)
    begin
        if(@p = @namePulpit)
        begin
            print(cast(@N as varchar(3)) + space(4 - len(cast(@N as varchar(3)))) + trim(@code) + space(11 - len(trim(@code))) + trim(@nameSubj) + 
            space(56 - len(trim(@nameSubj))) + trim(@namePulpit));
            set @c = @c + 1;
            set @N = @N + 1;
        end;
        fetch GetStr into @code, @nameSubj, @namePulpit;
    end;
    close GetStr;
    return @countStr;
end;

declare @ret int = 0,
        @k int = 0,
        @p varchar(20) = 'Кафедра';
exec @ret = PSUBJECT @p = 'Кафедра', @c = @k output
print('Количество найденных записей: ' + cast(@ret as varchar(3)));
print('Количество найденных записей по кафедре ' + @p + ' : ' + cast(@k as varchar(3)));

---- 3 Процедура ----

create table #SUBJECT
(
    code_S char(10) primary key,
    name_S varchar(100),
    name_P char(20)
)

alter procedure PSUBJECT @p varchar(20) = null
as
begin
    print('Параметры: @p = ' + @p);
    declare @count int = (select count(*) from SUBJECT),
            @count2 int = (select count(*) from SUBJECT s where s.PULPIT = @p);
    print('Всего ' + cast(@count as varchar(3)) + ' записей, из них ' + cast(@count2 as varchar(3)) + ' по кафедре.');
    select * from SUBJECT s where s.PULPIT = @p;
end;

insert #SUBJECT exec PSUBJECT @p = 'Кафедра';

select * from #SUBJECT;

---- 4 Процедура ----

create procedure PAUDITORIUM_INSERT @a char(20), @n varchar(50), @c int = 0, @t char(10)
as
begin
    begin try
        insert into AUDITORIUM
                    values(@a, @n, @c, @t);
        return 1;
    end try

    begin catch
        print('Ошибка номер: ' + cast(error_number() as varchar(6)));
        print('Сообщение: ' + error_message());
        print('Уровень: ' + cast(error_severity() as varchar(6)));
        print('Состояние: ' + cast(error_state() as varchar(8)));
        print('Ошибка в строке: ' + cast(error_line() as varchar(8)));
        if(error_procedure() is not null)
        begin
            print('В процедуре: ' + error_procedure());
        end;
        return -1;
    end catch
end;    

declare @inProc int;

exec @inProc = PAUDITORIUM_INSERT @a = '1223-1', @n = 'Аудитория', @c = 40, @t = 'AUD';
print('Результат вставки: ' + cast(@inProc as varchar(3)));
exec @inProc = PAUDITORIUM_INSERT @a = '1443-1', @n = 'Аудитория 2', @c = 99, @t = 'ttt';
print('Результат вставки: ' + cast(@inProc as varchar(3)));
exec @inProc = PAUDITORIUM_INSERT @a = '1-1', @n = 'Аудитория 3', @c = 100, @t = 'AUD2';
print('Результат вставки: ' + cast(@inProc as varchar(3)));
exec @inProc = PAUDITORIUM_INSERT @a = '999-1', @n = 'Аудитория 4', @c = 400, @t = 'AUD3';
print('Результат вставки: ' + cast(@inProc as varchar(3)));

select * from AUDITORIUM;

delete from AUDITORIUM where AUDITORIUM like '1223-1'; 
delete from AUDITORIUM where AUDITORIUM like '1-1'; 

---- 5 Процедура ----

create procedure SUBJECT_REPORT @p char(10)
as
begin
    begin try
        declare subj cursor local static 
                for select s.SUBJECT from SUBJECT s where s.PULPIT = @p;
        declare @count int = (select count(*) from SUBJECT s where s.PULPIT like @p),
                @resStr varchar(300) = '',
                @locSubj varchar(50) = '',
                @locCount int = 0;
        if(@count = 0)
        begin
            raiserror('Нет записей по заданным параметрам!', 11, 1)
        end;
        open subj;
        fetch subj into @locSubj;
        while(@@FETCH_STATUS = 0)
        begin
            set @resStr = concat(trim(@locSubj), ', ', @resStr);
            fetch subj into @locSubj;
            set @locCount = @locCount + 1;  
        end;
        close subj;
        print('Результаты по кафедре: ' + @p);
        print(space(3) + @resStr);
        return @count;
    end try

    begin catch
        print 'Ошибка в процессе выполнения!';
        if ERROR_PROCEDURE() is not null
        begin
            print 'В процедуре: ' + error_procedure();
        end;
        return @locCount;
    end catch
end;

declare @result int = 0;

exec @result = SUBJECT_REPORT @p = 'Кафедра';
print('Количество записей: ' + cast(@result as varchar(3)));

exec @result = SUBJECT_REPORT @p = 'fail';
print('Количество записей: ' + cast(@result as varchar(3)));

drop procedure SUBJECT_REPORT;

---- 6 Процедура ----

create procedure PAUDITORIUM_INSERTX @a char(20), @n varchar(50), @c int = 0, @t char(10), @tn varchar(50)
as
begin try
    declare @rc int = 1;
    set transaction isolation level serializable
    begin tran
        insert into AUDITORIUM_TYPE
                    values(@t, @tn);
        exec @rc = PAUDITORIUM_INSERT @a = @a, @n = @n, @c = @c, @t = @t
    commit tran;
    return @rc;
end try
begin catch
    print('Ошибка номер: ' + cast(error_number() as varchar(6)));
    print('Сообщение: ' + error_message());
    print('Уровень: ' + cast(error_severity() as varchar(6)));
    print('Состояние: ' + cast(error_state() as varchar(8)));
    print('Ошибка в строке: ' + cast(error_line() as varchar(8)));
    if(error_procedure() is not null)
    begin
        print('В процедуре: ' + error_procedure());
    end;
    if @@TRANCOUNT > 0 rollback tran;
    return -1;
end catch

declare @rc int;
exec @rc = PAUDITORIUM_INSERTX @a = '1223-1', @n = 'AUD66', @c = 40, @t = 'AUD66', @tn = 'новый тип';
print('Результат вставки: ' + cast(@rc as varchar(3)));
exec @rc = PAUDITORIUM_INSERTX @a = '1223-1', @n = 'Аудитория', @c = 40, @t = 'AUD662', @tn = 'новый тип 2';
print('Результат вставки: ' + cast(@rc as varchar(3)));

select * from AUDITORIUM;
select * from AUDITORIUM_TYPE;

delete from AUDITORIUM where AUDITORIUM like '1223-1'; 
delete from AUDITORIUM_TYPE where AUDITORIUM_TYPE like 'AUD66'; 
delete from AUDITORIUM_TYPE where AUDITORIUM_TYPE like 'AUD662';