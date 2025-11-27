/*What is WINDOWS FUNCTION?
  Windows Function are used to perform the operations on a group of rows and provide a resultant value for each row.
  Windows function is just like a window, it will do the operation and give the result along the table.
  This will give us output after computing the values along with the input table.
  For example: In a given table if we want SUM(salary) than in output we recieve a single computed total sum of salaries. But if we want total salary along with the individual row than we can use Windows function.
  
  
*/
use sakila;
select * from payment;
select sum(amount) from payment;
select customer_id,sum(amount) from payment
group by customer_id;

-- select distinct staff_id,payment_id,customer_id,rental_id, amount,sum(amount) over(partition by customer_id) as total_sal
-- from payment
-- where customer_id=2
-- order by staff_id;

-- FOPO 
-- FOMO
