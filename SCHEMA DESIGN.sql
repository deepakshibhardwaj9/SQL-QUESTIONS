/*WHAT IS SCHEMA?
  Design of database is called schema.
  Schema composing of tables,rows,columns,keys,indexing,etc.
  */
/*HOW TO DESIGN A SCHEMA?
  To design a schema, we need to 
  - Create Table.
  - Create rows and columns for the table.
  - Create primary/foreign keys in table. 
  Tables names should be in plural-noun form, where as Attributes in these tables should have singular name. 
  */

/*CARDINALITY: 
  -Cardinality represents the relationship between two datasets.
  -Cardinality of table is assigned in two steps:
   1) 1 instance of left table will have how many instance on right-table.
   2) 1 instance of right table will have how many instances on left table.
  -Types of relationship to represent Cardinality :
   1) One to One (1:1) - Single record in Table A related to single record in Table B and vice-versa.
   2) One to Many (1:M) - Single record in Table A relates to more than one records in Table B.And, each record in Table B relates to single record in Table A.
   3) Many to Many (N:M) - Each record in Table A relates to more than one record in Table B , and , each record in Table B relates to more than one records in Table B also.
*/


/*HOW TO CARDINALITIES WILL MODIFY THE TABLES? // MAPPING TABLES 
  -Suppose we have two tables, now to create a relationship between these two tables we need cardinality of two tables as 1:M or M:N
  -Now for 1:M Cardinality, add the primary key of one table into another table in such a way that duplicate records are not created.
  -For M:N Cardinality, because if we add primary key of one table into another table than it will create duplicate records. So for M:M cardinality we need Mapping table.
  -In Mapping table we will add primary keys of both the tables, which will uniquely identify the records, so no duplicacy.
  -For example: 
   We have two tables Orders(order_ID,Name,Address,PinCode) and Products(Product_ID,Name,brand_Name) table. 
   Now a single product can be in many orders,simillarly, in one product can be more than one orders. 
   So cardinality between two tables is M:N. 
   If we add order_ID in Products table than for same product there are list of orders which buy same product, and this will create duplicate records for same product_id. Simillarly if we add Product_ID in orders table, for one order there can be more than one products, so primary key will be duplicated.
   As primary keys are always unique, so to avoid this we will create mapping table. 
  -Mapping Table will create a composite key, which will help us to uniquely identify each record, easy to maintain.
  -Mapping Table creates Composite key using the Primary Key of Table A and Primary key of Table B.
  -It maintains proper comparison and syncronization of data recods.
  
*/

/*SPARSE RELATIONSHIP:
  We have Student(studentId,name,class,mentorID) and Mentor(mentorId,name,experience) Table in a caoching centre. Students can join the course via a master-class or via purchasing a course. But mentors are only assigned to those students who buy the course. 
  So,suppose we have 1000 students but mentors are assigned only to 600 students, that means NULL value is assigned to 400 students in mentorID column and in this case records with NULL value gets wasted.
  Therefore, according to sparse relationship, records with some value in mentorID column will only added in mapping table else records with NULL values wont be added to utilize the space.
  So, sparse relationship will occur when numerous null values bloat the data storage space in database. 
  Introducing Intermediate Table or Mapping Table will help us to rectify this by M:N relationship without needless null values.
  */