
===============================================================================================

************************************************************
1. Подсчитайте средний возраст пользователей в таблице users
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
| 15 | D angelo    | 2000-05-10  | 2018-09-30 17:22:47 | 2012-06-07 05:20:15 |
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

mysql> SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS AvgAge FROM users;
+---------+
| AvgAge  |
+---------+
| 24.7600 |
+---------+
1 row in set (0.00 sec)

===============================================================================================

************************************************************
2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.
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
| 15 | D angelo    | 2000-05-10  | 2018-09-30 17:22:47 | 2012-06-07 05:20:15 |
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

mysql> SELECT DAYNAME(STR_TO_DATE(CONCAT(YEAR(NOW()),'-',MONTH(birthday_at),'-',DAY(birthday_at)), '%Y-%m-%d')) as days, COUNT(*) AS total FROM users GROUP BY days;
+-----------+-------+
| days      | total |
+-----------+-------+
| Friday    |     6 |
| Monday    |     1 |
| Saturday  |     3 |
| Sunday    |     1 |
| Thursday  |     4 |
| Tuesday   |     4 |
| Wednesday |     6 |
+-----------+-------+
7 rows in set (0.00 sec)

===============================================================================================

************************************************************
3. (по желанию) Подсчитайте произведение чисел в столбце таблицы
************************************************************

mysql> SELECT id FROM storehouses_products LIMIT 5;
+----+
| id |
+----+
|  1 |
|  2 |
|  3 |
|  4 |
|  5 |
+----+
5 rows in set (0.00 sec)

mysql> SELECT ROUND(EXP(SUM(LOG(id)))) from storehouses_products;
+--------------------------+
| ROUND(EXP(SUM(LOG(id)))) |
+--------------------------+
|                      120 |
+--------------------------+
1 row in set (0.00 sec)

