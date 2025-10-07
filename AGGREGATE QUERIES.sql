use sakila;
/*AGGREGATE FUNCTIONS*/
/*Aggregate Functions are used in SQL to compute a single value from collection of input values.
Most commonly used Aggregate functions are : SUM,AVG,COUNT,MIN,MAX.*/
SELECT * FROM payment;

/*SUM*/
/*used to calculate the total sum.*/
SELECT SUM(amount)
FROM payment;

/*AVG*/
/*used to calculate average of column values,excluding NULL values.*/
SELECT AVG(amount)
FROM payment;

/*COUNT*/
/*return the number of items in a group,considering non-null values.*/
SELECT count(payment_id)
FROM payment;

/*MIN-MAX*/
/*MIN will return the smallest value,
MAX will return the largest value.*/
SELECT MIN(amount),MAX(amount)
FROM payment;

/*DISTINCT -> DISTINCT is not a Aggregate function, it is used to ignore duplicates from a table.*/
SELECT distinct customer_id
FROM payment;

/*GROUP BY Clause*/
/*Group By clause group the same values of column. 
  Group By clause first group all the columns and than perform aggregate function on them.
  These columns would be from one single table or may be from more than one table, which gets grouped into a single table using Group By
  clause and than we can apply aggregate functions to filter the desired result.*/
/*GROUP BY as creating smaller sub-tables from the main table, where you can apply aggregate functions to derive meaningful insights.*/
  
  SELECT rating,count(*) as film_count
  FROM film
  GROUP BY rating;
  
  /*HAVING CLAUSE*/
  /*Having is ued to filter groups.Groups always create its own sub-tables and to filter values from this sub-table we use HAVING.
  HAVING clause was added to SQL because the WHERE keyword could not be used with aggregate functions. HAVING allows filtering on 
  aggregated data, and it is used to apply conditions on groups created by the GROUP BY clause.*/
  SELECT rating,count(*) as film_count
  FROM film
  GROUP BY rating
  HAVING film_count>200;
  
  /*WHERE is used to filter rows.
    HAVING is used to filter groups.*/
  