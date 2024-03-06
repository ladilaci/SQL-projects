-- 

SELECT * FROM address

-- 

SELECT first_name, last_name, email FROM customer

-- 

SELECT * FROM payment
ORDER BY customer_id, amount DESC

--

SELECT first_name, last_name, email FROM customer
ORDER BY last_name DESC, 1 DESC

--

SELECT DISTINCT rating, rental_duration FROM film

--

SELECT DISTINCT amount FROM payment
ORDER BY amount DESC

--

SELECT * FROM rental
ORDER BY rental_date DESC
LIMIT 10

--

SELECT COUNT(DISTINCT first_name) FROM customer

-- Create a list of all the distinct districts customers are from!

SELECT DISTINCT district FROM address

-- What is the latest rental date?

SELECT rental_date FROM rental
ORDER BY rental_date DESC
LIMIT 1

-- How many films does the company have?

SELECT COUNT(film_id) FROM film

-- How many distinct last names of the customers are there?

SELECT COUNT(DISTINCT last_name) FROM customer

-- How many payment were made by the customer with customer_id = 100?

SELECT COUNT(*) FROM payment
WHERE customer_id = 100

-- What is the last name of our customer with first name 'ERICA'?

SELECT first_name, last_name FROM customer
WHERE first_name = 'ERICA'

-- 

SELECT * FROM payment
WHERE amount > 10.99

-- 

SELECT * FROM payment
WHERE amount != 10
ORDER BY amount DESC

-- How rentals have not been returned yet

SELECT COUNT(*) FROM rental
WHERE return_date IS NULL

-- How for a list of all the payment_ids with an amount less than or equal to $2. Include payment_id and the amount.

SELECT payment_id, amount FROM payment
WHERE amount <= 2
ORDER BY amount DESC

-- A list of all the payment of the customer 322, 346 and 3554 where the amount is either less than $2 or greater than $10

SELECT * FROM payment
WHERE (customer_id = 322
OR customer_id = 346
OR customer_id = 354)
AND (amount < 2
OR amount > 10)
ORDER BY customer_id, amount DESC

--

SELECT payment_id, amount FROM payment
WHERE amount BETWEEN 1.99 AND 10.99

SELECT * FROM rental
WHERE rental_date BETWEEN '2005-05-24' AND '2005-05-26 23:59'
ORDER BY rental_date DESC

-- How many payments have been made on January 26th and 27th 2020 with an amount bezween 1.99 and 3.99?

SELECT COUNT(*) FROM payment
WHERE amount BETWEEN 1.99 AND 3.99
AND payment_date BETWEEN '2020-01-26' AND '2020-01-27 23:59'

--

SELECT * FROM customer
WHERE customer_id IN (123 ,212 ,323 ,243 ,353 ,432)

--

SELECT * FROM payment
WHERE customer_id IN(12, 25, 67, 93, 124, 234)
AND amount IN(4.99, 7.99, 9.99)
AND payment_date BETWEEN '2020-01-01' AND '2020-01-31 23:59'

--

SELECT * FROM actor
WHERE first_name LIKE '_A%'

SELECT * FROM actor
WHERE first_name NOT LIKE '%A%'

SELECT * FROM film
WHERE description LIKE '%Drama%'
AND title LIKE '_T%'

-- How many movies are there that contain the "Documentary" in the description?

SELECT COUNT(*) FROM film
WHERE description LIKE '%Documentary%'

-- How many customers are there with a first name that is 3 letters long and either an 'X' or a 'Y' as the last letter in the last name?

SELECT COUNT(*) FROM customer
WHERE first_name LIKE '___'
AND (last_name LIKE '%X'
OR last_name LIKE '%Y')

-- How many movies are there that contain 'Saga' in the desription and where the title starts either with 'A' or ends with 'R'?

SELECT COUNT(*) AS no_of_movies FROM film
WHERE description LIKE '%Saga%'
AND (title LIKE 'A%'
OR title LIKE '%R')

-- Create a list of all customers where the first name contains 'ER' and has an 'A' as the second letter.

SELECT * FROM customer
WHERE first_name LIKE '%ER%'
AND first_name LIKE '_A%'
ORDER BY last_name DESC

-- How many payments are there where the amount is either 0 or is between 3.99 and 7.99 and in the same time has happened on 2020-05-01

SELECT COUNT(*) FROM payment
WHERE (amount = 0
OR amount BETWEEN 3.99 AND 7.99)
AND payment_date BETWEEN '2020-05-01' AND '2020-05-02'

--

SELECT SUM(amount), ROUND(AVG(amount), 3) AS avarage FROM payment

-- Minimum, maximum, avarage (rounded), sum of the replecement cost of the films

SELECT
	MIN(replacement_cost),
	MAX(replacement_cost),
	ROUND(AVG(replacement_cost), 3) AS AVG,
	SUM(replacement_cost)
FROM film

--

SELECT 
	customer_id,
	SUM(amount),
	MAX(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount)

-- Which of the two employees (staff_id) is responsibel for more payments?

SELECT 
	staff_id,
	SUM(amount),
	COUNT(*)
FROM payment
GROUP BY staff_id

-- Which of the two is responsible for a higher overall payment amount?

SELECT 
	staff_id,
	SUM(amount),
	COUNT(*)
FROM payment
GROUP BY staff_id
ORDER BY 2 DESC

-- How do these amounts change if we don't consider amounts equal to 0?

SELECT 
	staff_id,
	SUM(amount),
	COUNT(*)
FROM payment
WHERE amount != 0
GROUP BY staff_id

-- Which employee had the highest sales amount in a single day?

SELECT
	staff_id,
	SUM(amount),
	DATE(payment_date),
	COUNT(*)
FROM payment
GROUP BY staff_id, DATE(payment_date)
ORDER BY SUM(amount) DESC, COUNT(*) DESC
	

-- Which employee had the most sales in a single day?

SELECT
	staff_id,
	SUM(amount),
	DATE(payment_date),
	COUNT(*)
FROM payment
WHERE amount != 0
GROUP BY staff_id, DATE(payment_date)
ORDER BY SUM(amount) DESC, COUNT(*) DESC

--

SELECT
	customer_id,
	SUM(amount)
FROM payment
GROUP BY customer_id
Having SUM(amount)>200

-- What is the avarage payment amount grouped by customer and day?

SELECT
	ROUND(AVG(amount), 2) AS avg,
	customer_id,
	DATE(payment_date),
	COUNT(*)
FROM payment
WHERE DATE(payment_date) IN ('2020-04-28', '2020-04-29', '2020-04-30')
GROUP BY customer_id, DATE(payment_date)
HAVING COUNT(*)>3
ORDER BY 3 DESC
	





