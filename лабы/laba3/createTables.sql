USE Vas_MyBase
CREATE table �������
(	id_������� int primary key,
	������������_�����_��������� nvarchar(50) unique not null,
	����� nvarchar(50),
	������� int,
	����������_���� nvarchar(50)

) on FG1;
CREATE table ������ 
(	id_������ int primary key,
	�������������_������ nvarchar(50),
	���� int,
	��������_������ nvarchar(50)
) on FG1;
CREATE table ������
(	id_������ int primary key,
	id_������� int foreign key references �������(id_�������),
	id_������ int foreign key references ������(id_������),
	���������� int,
	����_�������� date,
	���_�������� nvarchar(50)
) on FG1;
ALTER Table ������ DROP Column �����_��������;