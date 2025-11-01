/*Use DAtabase sakila*/
use sakila;

/*JOIN*/
/*JOIN is used to fetch the data from more than one tables.
  We use JOIN keyword to join one table with another table.
  And as we will get the records from more than one table only if the records are same, and that matching condition we defined in ON Clause.*/
SELECT * 
FROM film_actor
JOIN actor
ON actor.actor_id = film_actor.actor_id;

/*We can fetch the required columns from both the tables using joins.
  We can use alias as well.*/
SELECT fa.film_id,a.first_name,a.last_name
FROM film_actor fa
JOIN actor a
ON a.actor_id = fa.actor_id;

/*Select film title and actor name who worked in films.*/
SELECT f.title,a.first_name
FROM film f
JOIN film_actor fa
ON f.film_id = fa.film_id
JOIN actor a 
ON fa.actor_id = a.actor_id;


/*SELF JOIN*/
/*Self Join is a type of join used to join a table with itself.
  Sometime we need to compare data, which is present in same table, than we use Self-Join.*/

/*Use Case of Self Join:
  Suppose we want to fetch the students which are working as a Teacher Assistant as well. Every student has a student_id, and if the 
  student works as a assistant teacher than it will have a teacher_id as well.
  Now fetch the students who has its teacher_id and student_id as well.
*/
  

/*SECOND EXAMPLE*/
SELECT * FROM film;

SELECT *
FROM film f
JOIN fIlm f1
ON f.film_id = f1.film_id;


/*Read data from tables*/
SELECT * FROM store;
SELECT * FROM staff;
SELECT * FROM address;select * from film;
