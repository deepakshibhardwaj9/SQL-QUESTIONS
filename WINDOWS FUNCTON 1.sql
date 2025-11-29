/*What is WINDOWS FUNCTION?
  Windows Function are used to perform the operations on a group of rows and provide a resultant value for each row.
  Windows function is just like a window, it will do the operation and give the result along the table.
  This will give us output after computing the values along with the input table.
  For example: In a given table if we want SUM(salary) than in output we recieve a single computed total sum of salaries. But if we want total salary along with the individual row than we can use Windows function.
*/
use sakila;

-- this will give us whole table.
select * from payment;

-- this will give us total amount from payment table.
select sum(amount) from payment;

-- this will give us total amount of each customer
select customer_id,sum(amount) as total_amount
from payment
group by customer_id;

-- over() is used to create the window aound the dataset. It will do the partitioning and return input table + calcuation did by query.
-- In this query, it will return the whole table and the total sum of amount in last column as a window.
select *,sum(amount) over() as total_sum 
from payment;

-- this query will work and give us columns(customer_id,total_sum), where total_sum will give us total-sum of amount via grouping customer_ids.
select customer_id,sum(sum(amount)) over() as total_sum 
from payment
group by customer_id; 


/*Difference between working flow of GROUP BY () and ORDER() Clause.
  GROUP BY() --> Group by execute earlier in the query.
				 It collapase all the records.
                 It reduces the count of rows.
                 
  OVER() -->    It execute later in SELECT statement.
				It will not collapase the records.
                It uses aggregate columns to fetch the result.
  */

-- This query will not work, because sum(amount) already calculated the values and collapse the records, amount does NOT exist anymore after GROUP BY. So 'sum(amount) over()' will not work.
select customer_id,sum(amount) as total_amount,sum(amount) over() as overall_amount
from payment
group by customer_id;

-- this query will not executed because 'sum(amount)' is already aggregated, SQL doesnot allow aggregation 'sum(sum(amount)) over() as overall_amount' on the top of another aggregation.
select customer_id,sum(amount) as total_amount,sum(sum(amount)) over() as overall_amount
from payment
group by customer_id;

-- This is the correct way of writting the query, using subqueries.
-- i.e. first compute totals per customer, then apply the window SUM
SELECT 
    customer_id,
    total_amount,
    SUM(total_amount) OVER() AS overall_amount
FROM (
    SELECT customer_id, SUM(amount) AS total_amount
    FROM payment
    GROUP BY customer_id
) AS t;

/*PARTITION BY */
SELECT customer_id,sum(amount) over(partition by customer_id)
from payment;


-- ranking functions are used in ordered result sets, such as when we need Top N result sets.
/*RANK-- it will skip the ties */
select customer_id ,amount, rank() over(order by amount desc) 
from payment;

/*DENSE_RANK-- it will not skip the rank if there is any tie.*/
select customer_id ,amount, dense_rank() over(order by amount desc) 
from payment;
  
/*ROW_NUMBER*/
select customer_id, amount,row_number() over(order by amount asc) 
from payment;

/*LEAD*/
select customer_id, amount,lead(amount) over(order by amount asc) 
from payment;

/*LAG*/
select customer_id,amount,lag(amount) over(order by amount desc) 
from payment;

-- FOPO -> Function,Over , Partition By, Order By.
-- partition by, is also making groups, so no need of group-by clause.
-- to achieve table + aggregation we need FO only
-- to achieve group wise tables we need FOP (function,over,partition by)
-- In simple queries if we want specific result we use WHERE Clause.But in Windows function, if we want filters than we can use subqueries.

-- calculate the average amount
select avg(amount) from payment;

-- Ques: Compare the individual amount with overall average amount.
select customer_id, amount, avg(amount) over() 
from payment;

-- comparet the amount of employees with overall group-wise average amount.
select customer_id,amount,avg(amount) over(partition by customer_id) as avg_amount, rank() over(  order by amount asc)
from payment;

/*show the customers who exceeds the average amount of there respective amount.
  1) we need to calculate the average salary.
  2) because we need to filter out the records, so we need where clause. But because average salary is not a direct column in input table, so we can use subqueries to make that column and than apply where clause. 
*/
select * from
(select amount, customer_id,avg(amount) over() as a_amount 
from payment) as avg_table													-- name the temporary table is important
where amount > a_amount;

-- so anytime we need to filter the windows function column always use subqueries and where clause.

/*Give the rank to payment_id's on the basis of there amount, also rank should be according to the groups of customer_id.
1) create groups according to customer-id
2) sort the amounts. 
3) give rank to the customers
*/
select customer_id,amount, dense_rank() over(partition by customer_id order by amount) 
FROM payment

-- always use dense_rank for giving rank to a group 
-- use row_number when asked to give one rank to a row only, else dont use it.

/* RUNNING TOTAL/CULUMATIVE SUM
   -For the question who asks running total/cumulative sum always use windows function.
   -to achieve that we need FOO (function , over,order by) 
   -Order by in windows function is different from order by clause we used to sort our dataset.
   -to get cumulative calculations use 'order by' inside windows's over() function.
   -for the questions, asking 'sum till now','max sum till now',etc. that all are done by just using 'order by' clause inside over().
*/

-- we can use FOPO i.e. function,over,partition by, order by according to our question.
