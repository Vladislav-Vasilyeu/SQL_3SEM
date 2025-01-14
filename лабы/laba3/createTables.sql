USE Vas_MyBase
CREATE table КЛИЕНТЫ
(	id_клиента int primary key,
	Наименование_фирмы_заказчика nvarchar(50) unique not null,
	Адрес nvarchar(50),
	Телефон int,
	Контактное_лицо nvarchar(50)

) on FG1;
CREATE table ТОВАРЫ 
(	id_товара int primary key,
	Наименоввание_товара nvarchar(50),
	Цена int,
	Описание_товара nvarchar(50)
) on FG1;
CREATE table ЗАКАЗЫ
(	id_заказа int primary key,
	id_клиента int foreign key references КЛИЕНТЫ(id_клиента),
	id_товара int foreign key references ТОВАРЫ(id_товара),
	Количество int,
	Дата_поставки date,
	Вид_доставки nvarchar(50)
) on FG1;
ALTER Table ЗАКАЗЫ DROP Column Адрес_доставки;