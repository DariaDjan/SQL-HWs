--=============== МОДУЛЬ 3. ОСНОВЫ SQL =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;

--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выведите для каждого покупателя его адрес проживания, 
--город и страну проживания.

SELECT c.customer_id,
       ad.address,
       ct.city,
       ctr.country
FROM customer c
         JOIN address ad on c.address_id = ad.address_id
         JOIN city ct on ad.city_id = ct.city_id
         JOIN country ctr on ct.country_id = ctr.country_id
;


--ЗАДАНИЕ №2
--С помощью SQL-запроса посчитайте для каждого магазина количество его покупателей.
SELECT st.store_id,
       COUNT(c.customer_id) AS customers
FROM customer c
         JOIN store st on c.store_id = st.store_id
GROUP BY st.store_id
;

--Доработайте запрос и выведите только те магазины,
--у которых количество покупателей больше 300-от.
--Для решения используйте фильтрацию по сгруппированным строкам 
--с использованием функции агрегации.

SELECT st.store_id,
       COUNT(c.customer_id) AS customers
FROM customer c
         JOIN store st on c.store_id = st.store_id
GROUP BY st.store_id
HAVING COUNT(c.customer_id) > 300
;
-- Доработайте запрос, добавив в него информацию о городе магазина,
--а также фамилию и имя продавца, который работает в этом магазине.

SELECT st.store_id,
       COUNT(c.customer_id) AS customers,
       ct.city,
       sf.first_name,
       sf.last_name
FROM customer c
         JOIN store st on c.store_id = st.store_id
         JOIN address ad on st.address_id = ad.address_id
         JOIN city ct on ad.city_id = ct.city_id
         JOIN staff sf on st.store_id = sf.store_id
GROUP BY st.store_id,
         ct.city,
         sf.first_name,
         sf.last_name
HAVING COUNT(c.customer_id) > 300
;

--ЗАДАНИЕ №3
--Выведите ТОП-5 покупателей, 
--которые взяли в аренду за всё время наибольшее количество фильмов

SELECT c.customer_id
FROM customer c
         JOIN rental r on c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY COUNT(r.rental_id) DESC
limit 5
;

--ЗАДАНИЕ №4
--Посчитайте для каждого покупателя 4 аналитических показателя:
--  1. количество фильмов, которые он взял в аренду
--  2. общую стоимость платежей за аренду всех фильмов (значение округлите до целого числа)
--  3. минимальное значение платежа за аренду фильма
--  4. максимальное значение платежа за аренду фильма

SELECT c.customer_id,
       COUNT(r.rental_id) AS rentals,
       ROUND(SUM(amount)) AS payments,
       min(amount),
       max(amount)
FROM customer c
         JOIN rental r on c.customer_id = r.customer_id
         JOIN payment p on c.customer_id = p.customer_id
GROUP BY c.customer_id
;

--ЗАДАНИЕ №5
--Используя данные из таблицы городов составьте одним запросом всевозможные пары городов таким образом,
--чтобы в результате не было пар с одинаковыми названиями городов.
--Для решения необходимо использовать декартово произведение.


SELECT c1.city AS city1, c2.city AS city2
FROM city AS c1
         CROSS JOIN city AS c2
where c1 != c2
;

--ЗАДАНИЕ №6
--Используя данные из таблицы rental о дате выдачи фильма в аренду (поле rental_date)
--и дате возврата фильма (поле return_date), 
--вычислите для каждого покупателя среднее количество дней, за которые покупатель возвращает фильмы.

SELECT c.customer_id,
       EXTRACT(DAY FROM AVG(r.return_date - r.rental_date))
FROM customer c
         JOIN rental r on c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY c.customer_id
;


--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Посчитайте для каждого фильма сколько раз его брали в аренду и значение общей стоимости аренды фильма за всё время.


--ЗАДАНИЕ №2
--Доработайте запрос из предыдущего задания и выведите с помощью запроса фильмы, которые ни разу не брали в аренду.


--ЗАДАНИЕ №3
--Посчитайте количество продаж, выполненных каждым продавцом. Добавьте вычисляемую колонку "Премия".
--Если количество продаж превышает 7300, то значение в колонке будет "Да", иначе должно быть значение "Нет".







