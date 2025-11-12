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
/*Acts as a temporary table to be used within the main query. It must be given an alias to reference throughout the query, providing 
modularity and clarity in SQL scripts.*/
