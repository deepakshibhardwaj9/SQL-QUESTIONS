/* WHY WE NEED INDEXES WHEN WE HAVE WHERE CLAUSE AS WELL?
   Inside single WHERE Clause we give specific condition or specific address for what we need or we give the condition that there we found the result. So when we use WHERE Clause it will give us T.C. = O(1).
   But instead of WHERE clause if we need to search anything or there are multiple conditions(Between Clause, AND,OR) for searching than it took T.C. = O(N).
   So to overcome the search time, we use INDEXES, becuase Indexes use TREE MAP DATA STRUCTURE, which will reduce the search time.
   HashMap wont help us to retrieve the data, for example we have query to search 'BETWEEN 40 to 90', in this case hashmap will miss searching for decimal values, as HashMap doesnot have any functionality which can give us the range of values.
*/

/*INDEXING:
  Indexes are used to quickly retreive the data from the data than other operations. 
  Indexes uses Tree Maps Data Structure to retreive the data. 
  Indexes should create carefully, because if we write any index Extra Space is needed in Data structure due to which search in database gets slower. 
  If we add any value or update any value in data strucuture, size of data structure would change which took more time.
  
  WHEN TO CREATE THE INDEXES?
  Create the index based on the query pattern: 
  1) what columns you query the most for that column/s create the index.
  2) based on which column data should be filtered.
  
  When we create indexes based on more than one columns than first data gets sorted according to first column than data gets sorted according to second column and so on.

  Hash Index would NOT store the indexed data in sorted order.
  
  EXPLAIN keyword provides information about the query execution plan, including how indexes are used. 
*/

use sakila;

select * from address;
select * from category;
select * from film
WHERE description LIKE '%drama%';

/*INDEXING ON SINGLE COLUMN */
CREATE INDEX idx_film_filmId 
ON film (film_id);

/*FULLTEXT INDEX:
  Full-text index are used to search strings like CHAR,VARCHAR,TEXT fields.
  It helps us to give results based on keywords or phrases.
*/
CREATE FULLTEXT INDEX idx_film_titleDesc
ON film(title,description);

SELECT film_id, 
MATCH(title,description)
AGAINST ('epic' IN NATURAL LANGUAGE MODE) AS rankColumn  			-- IN NATURAL LANGUAGE MODE, is used to search the word in normal human language.
FROM film;

/*
In result for above query :
rankColumn will gives you a relevance score for each row. Higher score = better match.
Rows with 0.0 mean the row did not match the word “epic”.
This quey will search the title and description columns for the word 'epic', calculate how relevant each film is using natural keyword search,
and return the relevance score for every film.
*/

/*INDEXING ON MULTIPLE COLUMNS*/
CREATE INDEX idx_film_idReleaseYear 
ON film (film_id,release_year);
  
SHOW INDEXES FROM film;

/*UNIQUE INDEX
 Unique index will ensure that all the values in column are unique preventing any duplicay.*/
 CREATE UNIQUE INDEX idx_actor_idUpdate 
 ON actor (actor_id,last_update);		-- this is wrong index. Don’t create a composite index ONLY with ID columns if the second column will never be used in WHERE queries,
										-- because ID column is already sorted, now we can only sort it using Second column which is last_update, so we can do the sarching using WHERE Clause for last_update column. 

/**/


/*DROP INDEX*/
DROP INDEX film_index ON FILM;

 /*How Indexes are different from Primary Keys?
   Primary Keys are always Unique, while indexes may or may not be unique.
   Purpose of Primary Keys is only Uniqueness while indexes speed up the searching and indexing.
   Nulls are allowed in Indexes.
   Indexes are not auto incremented.*/
   
/*TYPES OF INDEXES : 
  1) Clustered Index : As data is stored in the clusters/blocks in memory, so Cluster Index is the Index in which cluster of data is created based on Primary Keys. 
					   One cluster will have only one Primary Key. Another Cluster will have another Primary Key.
                       
  2) Non-Clustered Index : In non-cluster Index, clusters of data is created without primary keys.
  
  Types of Cluster will help us to speed up the searching. 
  */   
  
  /*To check the performance with WHERE clause , INDEXES, etc. always cjecl the duration column in output result.*/
