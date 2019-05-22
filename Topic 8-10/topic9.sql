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
