/* ========================================================================================================
1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
======================================================================================================== */

INSERT INTO `orders` VALUES
('1','23','2007-12-17 12:55:50','1988-06-02 11:29:09'),
('2','6','1989-02-22 00:29:57','1980-08-04 15:19:29'),
('3','9','1972-06-30 02:16:34','2016-09-17 14:26:13'),
('4','45','2007-11-11 23:49:23','1992-03-03 22:01:11'),
('5','45','1983-08-25 12:11:04','1972-09-01 19:02:26'),
('6','34','1993-06-25 15:01:44','1986-01-20 21:46:40'),
('7','39','1989-05-05 01:06:26','1986-12-10 00:08:07'),
('8','26','1977-01-24 02:04:15','1989-07-22 17:41:24'),
('9','12','1980-01-23 02:55:28','2008-12-26 02:27:50'),
('10','2','2016-08-06 21:36:10','1972-08-31 20:11:38'),
('11','28','1996-07-09 06:17:32','2000-03-04 03:56:05'),
('12','6','2014-04-09 07:07:36','1987-08-19 09:15:23'),
('13','18','1999-06-16 11:35:50','1998-05-14 00:01:16'),
('14','20','1984-09-08 01:41:28','2014-10-02 07:10:01'),
('15','25','1988-12-23 07:24:38','1984-01-01 08:48:43'),
('16','13','1989-03-19 01:21:52','1982-09-12 20:22:13'),
('17','20','1987-04-26 01:50:47','2001-01-30 08:21:44'),
('18','32','2011-07-21 01:29:07','1998-01-08 02:01:29'),
('19','23','2013-06-03 11:24:03','1984-05-30 00:40:40'),
('20','24','1975-11-23 21:42:23','2012-01-05 12:33:51'),
('21','15','1992-01-12 05:46:03','1985-04-29 19:13:52'),
('22','45','1995-07-10 01:08:02','1973-03-02 18:18:46'),
('23','49','2000-06-01 10:08:56','1985-01-07 03:48:33'),
('24','23','2017-02-09 13:16:03','1999-01-20 18:55:12'),
('25','30','1973-07-16 19:21:06','2018-01-19 07:42:30'),
('26','15','1971-10-23 16:20:02','2016-08-04 17:49:58'),
('27','19','2012-02-28 07:02:34','2011-08-07 20:04:40'),
('28','21','2005-05-04 10:53:14','1991-03-24 23:22:43'),
('29','7','2004-09-05 05:47:03','1986-02-17 05:03:01'),
('30','31','2014-04-21 17:10:42','1994-09-27 23:02:17'),
('31','15','2004-11-06 19:11:23','1993-04-15 15:18:57'),
('32','38','1973-03-07 16:33:09','1992-07-31 05:06:11'),
('33','15','1986-03-07 03:52:08','2015-04-09 22:03:32'),
('34','26','1995-09-07 03:01:21','1998-02-11 21:14:27'),
('35','50','1982-01-03 22:53:10','1999-02-13 05:39:05'),
('36','1','2000-10-07 03:26:26','2001-09-21 08:44:00'),
('37','42','1991-10-13 06:41:00','1994-12-10 16:43:20'),
('38','49','2009-11-17 17:43:41','2018-06-06 07:30:21'),
('39','9','1979-12-06 11:14:02','1973-12-10 01:04:29'),
('40','1','1974-01-07 04:57:09','2018-01-12 14:30:00'),
('41','7','2015-08-05 14:26:34','1987-10-12 10:44:12'),
('42','32','2011-08-11 05:30:05','1988-12-28 17:35:27'),
('43','5','2009-03-19 15:15:13','1998-12-22 18:20:21'),
('44','36','1984-04-09 17:20:45','1977-03-19 09:58:24'),
('45','28','1981-01-02 02:33:10','1997-01-06 07:44:28'),
('46','47','1974-03-27 02:21:11','2009-01-03 09:28:55'),
('47','14','1989-02-24 00:41:02','2015-08-25 17:21:34'),
('48','32','2002-12-09 04:11:30','1978-09-12 03:28:20'),
('49','49','1976-02-06 03:35:45','1988-02-07 08:51:41'),
('50','3','2012-12-03 00:16:19','1998-08-30 03:14:17'); 

