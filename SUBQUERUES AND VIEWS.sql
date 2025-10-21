use sakila;

/*SYBQUERY -> Subqueries allow SQL to handle complex queries by breaking them into smaller, more manageable parts. They follow the divide-and-conquer
strategy, using intermediate results to solve large problems by obtaining results from smaller queries.*/
/* Example : find all films that are in the 'Comedy' category. */

SELECT film_id FROM film_category 
WHERE category_id = 
(SELECT category_id FROM category WHERE name ='Comedy');

/*Subquery using IN Clause*/
/*IN Clause is used to check against a list of values. 
  The IN clause allows filtering against subquery results, checking if any result matches a condition.*/

SELECT film_id,title,description FROM film
WHERE film_id IN
(SELECT film_id FROM film_category 
WHERE category_id = 
(SELECT category_id FROM category WHERE name ='Comedy'));


/*SUBQUERY USING FROM CLAUSE*/
/*Acts as a temporary table to be used within the main query. It must be given an alias to reference throughout the query, providing 
modularity and clarity in SQL scripts.*/
