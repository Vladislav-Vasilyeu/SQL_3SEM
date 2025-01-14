use Vas_MyBASE
CREATE table КЛИЕНТЫ
(
	id_клиента int primary key,
	Наименование_фирмы_заказчика nvarchar(50),
	Адрес nvarchar(50) unique,
	Телефон int,
	Контактное_лицо nvarchar(50)
);
CREATE table ТОВАРЫ
(
	id_товара int primary key,
	Наименование_товара nvarchar(50),
	Цена money,
	Описание_товара nvarchar(50)
);
CREATE table ЗАКАЗЫ
(
	id_заказа int primary key,
	id_клиента int foreign key references КЛИЕНТЫ(id_клиента),
	id_товара int foreign key references ТОВАРЫ(id_товара),
	количество int,
	Дата_поставки date,
	Вид_доставки nvarchar(50)
);