mysql> SELECT * FROM users WHERE id = ANY (SELECT user_id FROM orders);
+----+-------------+-------------+---------------------+---------------------+
| id | name        | birthday_at | created_at          | updated_at          |
+----+-------------+-------------+---------------------+---------------------+
|  6 | Wilton      | 1993-10-01  | 2012-03-18 23:46:21 | 1975-01-31 16:08:25 |
|  7 | Jonas       | 1993-06-23  | 1981-12-10 03:44:40 | 2007-04-25 01:28:35 |
|  9 | Tristian    | 2016-05-31  | 1983-12-10 01:57:01 | 2005-07-29 22:25:41 |
| 12 | Murl        | 2018-10-05  | 2004-03-15 03:29:01 | 1991-09-19 23:27:16 |
| 13 | Maynard     | 2014-09-20  | 2006-05-12 04:11:15 | 2003-07-24 21:54:16 |
| 14 | Adolph      | 1980-07-24  | 2018-01-24 19:20:25 | 1971-12-22 04:21:54 |
| 15 | Dangelo     | 2000-05-10  | 2018-09-30 17:22:47 | 2012-06-07 05:20:15 |
| 18 | Ralph       | 1984-11-05  | 2002-10-22 23:22:27 | 2000-11-13 10:21:51 |
| 19 | Irving      | 2001-01-19  | 1985-06-27 16:20:18 | 2007-01-06 00:04:38 |
| 20 | Orin        | 1986-06-06  | 1996-10-29 11:48:33 | 2002-07-15 15:34:52 |
| 21 | Christopher | 2009-08-20  | 1982-01-19 12:53:47 | 2009-05-25 18:34:22 |
| 23 | Hobart      | 2005-01-17  | 2000-12-02 15:07:44 | 1998-08-30 06:14:20 |
| 24 | Darrell     | 1977-02-08  | 1998-09-28 08:32:36 | 2008-07-06 10:14:01 |
| 25 | Hipolito    | 1976-01-05  | 2000-02-12 20:58:25 | 2005-09-09 09:04:09 |
| 26 | Wayne       | 1980-10-04  | 2009-04-30 16:22:11 | 1975-09-16 14:11:39 |
| 28 | Favian      | 2011-03-14  | 2014-03-09 18:53:12 | 1990-02-13 03:29:52 |
| 30 | Crawford    | 1992-09-04  | 2007-12-02 13:28:28 | 2016-06-22 05:10:07 |
+----+-------------+-------------+---------------------+---------------------+

mysql> SELECT user_id, (SELECT name FROM users WHERE orders.user_id = users.id) as name, COUNT(*) AS qty FROM orders GROUP BY user_id HAVING user_id = ANY (SELECT id FROM users);
+---------+-------------+-----+
| user_id | name        | qty |
+---------+-------------+-----+
|       6 | Wilton      |   2 |
|       7 | Jonas       |   2 |
|       9 | Tristian    |   2 |
|      12 | Murl        |   1 |
|      13 | Maynard     |   1 |
|      14 | Adolph      |   1 |
|      15 | Dangelo     |   4 |
|      18 | Ralph       |   1 |
|      19 | Irving      |   1 |
|      20 | Orin        |   2 |
|      21 | Christopher |   1 |
|      23 | Hobart      |   3 |
|      24 | Darrell     |   1 |
|      25 | Hipolito    |   1 |
|      26 | Wayne       |   2 |
|      28 | Favian      |   2 |
|      30 | Crawford    |   1 |
+---------+-------------+-----+
17 rows in set (0.00 sec)

/* ========================================================================================================
2. Выведите список товаров products и разделов catalogs, который соответствует товару.
Т.е. вывести идентификатор и название из таблицы products, а рядом в соседнем столбце вывести название раздела.
======================================================================================================== */

ALTER DATABASE shop CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
ALTER TABLE catalogs CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE products CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

mysql> SELECT products.id, products.name AS product_name, catalogs.name AS catalog_name FROM products JOIN catalogs ON products.catalog_id = catalogs.id;
+----+-------------------------+-----------------------------------+
| id | product_name            | catalog_name                      |
+----+-------------------------+-----------------------------------+
|  1 | Intel Core i3-8100      | Процессоры                        |
|  2 | Intel Core i5-7400      | Процессоры                        |
|  3 | AMD FX-8320E            | Процессоры                        |
|  4 | AMD FX-8320             | Процессоры                        |
|  5 | ASUS ROG MAXIMUS X HERO | Материнские платы                 |
|  6 | Gigabyte H310M S2H      | Материнские платы                 |
|  7 | MSI B250M GAMING PRO    | Материнские платы                 |
+----+-------------------------+-----------------------------------+
7 rows in set (0.00 sec)

/* ========================================================================================================
3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
Поля from, to и label содержат английские названия городов, поле name — русское.
Выведите список рейсов flights с русскими названиями городов.
======================================================================================================== */

CREATE DATABASE flights;
CREATE TABLE flights (id TINYINT, from_city VARCHAR(255), to_city VARCHAR(255));
CREATE TABLE cities  (label VARCHAR(255), name VARCHAR(255));

INSERT INTO flights VALUES
(1, 'moscow',	'omsk'),
(2, 'novgorod',	'kazan'),
(3, 'irkutsk',	'moscow'),
(4, 'omsk',		'irkutsk'),
(5, 'moscow',	'kazan');

INSERT INTO cities VALUES
('moscow',		'Москва'),
('irkutsk',		'Иркутск'),
('novgorod',	'Новгород'),
('kazan',		'Казань'),
('omsk',		'Омск');

mysql> SELECT id, (SELECT name FROM cities WHERE from_city = label) AS RU_from, (SELECT name FROM cities WHERE to_city = label) AS RU_to FROM flights;
+------+------------------+----------------+
| id   | RU_from          | RU_to          |
+------+------------------+----------------+
|    1 | Москва           | Омск           |
|    2 | Новгород         | Казань         |
|    3 | Иркутск          | Москва         |
|    4 | Омск             | Иркутск        |
|    5 | Москва           | Казань         |
+------+------------------+----------------+
5 rows in set (0.00 sec)

/* ========================================================================================================
END
======================================================================================================== */