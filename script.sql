-- Задание 1

SELECT s.store_id, CONCAT(s2.first_name, ' ', s2.last_name) as FIO_manager, a.district, COUNT(c.customer_id)as having_customers
FROM store s 
JOIN staff s2 on s2.store_id = s.manager_staff_id 
JOIN address a on a.address_id = s.address_id
JOIN customer c ON c.store_id = s.store_id 
GROUP BY s.store_id, CONCAT(s2.first_name, ' ', s2.last_name) 
HAVING COUNT(c.customer_id) > 300;


-- Задание 2

SELECT COUNT(f.film_id) 
FROM film f
WHERE f.`length` > (SELECT AVG(film.`length`) from film) ;


-- Задание 3

SELECT MONTH (p.payment_date) as month, SUM(p.amount) as sum_amount, COUNT(p.payment_id) as count_sales
FROM payment p
WHERE MONTH (p.payment_date) IN (
	SELECT MONTH (p2.payment_date) 
	FROM payment p2 
	GROUP BY MONTH (p2.payment_date)
)
GROUP BY MONTH(p.payment_date)
ORDER BY SUM(p.amount) DESC 
LIMIT 1;


-- Задание 4*

SELECT r.staff_id, COUNT(r.rental_id) as sales,  
CASE
WHEN COUNT(r.rental_id) > 8000 THEN 'YES'
WHEN COUNT(r.rental_id) < 8000 THEN 'NO'
ELSE 'YES'
END AS Bonus
FROM rental r 
WHERE r.staff_id = 1
UNION
SELECT r1.staff_id, COUNT(r1.rental_id) as sales, 
CASE
WHEN COUNT(r1.rental_id) > 8000 THEN 'YES'
WHEN COUNT(r1.rental_id) < 8000 THEN 'NO'
ELSE 'YES'
END AS Bonus
FROM rental r1 
WHERE r1.staff_id = 2;

-- Задание 5*

SELECT f.title, r.rental_id 
FROM film f
LEFT JOIN inventory i ON i.film_id = f.film_id
LEFT JOIN rental r ON r.inventory_id = i.inventory_id
WHERE r.rental_id IS NULL;

