/* ========================================================================================================
1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
======================================================================================================== */

mysql> USE sample;
mysql> CREATE TABLE `users` (
    ->   `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    ->   `name` varchar(255) DEFAULT NULL COMMENT 'Имя покупателя',
    ->   `birthday_at` date DEFAULT NULL COMMENT 'Дата рождения',
    ->   `created_at` datetime DEFAULT NULL,
    ->   `updated_at` datetime DEFAULT NULL,
    ->   PRIMARY KEY (`id`),
    ->   UNIQUE KEY `id` (`id`)
    -> ) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1 COMMENT='Покупатели';
Query OK, 0 rows affected (0.04 sec)

mysql> USE shop;
mysql> SELECT * FROM users;
+----+-------------+-------------+---------------------+---------------------+
| id | name        | birthday_at | created_at          | updated_at          |
+----+-------------+-------------+---------------------+---------------------+
|  6 | Wilton      | 1993-10-01  | 2012-03-18 23:46:21 | 1975-01-31 16:08:25 |
|  7 | Jonas       | 1993-06-23  | 1981-12-10 03:44:40 | 2007-04-25 01:28:35 |
|  8 | Jamaal      | 1988-07-09  | 1987-11-17 19:40:32 | 1997-03-07 18:07:20 |
|  9 | Tristian    | 2016-05-31  | 1983-12-10 01:57:01 | 2005-07-29 22:25:41 |
| 10 | Bobby       | 1973-04-11  | 1984-05-06 18:27:03 | 1989-12-15 15:22:02 |
| 11 | Rahul       | 1979-02-06  | 1974-11-24 19:23:11 | 2014-05-02 09:45:31 |
| 12 | Murl        | 2018-10-05  | 2004-03-15 03:29:01 | 1991-09-19 23:27:16 |
| 13 | Maynard     | 2014-09-20  | 2006-05-12 04:11:15 | 2003-07-24 21:54:16 |
| 14 | Adolph      | 1980-07-24  | 2018-01-24 19:20:25 | 1971-12-22 04:21:54 |
| 15 | Dangelo     | 2000-05-10  | 2018-09-30 17:22:47 | 2012-06-07 05:20:15 |
| 16 | Aaron       | 1976-03-25  | 1974-10-31 22:09:03 | 2004-02-17 18:11:27 |
| 17 | Casimir     | 2018-05-29  | 1988-03-10 18:38:45 | 1979-01-27 00:52:54 |
| 18 | Ralph       | 1984-11-05  | 2002-10-22 23:22:27 | 2000-11-13 10:21:51 |
| 19 | Irving      | 2001-01-19  | 1985-06-27 16:20:18 | 2007-01-06 00:04:38 |
| 20 | Orin        | 1986-06-06  | 1996-10-29 11:48:33 | 2002-07-15 15:34:52 |
| 21 | Christopher | 2009-08-20  | 1982-01-19 12:53:47 | 2009-05-25 18:34:22 |
| 22 | Nathaniel   | 1992-02-15  | 1974-04-20 17:14:13 | 1981-07-03 17:16:49 |
| 23 | Hobart      | 2005-01-17  | 2000-12-02 15:07:44 | 1998-08-30 06:14:20 |
| 24 | Darrell     | 1977-02-08  | 1998-09-28 08:32:36 | 2008-07-06 10:14:01 |
| 25 | Hipolito    | 1976-01-05  | 2000-02-12 20:58:25 | 2005-09-09 09:04:09 |
| 26 | Wayne       | 1980-10-04  | 2009-04-30 16:22:11 | 1975-09-16 14:11:39 |
| 27 | Felton      | 1972-01-23  | 1972-04-22 00:38:48 | 2015-04-25 14:56:17 |
| 28 | Favian      | 2011-03-14  | 2014-03-09 18:53:12 | 1990-02-13 03:29:52 |
| 29 | Kamryn      | 2009-02-27  | 2004-09-05 03:47:42 | 1982-07-06 07:38:45 |
| 30 | Crawford    | 1992-09-04  | 2007-12-02 13:28:28 | 2016-06-22 05:10:07 |
+----+-------------+-------------+---------------------+---------------------+
25 rows in set (0.00 sec)

mysql> INSERT INTO users VALUES(1, 'John', NOW(), NOW(), NOW());
Query OK, 1 row affected, 1 warning (0.01 sec)

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> INSERT INTO sample.users (id, name, birthday_at, created_at, updated_at) SELECT id, name, birthday_at, created_at, updated_at FROM users WHERE id = 1;
Query OK, 1 row affected (0.03 sec)
Records: 1  Duplicates: 0  Warnings: 0

mysql> DELETE FROM users WHERE id = 1;
Query OK, 1 row affected (0.02 sec)

mysql> SELECT * FROM users;
+----+-------------+-------------+---------------------+---------------------+
| id | name        | birthday_at | created_at          | updated_at          |
+----+-------------+-------------+---------------------+---------------------+
|  6 | Wilton      | 1993-10-01  | 2012-03-18 23:46:21 | 1975-01-31 16:08:25 |
|  7 | Jonas       | 1993-06-23  | 1981-12-10 03:44:40 | 2007-04-25 01:28:35 |
|  8 | Jamaal      | 1988-07-09  | 1987-11-17 19:40:32 | 1997-03-07 18:07:20 |
|  9 | Tristian    | 2016-05-31  | 1983-12-10 01:57:01 | 2005-07-29 22:25:41 |
| 10 | Bobby       | 1973-04-11  | 1984-05-06 18:27:03 | 1989-12-15 15:22:02 |
| 11 | Rahul       | 1979-02-06  | 1974-11-24 19:23:11 | 2014-05-02 09:45:31 |
| 12 | Murl        | 2018-10-05  | 2004-03-15 03:29:01 | 1991-09-19 23:27:16 |
| 13 | Maynard     | 2014-09-20  | 2006-05-12 04:11:15 | 2003-07-24 21:54:16 |
| 14 | Adolph      | 1980-07-24  | 2018-01-24 19:20:25 | 1971-12-22 04:21:54 |
| 15 | Dangelo     | 2000-05-10  | 2018-09-30 17:22:47 | 2012-06-07 05:20:15 |
| 16 | Aaron       | 1976-03-25  | 1974-10-31 22:09:03 | 2004-02-17 18:11:27 |
| 17 | Casimir     | 2018-05-29  | 1988-03-10 18:38:45 | 1979-01-27 00:52:54 |
| 18 | Ralph       | 1984-11-05  | 2002-10-22 23:22:27 | 2000-11-13 10:21:51 |
| 19 | Irving      | 2001-01-19  | 1985-06-27 16:20:18 | 2007-01-06 00:04:38 |
| 20 | Orin        | 1986-06-06  | 1996-10-29 11:48:33 | 2002-07-15 15:34:52 |
| 21 | Christopher | 2009-08-20  | 1982-01-19 12:53:47 | 2009-05-25 18:34:22 |
| 22 | Nathaniel   | 1992-02-15  | 1974-04-20 17:14:13 | 1981-07-03 17:16:49 |
| 23 | Hobart      | 2005-01-17  | 2000-12-02 15:07:44 | 1998-08-30 06:14:20 |
| 24 | Darrell     | 1977-02-08  | 1998-09-28 08:32:36 | 2008-07-06 10:14:01 |
| 25 | Hipolito    | 1976-01-05  | 2000-02-12 20:58:25 | 2005-09-09 09:04:09 |
| 26 | Wayne       | 1980-10-04  | 2009-04-30 16:22:11 | 1975-09-16 14:11:39 |
| 27 | Felton      | 1972-01-23  | 1972-04-22 00:38:48 | 2015-04-25 14:56:17 |
| 28 | Favian      | 2011-03-14  | 2014-03-09 18:53:12 | 1990-02-13 03:29:52 |
| 29 | Kamryn      | 2009-02-27  | 2004-09-05 03:47:42 | 1982-07-06 07:38:45 |
| 30 | Crawford    | 1992-09-04  | 2007-12-02 13:28:28 | 2016-06-22 05:10:07 |
+----+-------------+-------------+---------------------+---------------------+
25 rows in set (0.00 sec)

mysql> SELECT * FROM sample.users;
+----+------+-------------+---------------------+---------------------+
| id | name | birthday_at | created_at          | updated_at          |
+----+------+-------------+---------------------+---------------------+
|  1 | John | 2019-05-12  | 2019-05-12 09:49:01 | 2019-05-12 09:49:01 |
+----+------+-------------+---------------------+---------------------+
1 row in set (0.00 sec)

mysql> COMMIT;
Query OK, 0 rows affected (0.00 sec)

/* ========================================================================================================
2. Создайте представление, которое выводит название name товарной позиции из таблицы products и
соответствующее название каталога name из таблицы catalogs.
======================================================================================================== */

mysql> CREATE VIEW prod_in_cat AS SELECT products.name AS product_name, catalogs.name AS catalog_name FROM products JOIN catalogs ON products.catalog_id = catalogs.id;
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT * FROM prod_in_cat;
+-------------------------+-----------------------------------+
| product_name            | catalog_name                      |
+-------------------------+-----------------------------------+
| Intel Core i3-8100      | Процессоры                        |
| Intel Core i5-7400      | Процессоры                        |
| AMD FX-8320E            | Процессоры                        |
| AMD FX-8320             | Процессоры                        |
| ASUS ROG MAXIMUS X HERO | Материнские платы                 |
| Gigabyte H310M S2H      | Материнские платы                 |
| MSI B250M GAMING PRO    | Материнские платы                 |
+-------------------------+-----------------------------------+
7 rows in set (0.00 sec)

/* ========================================================================================================
3. (по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные
записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который
выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном
таблице и 0, если она отсутствует.
======================================================================================================== */

mysql> CREATE TABLE dates (date_aug DATE);
Query OK, 0 rows affected (0.03 sec)

mysql> INSERT INTO dates VALUES
    -> ('2018-08-01'),
    -> ('2018-08-04'),
    -> ('2018-08-16'),
    -> ('2018-08-17');
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

---------------
-- Вариант 1 --
---------------

mysql> SELECT @day_of_year := 212;
+---------------------+
| @day_of_year := 212 |
+---------------------+
|                 212 |
+---------------------+
1 row in set (0.00 sec)

mysql> SELECT help_topic_id,
				@day_of_year := @day_of_year + 1 AS day_of_year,
				@aug_date := MAKEDATE(2018, @day_of_year) AS aug_date,
				IF((SELECT * FROM dates WHERE dates.date_aug = @aug_date), 1, 0) AS occurrence
		FROM mysql.help_topic LIMIT 31;
+---------------+-------------+------------+------------+
| help_topic_id | day_of_year | aug_date   | occurrence |
+---------------+-------------+------------+------------+
|             0 |         213 | 2018-08-01 |          1 |
|             1 |         214 | 2018-08-02 |          0 |
|             2 |         215 | 2018-08-03 |          0 |
|             3 |         216 | 2018-08-04 |          1 |
|             4 |         217 | 2018-08-05 |          0 |
|             5 |         218 | 2018-08-06 |          0 |
|             6 |         219 | 2018-08-07 |          0 |
|             7 |         220 | 2018-08-08 |          0 |
|             8 |         221 | 2018-08-09 |          0 |
|             9 |         222 | 2018-08-10 |          0 |
|            10 |         223 | 2018-08-11 |          0 |
|            11 |         224 | 2018-08-12 |          0 |
|            12 |         225 | 2018-08-13 |          0 |
|            13 |         226 | 2018-08-14 |          0 |
|            14 |         227 | 2018-08-15 |          0 |
|            15 |         228 | 2018-08-16 |          1 |
|            16 |         229 | 2018-08-17 |          1 |
|            17 |         230 | 2018-08-18 |          0 |
|            18 |         231 | 2018-08-19 |          0 |
|            19 |         232 | 2018-08-20 |          0 |
|            20 |         233 | 2018-08-21 |          0 |
|            21 |         234 | 2018-08-22 |          0 |
|            22 |         235 | 2018-08-23 |          0 |
|            23 |         236 | 2018-08-24 |          0 |
|            24 |         237 | 2018-08-25 |          0 |
|            25 |         238 | 2018-08-26 |          0 |
|            26 |         239 | 2018-08-27 |          0 |
|            27 |         240 | 2018-08-28 |          0 |
|            28 |         241 | 2018-08-29 |          0 |
|            29 |         242 | 2018-08-30 |          0 |
|            30 |         243 | 2018-08-31 |          0 |
+---------------+-------------+------------+------------+
31 rows in set (0.00 sec)

---------------
-- Вариант 2 --
---------------

Создаем процедуру generate_series из https://github.com/gabfl/mysql_generate_series

mysql> CALL generate_series('2018-08-01','2018-08-31','INTERVAL 1 DAY');
Query OK, 0 rows affected (0.03 sec)

mysql> SELECT * FROM `series_tmp`;
+------------+
| series     |
+------------+
| 2018-08-01 |
| 2018-08-02 |
| 2018-08-03 |
| 2018-08-04 |
| 2018-08-05 |
| 2018-08-06 |
| 2018-08-07 |
| 2018-08-08 |
| 2018-08-09 |
| 2018-08-10 |
| 2018-08-11 |
| 2018-08-12 |
| 2018-08-13 |
| 2018-08-14 |
| 2018-08-15 |
| 2018-08-16 |
| 2018-08-17 |
| 2018-08-18 |
| 2018-08-19 |
| 2018-08-20 |
| 2018-08-21 |
| 2018-08-22 |
| 2018-08-23 |
| 2018-08-24 |
| 2018-08-25 |
| 2018-08-26 |
| 2018-08-27 |
| 2018-08-28 |
| 2018-08-29 |
| 2018-08-30 |
| 2018-08-31 |
+------------+
31 rows in set (0.00 sec)

mysql> SELECT series as aug_date, IF((SELECT * FROM dates WHERE dates.date_aug = series), 1, 0) AS occurrence FROM `series_tmp` ;
+------------+------------+
| aug_date   | occurrence |
+------------+------------+
| 2018-08-01 |          1 |
| 2018-08-02 |          0 |
| 2018-08-03 |          0 |
| 2018-08-04 |          1 |
| 2018-08-05 |          0 |
| 2018-08-06 |          0 |
| 2018-08-07 |          0 |
| 2018-08-08 |          0 |
| 2018-08-09 |          0 |
| 2018-08-10 |          0 |
| 2018-08-11 |          0 |
| 2018-08-12 |          0 |
| 2018-08-13 |          0 |
| 2018-08-14 |          0 |
| 2018-08-15 |          0 |
| 2018-08-16 |          1 |
| 2018-08-17 |          1 |
| 2018-08-18 |          0 |
| 2018-08-19 |          0 |
| 2018-08-20 |          0 |
| 2018-08-21 |          0 |
| 2018-08-22 |          0 |
| 2018-08-23 |          0 |
| 2018-08-24 |          0 |
| 2018-08-25 |          0 |
| 2018-08-26 |          0 |
| 2018-08-27 |          0 |
| 2018-08-28 |          0 |
| 2018-08-29 |          0 |
| 2018-08-30 |          0 |
| 2018-08-31 |          0 |
+------------+------------+
31 rows in set (0.00 sec)

/* ========================================================================================================
4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет
устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
======================================================================================================== */

mysql> SELECT * FROM users ORDER BY created_at DESC;
+----+-------------+-------------+---------------------+---------------------+
| id | name        | birthday_at | created_at          | updated_at          |
+----+-------------+-------------+---------------------+---------------------+
| 15 | Dangelo     | 2000-05-10  | 2018-09-30 17:22:47 | 2012-06-07 05:20:15 |
| 14 | Adolph      | 1980-07-24  | 2018-01-24 19:20:25 | 1971-12-22 04:21:54 |
| 28 | Favian      | 2011-03-14  | 2014-03-09 18:53:12 | 1990-02-13 03:29:52 |
|  6 | Wilton      | 1993-10-01  | 2012-03-18 23:46:21 | 1975-01-31 16:08:25 |
| 26 | Wayne       | 1980-10-04  | 2009-04-30 16:22:11 | 1975-09-16 14:11:39 |
| 30 | Crawford    | 1992-09-04  | 2007-12-02 13:28:28 | 2016-06-22 05:10:07 |
| 13 | Maynard     | 2014-09-20  | 2006-05-12 04:11:15 | 2003-07-24 21:54:16 |
| 29 | Kamryn      | 2009-02-27  | 2004-09-05 03:47:42 | 1982-07-06 07:38:45 |
| 12 | Murl        | 2018-10-05  | 2004-03-15 03:29:01 | 1991-09-19 23:27:16 |
| 18 | Ralph       | 1984-11-05  | 2002-10-22 23:22:27 | 2000-11-13 10:21:51 |
| 23 | Hobart      | 2005-01-17  | 2000-12-02 15:07:44 | 1998-08-30 06:14:20 |
| 25 | Hipolito    | 1976-01-05  | 2000-02-12 20:58:25 | 2005-09-09 09:04:09 |
| 24 | Darrell     | 1977-02-08  | 1998-09-28 08:32:36 | 2008-07-06 10:14:01 |
| 20 | Orin        | 1986-06-06  | 1996-10-29 11:48:33 | 2002-07-15 15:34:52 |
| 17 | Casimir     | 2018-05-29  | 1988-03-10 18:38:45 | 1979-01-27 00:52:54 |
|  8 | Jamaal      | 1988-07-09  | 1987-11-17 19:40:32 | 1997-03-07 18:07:20 |
| 19 | Irving      | 2001-01-19  | 1985-06-27 16:20:18 | 2007-01-06 00:04:38 |
| 10 | Bobby       | 1973-04-11  | 1984-05-06 18:27:03 | 1989-12-15 15:22:02 |
|  9 | Tristian    | 2016-05-31  | 1983-12-10 01:57:01 | 2005-07-29 22:25:41 |
| 21 | Christopher | 2009-08-20  | 1982-01-19 12:53:47 | 2009-05-25 18:34:22 |
|  7 | Jonas       | 1993-06-23  | 1981-12-10 03:44:40 | 2007-04-25 01:28:35 |
| 11 | Rahul       | 1979-02-06  | 1974-11-24 19:23:11 | 2014-05-02 09:45:31 |
| 16 | Aaron       | 1976-03-25  | 1974-10-31 22:09:03 | 2004-02-17 18:11:27 |
| 22 | Nathaniel   | 1992-02-15  | 1974-04-20 17:14:13 | 1981-07-03 17:16:49 |
| 27 | Felton      | 1972-01-23  | 1972-04-22 00:38:48 | 2015-04-25 14:56:17 |
+----+-------------+-------------+---------------------+---------------------+
25 rows in set (0.00 sec)

mysql> SELECT @last_ok := created_at FROM users ORDER BY created_at DESC LIMIT 5;
+------------------------+
| @last_ok := created_at |
+------------------------+
| 2018-09-30 17:22:47    |
| 2018-01-24 19:20:25    |
| 2014-03-09 18:53:12    |
| 2012-03-18 23:46:21    |
| 2009-04-30 16:22:11    |
+------------------------+
5 rows in set (0.00 sec)

mysql> SELECT @last_ok;
+---------------------+
| @last_ok            |
+---------------------+
| 2009-04-30 16:22:11 |
+---------------------+
1 row in set (0.00 sec)

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> DELETE FROM users WHERE created_at < @last_ok;
Query OK, 20 rows affected (0.00 sec)

mysql> SELECT * FROM users ORDER BY created_at DESC ;
+----+----------+-------------+---------------------+---------------------+
| id | name     | birthday_at | created_at          | updated_at          |
+----+----------+-------------+---------------------+---------------------+
| 15 | Dangelo  | 2000-05-10  | 2018-09-30 17:22:47 | 2012-06-07 05:20:15 |
| 14 | Adolph   | 1980-07-24  | 2018-01-24 19:20:25 | 1971-12-22 04:21:54 |
| 28 | Favian   | 2011-03-14  | 2014-03-09 18:53:12 | 1990-02-13 03:29:52 |
|  6 | Wilton   | 1993-10-01  | 2012-03-18 23:46:21 | 1975-01-31 16:08:25 |
| 26 | Wayne    | 1980-10-04  | 2009-04-30 16:22:11 | 1975-09-16 14:11:39 |
+----+----------+-------------+---------------------+---------------------+
5 rows in set (0.00 sec)

mysql> ROLLBACK;
Query OK, 0 rows affected (0.02 sec)
