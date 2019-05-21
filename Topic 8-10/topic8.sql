/* ========================================================================================================
1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего
времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция
должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
======================================================================================================== */

mysql> DELIMITER //

mysql> DROP FUNCTION IF EXISTS hello//
Query OK, 0 rows affected (0.00 sec)

mysql> CREATE FUNCTION hello()
    -> RETURNS VARCHAR(20) DETERMINISTIC
    -> BEGIN
    ->   DECLARE hour TINYINT;
    ->   SET hour = HOUR(NOW());
    ->   CASE
    ->     WHEN hour >= 0 AND hour < 6 THEN
    ->       RETURN 'Доброй ночи!';
    ->     WHEN hour >= 6 AND hour < 12 THEN
    ->       RETURN 'Доброе утро!';
    ->     WHEN hour >= 12 AND hour < 18 THEN
    ->       RETURN 'Добрый день!';
    ->     WHEN hour >= 18 AND hour <= 23 THEN
    ->       RETURN 'Добрый вечер!';
    ->     ELSE
    ->       RETURN 'Ошибка!';
    ->   END CASE;
    -> END//
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT hello()//
+------------------------+
| hello()                |
+------------------------+
| Доброе утро!           |
+------------------------+
1 row in set (0.00 sec)

/* ========================================================================================================
2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное
значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были
заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.
======================================================================================================== */

mysql> DROP TRIGGER IF EXISTS check_name_descr_null_insert;
    -> CREATE TRIGGER check_name_descr_null_insert BEFORE INSERT ON products
    -> FOR EACH ROW
    -> BEGIN
    ->   IF NEW.name IS NULL AND NEW.description IS NULL THEN
    ->     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Both name and description can not be NULL';
    ->   END IF;
    -> END//
Query OK, 0 rows affected (0.00 sec)

mysql> DROP TRIGGER IF EXISTS check_name_descr_null_update;
    -> CREATE TRIGGER check_name_descr_null_update BEFORE UPDATE ON products
    -> FOR EACH ROW
    -> BEGIN
    ->   IF NEW.name IS NULL AND NEW.description IS NULL THEN
    ->     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Both name and description can not be NULL';
    ->   END IF;
    -> END//
Query OK, 0 rows affected, 1 warning (0.03 sec)

mysql> INSERT INTO products (id, name, description) VALUES (DEFAULT, NULL, NULL)//
ERROR 1644 (45000): Both name and description can not be NULL

mysql> INSERT INTO products (id, name, description) VALUES (DEFAULT, NULL, 'qqq')//
Query OK, 1 row affected (0.03 sec)

mysql> SELECT * FROM products WHERE id = LAST_INSERT_ID()//
+----+------+-------------+-------+------------+---------------------+---------------------+
| id | name | description | price | catalog_id | created_at          | updated_at          |
+----+------+-------------+-------+------------+---------------------+---------------------+
|  8 | NULL | qqq         |  NULL |       NULL | 2019-05-21 17:49:26 | 2019-05-21 17:49:26 |
+----+------+-------------+-------+------------+---------------------+---------------------+
1 row in set (0.03 sec)

mysql> UPDATE products SET name = NULL, description = NULL WHERE id = 8//
ERROR 1644 (45000): Both name and description can not be NULL

mysql> UPDATE products SET name = 'eee', description = NULL WHERE id = 8//
Query OK, 1 row affected (0.04 sec)
Rows matched: 1  Changed: 1  Warnings: 0

/* ========================================================================================================
3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи
называется последовательность в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10)
должен возвращать число 55.
======================================================================================================== */

mysql> DROP FUNCTION IF EXISTS FIBONACCI//
Query OK, 0 rows affected (0.00 sec)

mysql> CREATE FUNCTION FIBONACCI(num INT)
    ->   RETURNS FLOAT DETERMINISTIC
    -> BEGIN
    ->   DECLARE fibo, sqrt5 FLOAT;
    ->   SET sqrt5 = SQRT(5);
    ->   SET fibo = ( POW(((1+sqrt5)/2),num) - POW(((1-sqrt5)/2),num) ) / sqrt5;
    ->   RETURN fibo;
    -> END//
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT FIBONACCI(10)//
+---------------+
| FIBONACCI(10) |
+---------------+
|            55 |
+---------------+
1 row in set (0.00 sec)
