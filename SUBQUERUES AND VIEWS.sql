use sakila;

/*SUBQUERY -> Subqueries allow SQL to handle complex queries by breaking them into smaller, more manageable parts. They follow the divide-and-conquer
strategy, using intermediate results to solve large problems by obtaining results from smaller queries.*/
/* Example : find all films that are in the 'Comedy' category. */

SELECT film_id FROM film_category 
WHERE category_id = 
(SELECT category_id FROM category WHERE name ='Comedy');

/*We can write same query using JOINS.*/
SELECT *
FROM film_category f
JOIN category c
ON f.category_id = c.category_id
WHERE c.name ='Comedy';

/*
Question here is, when we can fetch same result using SubQueries and JOINS, than what is the difference between them??
Answer-> Time complexity of subQueries to fetch the data is more than Joins, as in subqueries, database traverse each record twice, one for
main query and second time for subquery. So time complexity of SubQueries is O(N^2) in worst case.
Question -> How to decide which to use Joins or Subquery?
Answer	 -> According to me,if using joins we can write the query easily than wrote it else write the query using subQueires.
*/
/*Subqueries will always return single value or single row or single column or single table, while Joins can return more than one values.
  Because in subqueries main query cannot handle more than one comparision values in subQuery. */

/*IN CLAUSE :
  IN operator allows us to specify multiple values in WHERE clause. 
  NOT IN Operator will return all the records which are NOT present in the list of values given in WHERE clause.
*/ 
SELECT * FROM film;

SELECT * 
FROM film 
WHERE rental_duration IN (5,7);
  
/*SUBQUERIES using IN Clause*/
/*
  Simillary, in subqueries IN clause is used to filter the records inside WHERE Condition.
  IN Clause is used to check against a list of values.
  The IN clause allows filtering against subquery results, checking if any result matches a condition.It will retrn all the records from main 
  query that are present in subquery.
*/

-- select film_id,title,description of films whoes category is Comedy;
SELECT film_id,title,description FROM film
WHERE film_id IN
(SELECT film_id FROM film_category 
WHERE category_id = 
(SELECT category_id FROM category WHERE name ='Comedy'));


/*SUBQUERY USING FROM CLAUSE*/
/*FROM clause in general used as a Value Provider, it is used in Select,Where,Having statements.*/
/*Use of simple FROM clause:-> */
SELECT * FROM film;
SELECT * FROM film 
WHERE rental_duration =6;

/*Similary FROM clause in SubQueries will help to fetch the result from a temporary table, which is created inside FROM clause.*/
SELECT * FROM film;
SELECT * FROM category;
SELECT * FROM film_category;

/*Select films with category Action.*/
SELECT * FROM film
WHERE film_id
IN (SELECT film_id FROM film_category 
WHERE category_id IN 
(SELECT category_id FROM category
WHERE name = 'Action'));

/*Subqueries using FROM clause are generally used with aggregate functions,although we can use FROM Clause except this.
  Whenever you use FROM clause in subqueries always provide an alias to the temporary table, as this is the syntax for this.*/
/*Example : Finding the average number of rentals per customer.*/
select * from rental; 				-- select count(inventory_id),customer_id from rental group by customer_id limit 10;

SELECT AVG(rental_count) 
FROM
(SELECT customer_id, COUNT(rental_id) AS rental_count
    FROM rental
    GROUP BY customer_id
) as customer_rental_table;								-- give a name to the column which we fetched out of subQuery,else if we dont give any name to the data which we fetced, the data wont procced futher for upcoming calculations in main query.

/*ALL and ANY KEYWORDS*/
/* ALL -->  -The result which we get from subQuery, ALL will check if the condition holds true for all the values.
			-The ALL operator:
				returns a boolean value as a result.
				returns TRUE if ALL of the subquery values meet the condition.
				used with SELECT, WHERE and HAVING statements.
			ALL means that the condition will be true only if the operation is true for all values in the range.
*/
/*ANY --> The result which we get from subQuery, ANY will check if the condition holds true for any of the values.*/

/*List all movies that have a budget greater than the budget of any movie in the Action genre.*/

use imdb_movies_dataset;

SELECT * FROM movies 
WHERE movie_id = ANY
(SELECT movie_id 
FROM movie_genres 
WHERE genre_id IN(
SELECT genre_id FROM genres
WHERE genre_name ='Action'));

/*UNION CLAUSE 
  Union will combine the results of all tables in single row but skip the duplicate values.
  If we want duplicate values in our result set than use UNION ALL.*/
  SELECT actor_name FROM actors
  UNION 
  SELECT director_name FROM directors
  UNION
  SELECT title FROM movies;
  
/*CORELATED QUERIES:
A correlated subquery is a subquery that depends on values from the outer query. Unlike a regular (non-correlated) subquery, it is 
evaluated once for every row in the outer query. This makes correlated subqueries dynamic and highly useful for solving complex database 
problems like row-by-row comparisons, filtering, and conditional updates.
*/
/*Finding customers who have paid more than average payment in their respective stores.*/

  
/*EXISTS KEYWORD

*/
  
/*VIEWS

*/
