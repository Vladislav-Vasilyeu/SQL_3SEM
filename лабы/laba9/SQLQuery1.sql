declare @a char = '!',
		@b varchar(6) = 'string',
		@c datetime,
		@d time(3),
		@i int,
		@f smallint,
		@g tinyint,
		@h numeric(12, 5);
set @c  = getdate();
set	@d = '10:20:45';
set	@i = 10;
set	@f = 32000;
set @g = 255;
set @h = 12345.67890;

select 
	@c  = getdate(),
	@d = '10:20:45',
	@i = 10,
	@f = 32000,
	@g = 255,
	@h = 12345.67890;

select @a as CHAR, @b as varchar, @c as datetime,
		@d as time,
		@i as int,
		@f as smallint,
		@g as tinyint,
		@h as numeric;
print @a