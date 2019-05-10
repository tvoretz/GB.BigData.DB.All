
===============================================================================================

************************************************************
1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
************************************************************

mysql> insert into users values (DEFAULT, 'user1', NULL, NULL, NULL);
mysql> insert into users values (DEFAULT, 'user2', NULL, NULL, NULL);
mysql> insert into users values (DEFAULT, 'user3', NULL, NULL, NULL);
mysql> insert into users values (DEFAULT, 'user4', NULL, NULL, NULL);
mysql> insert into users values (DEFAULT, 'user5', NULL, NULL, NULL);

mysql> select * from users;
+----+-------+-------------+------------+------------+
| id | name  | birthday_at | created_at | updated_at |
+----+-------+-------------+------------+------------+
|  1 | user1 | NULL        | NULL       | NULL       |
|  2 | user2 | NULL        | NULL       | NULL       |
|  3 | user3 | NULL        | NULL       | NULL       |
|  4 | user4 | NULL        | NULL       | NULL       |
|  5 | user5 | NULL        | NULL       | NULL       |
+----+-------+-------------+------------+------------+

mysql> UPDATE users SET created_at = NOW(), updated_at = NOW();
Query OK, 5 rows affected (0.00 sec)
Rows matched: 5  Changed: 5  Warnings: 0

mysql> select * from users;
+----+-------+-------------+---------------------+---------------------+
| id | name  | birthday_at | created_at          | updated_at          |
+----+-------+-------------+---------------------+---------------------+
|  1 | user1 | NULL        | 2019-05-04 18:33:47 | 2019-05-04 18:33:47 |
|  2 | user2 | NULL        | 2019-05-04 18:33:47 | 2019-05-04 18:33:47 |
|  3 | user3 | NULL        | 2019-05-04 18:33:47 | 2019-05-04 18:33:47 |
|  4 | user4 | NULL        | 2019-05-04 18:33:47 | 2019-05-04 18:33:47 |
|  5 | user5 | NULL        | 2019-05-04 18:33:47 | 2019-05-04 18:33:47 |
+----+-------+-------------+---------------------+---------------------+
5 rows in set (0.00 sec)

===============================================================================================

************************************************************
2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
************************************************************

mysql> desc users;
+-------------+---------------------+------+-----+---------+----------------+
| Field       | Type                | Null | Key | Default | Extra          |
+-------------+---------------------+------+-----+---------+----------------+
| id          | bigint(20) unsigned | NO   | PRI | NULL    | auto_increment |
| name        | varchar(255)        | YES  |     | NULL    |                |
| birthday_at | date                | YES  |     | NULL    |                |
| created_at  | varchar(255)        | YES  |     | NULL    |                |
| updated_at  | varchar(255)        | YES  |     | NULL    |                |
+-------------+---------------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

mysql> select * from users;
+----+-------+-------------+------------------+------------------+
| id | name  | birthday_at | created_at       | updated_at       |
+----+-------+-------------+------------------+------------------+
|  1 | user1 | NULL        | 20.10.2017 8:10  | 20.10.2017 8:10  |
|  2 | user2 | NULL        | 20.11.2017 18:20 | 20.11.2019 18:20 |
|  3 | user3 | NULL        | 20.01.2001 18:00 | 11.11.2019 23:20 |
|  4 | user4 | NULL        | 20.01.2007 18:00 | 11.01.2019 23:20 |
|  5 | user5 | NULL        | 10.01.2007 7:00  | 11.01.2008 5:20  |
+----+-------+-------------+------------------+------------------+
5 rows in set (0.00 sec)

mysql> CREATE TABLE users_temp (id SERIAL auto_increment, created_at_old varchar(255), updated_at_old varchar(255));
Query OK, 0 rows affected (0.00 sec)

mysql> INSERT INTO users_temp (SELECT id, created_at, updated_at FROM users);
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> select * from users_temp;
+----+------------------+------------------+
| id | created_at_old   | updated_at_old   |
+----+------------------+------------------+
|  1 | 20.10.2017 8:10  | 20.10.2017 8:10  |
|  2 | 20.11.2017 18:20 | 20.11.2019 18:20 |
|  3 | 20.01.2001 18:00 | 11.11.2019 23:20 |
|  4 | 20.01.2007 18:00 | 11.01.2019 23:20 |
|  5 | 10.01.2007 7:00  | 11.01.2008 5:20  |
+----+------------------+------------------+
5 rows in set (0.00 sec)

