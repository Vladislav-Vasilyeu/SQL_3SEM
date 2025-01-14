alter view Дорогие_товары(Товар, Цена, Количество)
as select top 5 [Наименование товара], Цена, Количество
from ТТОВАРЫ	
	order by Цена desc
	
select * from Дорогие_товары