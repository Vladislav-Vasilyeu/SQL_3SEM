use Vas_MyBASE
CREATE table �������
(
	id_������� int primary key,
	������������_�����_��������� nvarchar(50),
	����� nvarchar(50) unique,
	������� int,
	����������_���� nvarchar(50)
);
CREATE table ������
(
	id_������ int primary key,
	������������_������ nvarchar(50),
	���� money,
	��������_������ nvarchar(50)
);
CREATE table ������
(
	id_������ int primary key,
	id_������� int foreign key references �������(id_�������),
	id_������ int foreign key references ������(id_������),
	���������� int,
	����_�������� date,
	���_�������� nvarchar(50)
);