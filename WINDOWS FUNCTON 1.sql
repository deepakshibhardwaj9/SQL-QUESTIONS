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
