/*CRUD-- 
  R--> READ DATA*/
  
/*SOME MORE OPERATORS TO READ DATA*/
/*BETWEEN OPERATOR --> when we are trying to get something in BETWEEN a particular range.*/
SELECT * FROM student_info 
WHERE courseID BETWEEN 103 AND 105;  /*in output students with courseID including 103,105 were also there.*/

/*LIKE OPERATOR ---> LIKE operator works on two particular keywords '%' and '_'. 
  '%' represents multiple characters, there is a possibility that there is a character/s present on % position or not.We use this when we are
  not sure that there is any answer present or not.
   '_' represents single character.We use this when we need exact answer.*/
SELECT * FROM student_info 
WHERE courseID LIKE '%05';
SELECT * FROM student_info 
WHERE courseID LIKE '%4';
SELECT * FROM student_info 
WHERE student_name LIKE '%shi%';

SELECT * FROM student_info
WHERE student_name LIKE'_ips_';
SELECT * FROM student_info 
WHERE courseID LIKE '_3'; -- output is empty table,because there is no courseID present with 2 characters.

/*ADD NULL VALUES IN TABLE*/
INSERT INTO student_info(student_name,enrollmentYear,courseID)
VALUES('leon','2024-04-23',103);                               -- here registeredEmail is added as null.
INSERT INTO student_info(student_name,registeredEmail,enrollmentYear,courseID)
VALUES('jazz','','2024-12-30',103);                               -- here registeredEmail is added as empty value.
SELECT * FROM student_info;

/*IS NULL OPERATOR --> we use this to fetch NULL values, but we cant use IS NULL with '=' operator, because we cant compare NULL with '='.
Null values are special case, these can be read using IS NULL operator only.*/
SELECT * FROM student_info
WHERE registeredEmail IS NULL;

/*ORDER BY ---> order by clause is used to decide the order of data in table.
  We can arrange the data in ascending or descending order according to our requirement. 
  We can arrange the distinct elements using order by clause also.
  Default Sorting is based on Primary Key in a table.*/
SELECT * FROM student_info 
ORDER BY student_name;  
SELECT * FROM student_info 
ORDER BY enrollmentYear desc;  
SELECT distinct * FROM student_info 
ORDER BY enrollmentYear;


/*LIMIT CLAUSE ---> Limit clause we use to limit the data i.e. when we dont want to see whole data, we just need some records, for example 
  we need first 20 records than we use Limit clause. 
  */
SELECT * FROM student_info 
LIMIT 5;                   -- we get first 5 records according to deafault sorting of Primary key.


/*OFFSET -->> we use OFFSET when we need to skip first N rows and want to perform operation on next rows,starting from N+1. */
SELECT * FROM student_info 
LIMIT 4 					-- fetch 4 records.
OFFSET 5; 					-- start fetching records from 6th row, according to the default sorting done by primary key,skip first 5 records.
/*Use Case of OFFSET is : 
  1. used in batches, suppose we have 100 records, we need to update all 100 records but in a way that we only get 10 records. First we query
	 first 10 records, than we need next 10 records, means we will update the table with a set of 10-10 records.
  2. suppose we want second highest salary of employee. 
	 a.Select all records.
     b.Sort the records in descending order.
     c.use LIMIT and OFFSET and fetch second highest salary of employee.*/
     
     
/*CRUD-- 
  U-- UPDATE DATA*/
/*To update the records : 
  1. find the column where we need to update.
  2. replace existing value with new value, using SET clause
We cannot use same column in where clause and SET clause.Define the where condition using any other column.*/

UPDATE student_info 
SET student_name = 'peter'
WHERE student_id =4;


/*CRUD-- 
  D--DELETE DATA*/
/* Delete data in table.
   There are  ways to delete data from a table.
   DELETE -- If we want to delete a particular row/s from a table, rows are delted one by one. 
			 No impact on structure of table. 
             We can use ROLLBACK Command to restore the deleted data.
			 If we delete records using delete command we cannot reset primary key.
   TRUNCATE -- If we want to delete everything in one go. 
			   Once the structure of table gets deleted and than recreate the structure again.
               Primary Key is reset to 1.
               No Logs were present, logs also gets deleted.
               We cannot restore the data, not even by using ROLLBACK command.
   DROP -- If we want to delete the whole table and want to delete the structutre of table than we will use Drop command.
		   We cannot recreate the structure/data,everything gets deleted, not even by using ROLLBACK command.
*/

DELETE FROM student_info 
WHERE student_id = 1;

TRUNCATE TABLE student_info;

DROP TABLE student_info;

/*Using RollBack command.*/
