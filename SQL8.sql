-- Labs 8

-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.

SELECT title,length, dense_rank() over (order by length desc) as 'Rank'
FROM sakila.film
WHERE length is not null and length <> " ";

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, rating and the rank.

SELECT title,length,rating, dense_rank() over (partition by rating order by length desc) as 'Rank'
FROM sakila.film
WHERE length is not null and length <> " ";

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query.

SELECT name, count(film_id)
FROM sakila.category as category_table 
JOIN sakila.film_category as film_category_table on category_table.category_id = film_category_table.category_id
GROUP BY name
ORDER BY count(film_id) desc;


-- 4. Which actor has appeared in the most films?

SELECT actor_table.first_name, actor_table.last_name, actor_table.actor_id, count(film_actor_table.film_id), dense_rank() over (order by count(film_id) desc) as 'Rank' 
FROM sakila.actor as actor_table
JOIN sakila.film_actor as film_actor_table on actor_table.actor_id = film_actor_table.actor_id
GROUP BY actor_id,first_name,last_name
ORDER BY 'Rank'
LIMIT 1;


-- 5. Most active customer (the customer that has rented the most number of films)

SELECT customer_table.first_name, customer_table.last_name, rental_table.customer_id, count(rental_table.rental_id), dense_rank() over (order by count(rental_table.rental_id) desc) as 'Rank'
FROM sakila.rental as rental_table
JOIN sakila.customer as customer_table on rental_table.customer_id = customer_table.customer_id
GROUP BY customer_id,first_name,last_name
ORDER BY 'Rank'
LIMIT 1;

-- Bonus:

SELECT film_table.title, rental_table.rental_date, dense_rank() over (order by count(rental_table.rental_date) desc) as 'Rank'
FROM sakila.film as film_table 
JOIN sakila.inventory as inventory_table on film_table.film_id = inventory_table.film_id
JOIN sakila.rental as rental_table on inventory_table.inventory_id = rental_table.inventory_id
GROUP BY title, rental_date
ORDER BY 'Rank';

-- Bonus not working...







