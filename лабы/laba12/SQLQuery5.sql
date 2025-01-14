---- 4 ������� ----

---- ���������� B ------

---- ���������������� ������ -----
SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
BEGIN TRANSACTION
UPDATE product SET price = 0 WHERE id_product = 1;
WAITFOR DELAY '00:00:02'
ROLLBACK
--------------------------------------------

---- ��������������� ������ ----

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
UPDATE product SET price = 9999 WHERE id_product = 2;
COMMIT

UPDATE product SET price = 4000 WHERE id_product = 2;

--------------------

---- ��������� ������ ----
SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
BEGIN TRANSACTION
INSERT INTO product (id_product, name, price)
    VALUES (4, 'FANTOM', 696969);
COMMIT
DELETE FROM product WHERE id_product = 4;
--------------------

---- 5 ������� ----

---- ���������� B ------

---- ���������������� ������ -----
SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
BEGIN TRANSACTION
UPDATE product SET price = 0 WHERE id_product = 1;
WAITFOR DELAY '00:00:02'
ROLLBACK
--------------------------------------------

---- ��������������� ������ ----
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
UPDATE product SET price = 9999 WHERE id_product = 2;
COMMIT

UPDATE product SET price = 4000 WHERE id_product = 2;
--------------------

---- ��������� ������ ----
SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
BEGIN TRANSACTION
INSERT INTO product (id_product, name, price)
    VALUES (4, 'FANTOM', 696969);
COMMIT
DELETE FROM product WHERE id_product = 4;
--------------------

---- 6 ������� ----

---- ���������� B ------

---- ���������������� ������ -----
SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
BEGIN TRANSACTION
UPDATE product SET price = 0 WHERE id_product = 1;
WAITFOR DELAY '00:00:02'
ROLLBACK
--------------------------------------------

---- ��������������� ������ ----
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
UPDATE product SET price = 9999 WHERE id_product = 2;
COMMIT

UPDATE product SET price = 3432 WHERE id_product = 2;
--------------------

---- ��������� ������ ----
SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
BEGIN TRANSACTION
INSERT INTO product (id_product, name, price)
    VALUES (4, 'FANTOM', 696969);
COMMIT
DELETE FROM product WHERE id_product = 4;
--------------------

---- 7 ������� ----

---- ���������� B ------

---- ���������������� ������ -----
SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
BEGIN TRANSACTION
UPDATE product SET price = 0 WHERE id_product = 1;
WAITFOR DELAY '00:00:02'
ROLLBACK
--------------------------------------------

---- ��������������� ������ ----
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
UPDATE product SET price = 9999 WHERE id_product = 2;
COMMIT

UPDATE product SET price = 3432 WHERE id_product = 2;
--------------------

---- ��������� ������ ----
SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
BEGIN TRANSACTION
INSERT INTO product (id_product, name, price)
    VALUES (4, 'FANTOM', 696969);
COMMIT
DELETE FROM product WHERE id_product = 4;
--------------------
