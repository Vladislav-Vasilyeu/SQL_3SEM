declare @y1 int = (select count(id_������) from ������),
		@y2 int = (select sum(����������)  from ������),
		@y3 int = (select count(*) from ������ WHERE MONTH(����_��������) = 9 );
SELECT @y1 as ����������_�������,
		@y2 as ����������_����������_�������,
		@y3 as ����������_�������_�_��������;