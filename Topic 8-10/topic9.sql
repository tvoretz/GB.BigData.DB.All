/* ========================================================================================================
1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и
products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного
ключа и содержимое поля name.
======================================================================================================== */

mysql> DROP TABLE IF EXISTS logs;
Query OK, 0 rows affected (0.00 sec)

mysql> CREATE TABLE logs (
    ->   id SERIAL,
    ->   tablename CHAR(20) NOT NULL,
    ->   record_at DATETIME NOT NULL,
    ->   record_id BIGINT(20) UNSIGNED NOT NULL,
    ->   record_name VARCHAR(255)
    -> ) ENGINE = Archive;
Query OK, 0 rows affected (0.01 sec)

mysql> SHOW TABLE STATUS WHERE name = 'logs'\G;
*************************** 1. row ***************************
           Name: logs
         Engine: ARCHIVE
        Version: 10
     Row_format: Compressed
           Rows: 0
 Avg_row_length: 1124
    Data_length: 8808
Max_data_length: 0
   Index_length: 0
      Data_free: 0
 Auto_increment: 1
    Create_time: NULL
    Update_time: 2019-05-22 17:37:17
     Check_time: NULL
      Collation: utf8mb4_unicode_ci
       Checksum: NULL
 Create_options:
        Comment:
1 row in set (0.00 sec)

DELIMITER //

mysql> DROP TRIGGER IF EXISTS users_after_insert//
Query OK, 0 rows affected (0.00 sec)

mysql> CREATE TRIGGER users_after_insert AFTER INSERT ON users
    -> FOR EACH ROW
    -> BEGIN
    ->   INSERT INTO logs VALUES (DEFAULT, 'users', NOW(), NEW.id, NEW.name);
    -> END//
Query OK, 0 rows affected (0.00 sec)

mysql> INSERT INTO users VALUES (DEFAULT, 'TEST-RECORD', NOW(), NOW(), NOW())//
Query OK, 1 row affected, 1 warning (0.04 sec)

mysql> SELECT * FROM users ORDER BY id DESC LIMIT 1//
+----+-------------+-------------+---------------------+---------------------+
| id | name        | birthday_at | created_at          | updated_at          |
+----+-------------+-------------+---------------------+---------------------+
| 31 | TEST-RECORD | 2019-05-22  | 2019-05-22 17:45:23 | 2019-05-22 17:45:23 |
+----+-------------+-------------+---------------------+---------------------+
1 row in set (0.00 sec)

mysql> SELECT * FROM logs//
+----+-----------+---------------------+-----------+-------------+
| id | tablename | record_at           | record_id | record_name |
+----+-----------+---------------------+-----------+-------------+
|  1 | users     | 2019-05-22 17:45:23 |        31 | TEST-RECORD |
+----+-----------+---------------------+-----------+-------------+
1 row in set (0.01 sec)

ysql> DROP TRIGGER IF EXISTS users_catalogs_insert//
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> CREATE TRIGGER users_catalogs_insert AFTER INSERT ON catalogs
    -> FOR EACH ROW
    -> BEGIN
    ->   INSERT INTO logs VALUES (DEFAULT, 'catalogs', NOW(), NEW.id, NEW.name);
    -> END//
Query OK, 0 rows affected (0.02 sec)

mysql> DROP TRIGGER IF EXISTS users_products_insert//
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> CREATE TRIGGER users_products_insert AFTER INSERT ON products
    -> FOR EACH ROW
    -> BEGIN
    ->   INSERT INTO logs VALUES (DEFAULT, 'products', NOW(), NEW.id, NEW.name);
    -> END//
Query OK, 0 rows affected (0.00 sec)

/* ========================================================================================================
2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
======================================================================================================== */

mysql> SELECT * FROM users;
+----+-------------+-------------+---------------------+---------------------+
| id | name        | birthday_at | created_at          | updated_at          |
+----+-------------+-------------+---------------------+---------------------+
| 22 | Nathaniel   | 1992-02-15  | 1974-04-20 17:14:13 | 1981-07-03 17:16:49 |
| 23 | Hobart      | 2005-01-17  | 2000-12-02 15:07:44 | 1998-08-30 06:14:20 |
| 24 | Darrell     | 1977-02-08  | 1998-09-28 08:32:36 | 2008-07-06 10:14:01 |
| 25 | Hipolito    | 1976-01-05  | 2000-02-12 20:58:25 | 2005-09-09 09:04:09 |
| 26 | Wayne       | 1980-10-04  | 2009-04-30 16:22:11 | 1975-09-16 14:11:39 |
| 27 | Felton      | 1972-01-23  | 1972-04-22 00:38:48 | 2015-04-25 14:56:17 |
| 28 | Favian      | 2011-03-14  | 2014-03-09 18:53:12 | 1990-02-13 03:29:52 |
| 29 | Kamryn      | 2009-02-27  | 2004-09-05 03:47:42 | 1982-07-06 07:38:45 |
| 30 | Crawford    | 1992-09-04  | 2007-12-02 13:28:28 | 2016-06-22 05:10:07 |
| 31 | TEST-RECORD | 2019-05-22  | 2019-05-22 17:45:23 | 2019-05-22 17:45:23 |
+----+-------------+-------------+---------------------+---------------------+
10 rows in set (0.00 sec)

mysql> INSERT INTO users (name) SELECT u1.name FROM users u1, users u2, users u3, users u4, users u5, users u6;
Query OK, 1000000 rows affected (20.80 sec)
Records: 1000000  Duplicates: 0  Warnings: 0

mysql> SELECT COUNT(*) FROM users;
+----------+
| COUNT(*) |
+----------+
|  1000010 |
+----------+
1 row in set (0.19 sec)
