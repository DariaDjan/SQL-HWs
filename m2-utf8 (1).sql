--=============== МОДУЛЬ 2. РАБОТА С БАЗАМИ ДАННЫХ =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;

--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выведите уникальные названия городов из таблицы городов.
SELECT DISTINCT city
FROM city;


--ЗАДАНИЕ №2
--Доработайте запрос из предыдущего задания, чтобы запрос выводил только те города,
--названия которых начинаются на “L” и заканчиваются на “a”, и названия не содержат пробелов.

SELECT DISTINCT city
FROM city
WHERE city LIKE 'L%a'
  AND city NOT LIKE '% %'
;



--ЗАДАНИЕ №3
--Получите из таблицы платежей за прокат фильмов информацию по платежам, которые выполнялись
--в промежуток с 17 июня 2005 года по 19 июня 2005 года включительно,
--и стоимость которых превышает 1.00.
--Платежи нужно отсортировать по дате платежа.

SELECT *
FROM payment
WHERE payment_date BETWEEN '2005-06-17' AND '2005-06-19'::DATE + INTERVAL '1 day'
  AND amount > 1.00
ORDER BY payment_date
;



--ЗАДАНИЕ №4
-- Выведите информацию о 10-ти последних платежах за прокат фильмов.

SELECT *
FROM payment
ORDER BY payment_date desc
limit 10

--ЗАДАНИЕ №5
--Выведите следующую информацию по покупателям:
--  1. Фамилия и имя (в одной колонке через пробел)
--  2. Электронная почта
--  3. Длину значения поля email
--  4. Дату последнего обновления записи о покупателе (без времени)
--Каждой колонке задайте наименование на русском языке.

SELECT CONCAT(first_name, ' ', last_name) AS "Имя покупателя",
       email                              AS "Почта",
       LENGTH(email)                      AS "Длина почты",
       last_update::date                  AS "Последнее обновление"
FROM customer
;

--ЗАДАНИЕ №6
--Выведите одним запросом только активных покупателей, имена которых KELLY или WILLIE.
--Все буквы в фамилии и имени из верхнего регистра должны быть переведены в нижний регистр.

SELECT customer_id,
       store_id,
       LOWER(first_name) as first_name,
       LOWER(last_name)  as last_name,
       email,
       address_id,
       activebool,
       create_date,
       last_update,
       active
FROM customer
WHERE first_name LIKE 'KELLY'
   OR first_name LIKE 'WILLIE'
;
--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выведите одним запросом информацию о фильмах, у которых рейтинг "R" 
--и стоимость аренды указана от 0.00 до 3.00 включительно, 
--а также фильмы c рейтингом "PG-13" и стоимостью аренды больше или равной 4.00.


--ЗАДАНИЕ №2
--Получите информацию о трёх фильмах с самым длинным описанием фильма.


--ЗАДАНИЕ №3
-- Выведите Email каждого покупателя, разделив значение Email на 2 отдельных колонки:
--в первой колонке должно быть значение, указанное до @, 
--во второй колонке должно быть значение, указанное после @.


--ЗАДАНИЕ №4
--Доработайте запрос из предыдущего задания, скорректируйте значения в новых колонках: 
--первая буква должна быть заглавной, остальные строчными.



