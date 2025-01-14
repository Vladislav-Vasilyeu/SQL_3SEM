declare @y1 int = (select count(id_заказа) from ЗАКАЗЫ),
		@y2 int = (select sum(Количество)  from ЗАКАЗЫ),
		@y3 int = (select count(*) from ЗАКАЗЫ WHERE MONTH(Дата_поставки) = 9 );
SELECT @y1 as Количество_заказов,
		@y2 as Количество_заказанных_товаров,
		@y3 as Количество_заказов_в_сентябре;