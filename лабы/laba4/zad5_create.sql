use UNIVER
create table A (
	id int primary key,
	value_A nvarchar(50)
)
create table B (
	id int primary key,
	value_B nvarchar(50)
)

insert into A (id, value_A)
	values (1, 'A1'),
			(2, 'A2'),
			(3, 'A3'),
			(5, 'A5'),
			(7, 'A7'),
			(9, 'A9'),
			(10, 'A10');

insert into B(id, value_B)
	values (1, 'A1'),
			(2, 'A2'),
			(5, 'A5'),
			(6, 'A6'),
			(7, 'A7'),
			(11, 'A11'),
			(12, 'A12');