mysql> UPDATE users SET created_at = (SELECT STR_TO_DATE(created_at_old,'%d.%m.%Y %H:%i') FROM users_temp WHERE users.id = users_temp.id);
Query OK, 5 rows affected (0.00 sec)
Rows matched: 5  Changed: 5  Warnings: 0

mysql> UPDATE users SET updated_at = (SELECT STR_TO_DATE(updated_at_old,'%d.%m.%Y %H:%i') FROM users_temp WHERE users.id = users_temp.id);
Query OK, 5 rows affected (0.01 sec)
Rows matched: 5  Changed: 5  Warnings: 0

mysql> SELECT * FROM users;
+----+-------+-------------+---------------------+---------------------+
| id | name  | birthday_at | created_at          | updated_at          |
+----+-------+-------------+---------------------+---------------------+
|  1 | user1 | NULL        | 2017-10-20 08:10:00 | 2017-10-20 08:10:00 |
|  2 | user2 | NULL        | 2017-11-20 18:20:00 | 2019-11-20 18:20:00 |
|  3 | user3 | NULL        | 2001-01-20 18:00:00 | 2019-11-11 23:20:00 |
|  4 | user4 | NULL        | 2007-01-20 18:00:00 | 2019-01-11 23:20:00 |
|  5 | user5 | NULL        | 2007-01-10 07:00:00 | 2008-01-11 05:20:00 |
+----+-------+-------------+---------------------+---------------------+
5 rows in set (0.00 sec)

mysql> ALTER TABLE users MODIFY COLUMN created_at DATETIME;
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE users MODIFY COLUMN updated_at DATETIME;
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> desc users;
+-------------+---------------------+------+-----+---------+----------------+
| Field       | Type                | Null | Key | Default | Extra          |
+-------------+---------------------+------+-----+---------+----------------+
| id          | bigint(20) unsigned | NO   | PRI | NULL    | auto_increment |
| name        | varchar(255)        | YES  |     | NULL    |                |
| birthday_at | date                | YES  |     | NULL    |                |
| created_at  | datetime            | YES  |     | NULL    |                |
| updated_at  | datetime            | YES  |     | NULL    |                |
+-------------+---------------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

mysql> SELECT * FROM users;
+----+-------+-------------+---------------------+---------------------+
| id | name  | birthday_at | created_at          | updated_at          |
+----+-------+-------------+---------------------+---------------------+
|  1 | user1 | NULL        | 2017-10-20 08:10:00 | 2017-10-20 08:10:00 |
|  2 | user2 | NULL        | 2017-11-20 18:20:00 | 2019-11-20 18:20:00 |
|  3 | user3 | NULL        | 2001-01-20 18:00:00 | 2019-11-11 23:20:00 |
|  4 | user4 | NULL        | 2007-01-20 18:00:00 | 2019-01-11 23:20:00 |
|  5 | user5 | NULL        | 2007-01-10 07:00:00 | 2008-01-11 05:20:00 |
+----+-------+-------------+---------------------+---------------------+
5 rows in set (0.00 sec)

mysql> DROP TABLE users_temp;
Query OK, 0 rows affected (0.00 sec)

===============================================================================================

************************************************************
3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.
************************************************************

mysql> desc storehouses_products;
+---------------+---------------------+------+-----+-------------------+-----------------------------+
| Field         | Type                | Null | Key | Default           | Extra                       |
+---------------+---------------------+------+-----+-------------------+-----------------------------+
| id            | bigint(20) unsigned | NO   | PRI | NULL              | auto_increment              |
| storehouse_id | int(10) unsigned    | YES  |     | NULL              |                             |
| product_id    | int(10) unsigned    | YES  |     | NULL              |                             |
| value         | int(10) unsigned    | YES  |     | NULL              |                             |
| created_at    | datetime            | YES  |     | CURRENT_TIMESTAMP |                             |
| updated_at    | datetime            | YES  |     | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |
+---------------+---------------------+------+-----+-------------------+-----------------------------+

