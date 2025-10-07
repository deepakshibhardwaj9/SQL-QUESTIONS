/*Use DAtabase sakila*/
use sakila;

/*Read data from table.*/
SELECT * FROM film ;
SELECT * FROM film_actor;
SELECT * FROM actor;

/*ORDER OF COLUMNS DEPENDS ON HOW YOU MENTION THE TABLE_NAMES IN YOUR QUERY, ORDER DOESNOT DEPEND ON THE TYPE OF JOIN.
JOIN TYPE ONLY AFFECT THE UNMATCHING ROWS.
Types of Join(Left,Right,Inner,Full) only give us the rules only for matching and non-matching records.*/

/*LEFT JOIN*/
/* Joining the film table with the film_actor and actor tables to list all films and their associated actors, including films without any 
actors*/
SELECT *
FROM film_actor 
LEFT JOIN film
ON film.film_id = film_actor.film_id
LEFT JOIN actor
ON  actor.actor_id=film_actor.actor_id 
WHERE film_actor.film_id IS NULL;


/*RIGHT JOIN*/
/*demonstrating a RIGHT JOIN between film and film_actor to ensure all actors are listed, even if they haven't appeared in any films */
SELECT * FROM film ;
SELECT * FROM film_actor;
SELECT * FROM actor;

SELECT *                                       -- film.film_id,film.title,film_actor.actor_id
FROM film 
RIGHT JOIN film_actor 
ON film.film_id = film_actor.film_id
RIGHT JOIN actor
ON actor.actor_id = film_actor.actor_id
LIMIT 200
OFFSET 800;

/*FULL JOIN*/
/*In Full Join, it will return whole data from both the tables.
  If the condition is not matching, it will return null values otherwise it will return the matching records.*/
SELECT * 
FROM RENTAL
FULL JOIN rental
ON customer.customer_id = rental.cutomer_id;


/*INNER JOIN*/
/*Joining the film and film_category tables to retrieve film titles and their corresponding category IDs*/
SELECT film.film_id,film_category.category_id
FROM film 
INNER JOIN film_category
ON film.film_id = film_category.film_id;


/*CROSS JOIN*/
/*Cross Join is cross product, when we need all possible combinations of records than we do cross join.
  No matching condition will be added in cross join, because we are not joining the table we are only finding the possible combinations.*/
SELECT * 
FROM language
CROSS JOIN actor;


/*COMPOUND JOIN */
/*It is a normal join but it joins two tables with more than on conditions using AND clause.*/
SELECT * 
FROM film
JOIN inventory
ON film.film_id= inventory.film_id
AND inventory_id =1;


/*USING Keyword*/
/*Till now we use ON keyword to join the tables, if joining columns for both the tables are same or not. But instead of ON keyword, if the
joining column for tables are same than we can use USING keyword as well to join the tables.
USING keyword is the shortest way to join two tables.*/
SELECT * FROM film 
JOIN film_actor
ON film.film_id = film_actor.film_id;			-- using ON keyword

SELECT * FROM film
JOIN film_actor
USING (film_id);

/*NATURAL JOIN*/
/*As of now we join two tables using ON and USING keyword,but if we want SQL to smartly join two tables without explicity telling the joining
condition than we can use NATURAL join.
Now if there are more than one columns on which two tables can join, than NATURAL JOIN will first join on basics of First matching column and 
than tries to filter on second matching column, than sometimes it will be difficult for Natual Join to filter the columns and this returns 0 rows 
in result table.
So it is preferable to use normal Joins and customize the conditions to join the table instead of being independent on default filteration
done by Natural Join.*/
SELECT * 
FROM actor 
NATURAL JOIN film_actor;


/*IMPLICIT JOIN*/
/*
An Implicit Join is an older, pre-1992 syntax for joining tables. You perform an implicit join by listing multiple tables in the 
FROM clause (separated by commas) and then defining the join relationship in the WHERE clause.However, the simple answer to "when and 
why we should use it" is that you should almost always avoid it in favor of the modern, explicit JOIN syntax.
The easiest way to understand SQL JOINs is to think of them as a toolkit for combining data. The four fundamental join types 
(INNER, LEFT, RIGHT, and FULL) are your core tools, like a hammer and screwdriver, that define the basic rules for how to connect tables. 
Other joins are just special techniques for using these tools; for example, a Self Join isn't a new tool, but a technique where you use a 
standard INNER JOIN to connect a table back to itself. Older styles like Implicit and Natural joins are like rusty, outdated tools that 
should be avoided because the modern, explicit JOIN...ON syntax is much safer and clearer. Therefore, mastering joins is simply about 
knowing which of your four core tools to use and which technique to apply to solve a specific problem.
*/


/*WHERE vs ON CLAUSE*/
/*Example of WHERE clause: 
SELECT * FROM table_A
CROSS JOIN table_B
WHERE table_A.id = table_B.id;

Step I) In this example, first the temporary table will be created.
SELECT * FROM table_A
CROSS JOIN table_B
for(traverse on table_A)
{
	for(traverse on table_B)
    {
		ans[] = table_A*table_B;
	}
}
Step II) Now rows will be filtered-out using WHERE clause from ans[] array.
WHERE table_A.id = table_B.id
for(traverse in ans[])
{
	if(table_A.id = table_B.id)
    {
		print(row)
	}
}
So the T.C. to solve this will be O(N*N + N).

Example of ON clause:
SELECT * FROM table_A
JOIN table_B
ON table_A.id = table_B.id;

Step I) we will traverse through tables and while traversing ON clause will apply 'if-condition', and print the result.
for(traverse on table_A)
{
	for(traverse on table_B)
    {
		if(table_A.id = table_B.id)
        {
			print(row);
		}
	}
}
SO ON CLAUSE IS MORE EFFICIENT THAN WHERE CLAUSE.
*/