use master
create database Vas_MyBase on primary
	(name=N'Vas_Mybase_mdf', filename=N'D:\Универ\БД Блинова\лабы\laba3\FileGroups\Vas_Mybase_mdf.mdf',size=10240Kb, maxsize=UNLIMITED, filegrowth=1024Kb ),
	(name=N'Vas_Mybase_ndf', filename=N'D:\Универ\БД Блинова\лабы\laba3\FileGroups\Vas_Mybase_ndf.ndf',size=10240Kb, maxsize=1Gb, filegrowth=25% ),
filegroup FG1
	(name=N'Vas_Mybase_fg1_1', filename=N'D:\Универ\БД Блинова\лабы\laba3\FileGroups\Vas_Mybase_fgq-1.ndf',size=10240Kb, maxsize=1Gb, filegrowth=25% ),
	(name=N'Vas_Mybase_fg1_2', filename=N'D:\Универ\БД Блинова\лабы\laba3\FileGroups\Vas_Mybase_fgq-2.ndf',size=10240Kb, maxsize=1Gb, filegrowth=25% )
log on 
	(name=N'Vas_Mybase_log', filename=N'D:\Универ\БД Блинова\лабы\laba3\FileGroups\Vas_Mybase_log.ldf',size=10240Kb, maxsize=2048Gb, filegrowth=10% )