create view [Дорогие товары](Товар, Цена, Количество)
as select 
		[Наименование товара],
		Цена,
		Количество
from ТТОВАРЫ
where Цена > 5000
go
select * from [Дорогие товары]

insert into [Дорогие товары] values('Лампа', 3000, 55);



alter view [Дорогие товары](Товар, Цена, Количество)
as select 
		[Наименование товара],
		Цена,
		Количество
from ТТОВАРЫ
where Цена > 5000 with check option
go
select * from [Дорогие товары]