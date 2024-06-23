-- 1. List all customers who live in Texas (use JOINs)
SELECT customer_id, first_name, last_name, email
FROM customer
WHERE customer_state = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT first_name, last_name, amount
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;

-- 3. Show all customers names who have made payments over $175 (use subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
);

-- 4. List all customers that live in Nepal (use the city table)
SELECT c.customer_id, c.first_name, c.last_name, c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Nepal';

-- 5. Which staff member had the most transactions?
SELECT s.staff_id, s.first_name, s.last_name, COUNT(r.rental_id) AS transaction_count
FROM staff s
JOIN rental r ON s.staff_id = r.staff_id
GROUP BY s.staff_id
ORDER BY transaction_count DESC
LIMIT 1;

-- 6. How many movies of each rating are there?
SELECT rating, COUNT(film_id) AS movie_count
FROM film
GROUP BY rating;

-- 7. Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    WHERE amount > 6.99
    GROUP BY customer_id
    HAVING COUNT(payment_id) = 1
);

-- 8. How many free rentals did our store give away?
SELECT COUNT(rental_id) AS free_rentals
FROM rental
WHERE amount = 0;
