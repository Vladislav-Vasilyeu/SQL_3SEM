use UNIVER
declare Teachers cursor global 
					for select t.TEACHER_NAME
						from TEACHER t inner join PULPIT p
							on t.PULPIT = p.PULPIT
								where p.PULPIT like 'ИСиТ';
declare @tname varchar(30) = '';
open Teachers;
fetch Teachers into @tname;
print('1: ' + @tname);
go
declare @tname varchar(30) = ''; 
fetch Teachers into @tname;
print('2: ' + @tname);
close Teachers;
deallocate Teachers;
go