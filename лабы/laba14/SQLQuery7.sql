CREATE FUNCTION dbo.—редн€€÷ена“оваров()
RETURNS decimal(10,2)
AS
BEGIN
    DECLARE @—редн€€÷ена decimal(10,2);
    SELECT @—редн€€÷ена = AVG(CAST(÷ена AS decimal(10,2)))
    FROM “ќ¬ј–џ;
    
    RETURN @—редн€€÷ена;
END;
GO

-- ¬ызов функции
DECLARE @—редн€€÷ена decimal(10,2) = dbo.—редн€€÷ена“оваров();
PRINT('—редн€€ цена товаров: ' + CAST(@—редн€€÷ена AS varchar(10)));
