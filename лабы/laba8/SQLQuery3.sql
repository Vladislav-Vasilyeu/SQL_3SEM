create view [������� ������](�����, ����, ����������)
as select 
		[������������ ������],
		����,
		����������
from �������
where ���� > 5000
go
select * from [������� ������]

insert into [������� ������] values('�����', 3000, 55);



alter view [������� ������](�����, ����, ����������)
as select 
		[������������ ������],
		����,
		����������
from �������
where ���� > 5000 with check option
go
select * from [������� ������]