use Vas_MyBase
select ������.�������������_������, ������.����, ������.���_��������, �������.������������_�����_���������
from ������ 
inner join ������ on ������.id_������ = ������.id_������ 
inner join ������� on ������.id_������� = �������.id_�������
and ������.���_�������� like '_���%';


select ������.�������������_������, ������.���_��������, �������.������������_�����_���������,
case 
when (������.���� between 1 and 5000) then '����<5000' 
when (������.���� between 5000 and 10000) then '���� �� 5000 �� 10000' 
else '���� ������ 10000'
end �������_��������
from ������ 
inner join ������ on ������.id_������ = ������.id_������
inner join ������� on �������.id_������� = ������.id_�������
order by ������.�������������_������


select ������.�������������_������, ������.���_��������
from ������ full outer join ������ on ������.id_������ = ������.id_������


select ������.�������������_������, ������.���_��������
from ������ cross join ������ where ������.���_�������� like '%���%'