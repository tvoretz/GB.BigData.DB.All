/* ========================================================================================================
1. Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю shop_read
должны быть доступны только запросы на чтение данных, второму пользователю shop — любые операции в пределах
базы данных shop.
======================================================================================================== */

mysql> CREATE USER shop_read;
Query OK, 0 rows affected (0.03 sec)

mysql> CREATE USER shop;
Query OK, 0 rows affected (0.00 sec)

mysql> GRANT SELECT ON shop.* TO shop_read IDENTIFIED BY '111';
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> GRANT ALL ON shop.* TO shop IDENTIFIED BY '222';
Query OK, 0 rows affected, 1 warning (0.00 sec)


/* ========================================================================================================
2. (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие
первичный ключ, имя пользователя и его пароль. Создайте представление username таблицы accounts,
предоставляющий доступ к столбца id и name. Создайте пользователя user_read, который бы не имел доступа
к таблице accounts, однако, мог бы извлекать записи из представления username.
======================================================================================================== */

mysql> CREATE TABLE accounts (id SERIAL PRIMARY KEY, name VARCHAR(255), password VARCHAR(255));
Query OK, 0 rows affected (0.04 sec)

mysql> CREATE VIEW username AS SELECT id, name FROM accounts;
Query OK, 0 rows affected (0.00 sec)

mysql> INSERT INTO accounts VALUES (DEFAULT, 'John', 'xxx');
Query OK, 1 row affected (0.01 sec)

mysql> CREATE USER user_read;
Query OK, 0 rows affected (0.00 sec)

mysql> GRANT SELECT ON mysql.username TO user_read IDENTIFIED BY '333';
Query OK, 0 rows affected, 1 warning (0.00 sec)

dima@ubuntu-vm:~$ mysql -u user_read -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.

mysql> USE mysql;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> SELECT * FROM accounts;
ERROR 1142 (42000): SELECT command denied to user 'user_read'@'localhost' for table 'accounts'

mysql> SELECT * FROM username;
+----+------+
| id | name |
+----+------+
|  1 | John |
+----+------+
1 row in set (0.00 sec)