INSERT INTO `storehouses_products` (`id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (1, 34, 0, '1982-07-14 02:09:55', '1990-08-21 06:32:14');
INSERT INTO `storehouses_products` (`id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (2, 51, 19, '1979-08-06 19:24:06', '2000-05-31 01:20:00');
INSERT INTO `storehouses_products` (`id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (3, 32, 9, '2001-04-09 02:42:46', '2011-09-17 15:45:25');
INSERT INTO `storehouses_products` (`id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (4, 70, 0, '2000-06-20 15:38:02', '2000-09-18 14:49:29');
INSERT INTO `storehouses_products` (`id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (5, 44, 13, '1988-04-24 12:41:28', '2014-10-06 10:17:44');
INSERT INTO `storehouses_products` (`id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (6, 53, 13, '1988-05-24 20:12:15', '1983-07-03 10:19:20');
INSERT INTO `storehouses_products` (`id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (7, 96, 10, '1994-08-23 05:15:48', '1991-07-07 09:45:00');
INSERT INTO `storehouses_products` (`id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (8, 21, 0, '2004-10-01 15:23:13', '2009-03-16 02:37:18');
INSERT INTO `storehouses_products` (`id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (9, 68, 12, '1975-03-02 21:44:54', '2000-10-18 19:55:39');
INSERT INTO `storehouses_products` (`id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (10, 79, 15, '2014-04-14 02:12:14', '1995-01-31 05:40:26');
INSERT INTO `storehouses_products` (`id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (11, 31, 15, '2000-11-26 22:10:46', '1993-09-09 04:37:52');
INSERT INTO `storehouses_products` (`id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (12, 7, 6, '2006-09-21 15:27:17', '1988-08-17 15:26:09');
INSERT INTO `storehouses_products` (`id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (13, 46, 4, '1972-12-27 04:38:50', '2000-08-19 06:00:17');
INSERT INTO `storehouses_products` (`id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (14, 2, 5, '1990-08-06 15:24:18', '1981-05-18 07:54:06');
INSERT INTO `storehouses_products` (`id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES (15, 36, 17, '1991-04-19 02:26:18', '1980-09-16 18:03:47');

mysql> SELECT id, value, IF(value = 0, 'no', 'yes') as available FROM storehouses_products ORDER BY available DESC, value ASC;
+----+-------+-----------+
| id | value | available |
+----+-------+-----------+
| 13 |     4 | yes       |
| 14 |     5 | yes       |
| 12 |     6 | yes       |
|  3 |     9 | yes       |
|  7 |    10 | yes       |
|  9 |    12 | yes       |
|  5 |    13 | yes       |
|  6 |    13 | yes       |
| 10 |    15 | yes       |
| 11 |    15 | yes       |
| 15 |    17 | yes       |
|  2 |    19 | yes       |
|  1 |     0 | no        |
|  4 |     0 | no        |
|  8 |     0 | no        |
+----+-------+-----------+
15 rows in set (0.01 sec)

===============================================================================================

************************************************************
4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')
************************************************************

mysql> select * from users;
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
| 15 | D'angelo    | 2000-05-10  | 2018-09-30 17:22:47 | 2012-06-07 05:20:15 |
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

mysql> SELECT id, name, birthday_at FROM users WHERE MONTHNAME(birthday_at) IN('may', 'august');
+----+-------------+-------------+
| id | name        | birthday_at |
+----+-------------+-------------+
|  9 | Tristian    | 2016-05-31  |
| 15 | D'angelo    | 2000-05-10  |
| 17 | Casimir     | 2018-05-29  |
| 21 | Christopher | 2009-08-20  |
+----+-------------+-------------+
4 rows in set (0.03 sec)

===============================================================================================

************************************************************
5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
************************************************************

mysql> select * from catalogs;
+----+-----------------+
| id | name            |
+----+-----------------+
|  1 | Crona Plaza     |
|  2 | Albin Trail     |
|  3 | Gibson Trace    |
|  4 | Jayden Causeway |
|  5 | Cordie Via      |
|  6 | Stamm Street    |
|  7 | Hauck Burg      |
|  8 | Ara Fort        |
|  9 | Valentin Square |
| 10 | Wisoky Plaza    |
+----+-----------------+
10 rows in set (0.00 sec)

mysql> SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);
+----+-------------+
| id | name        |
+----+-------------+
|  5 | Cordie Via  |
|  1 | Crona Plaza |
|  2 | Albin Trail |
+----+-------------+
3 rows in set (0.03 sec)

===============================================================================================

















