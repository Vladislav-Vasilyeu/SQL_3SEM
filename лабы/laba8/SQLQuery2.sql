alter view [Заказанные товары] with schemabinding
as select 
		Наименование_товара,
		Количество, 
		Дата_поставки
from dbo.ТОВАРЫ inner join dbo.ЗАКАЗЫ
	on ТОВАРЫ.id_товара = ЗАКАЗЫ.id_товара


select * from [Заказанные товары] 