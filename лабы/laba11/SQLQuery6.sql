use UNIVER
declare groups cursor local dynamic scroll
				for select row_number() over(order by f.FACULTY_NAME) N, f.FACULTY_NAME
					from FACULTY f
declare @stroke varchar(60) = '',
		@n varchar(2) = '';
open groups;
fetch groups into @n, @stroke;
print(@n + ') ' + @stroke);

fetch next from groups into @n, @stroke;
print(@n + ') ' + @stroke);

fetch prior from groups into @n, @stroke;
print(@n + ') ' + @stroke);

fetch absolute 2 from groups into @n, @stroke;
print(@n + ') ' + @stroke);

fetch absolute -2 from groups into @n, @stroke;
print(@n + ') ' + @stroke);


fetch relative -1 from groups into @n, @stroke;
print(@n + ') ' + @stroke);
close groups;