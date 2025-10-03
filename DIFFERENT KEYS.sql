/*CREATE DATABASE*/
CREATE DATABASE studentsDB;

USE students;
/*CREATE SIMPLE TABLES WITHOUT ANY KEY*/
CREATE TABLE student_info 
(
student_id INT ,
student_name VARCHAR(50) NOT NULL,
registeredEmail VARCHAR(50),
enrollmentYear DATE NOT NULL, 
courseID INT NOT NULL
);

CREATE TABLE course
(
course_id INT ,
course_name VARCHAR(50) NOT NULL,
course_duration INT NOT NULL,
coursePassingMarks INT NOT NULL
);


/*show table structure*/
SHOW CREATE TABLE course;
SHOW CREATE TABLE student_info;


/*PRIMARY KEY*/
/*P.K. is shortest length column, which is easy to sort and can be unique, make that column as primary key.
set Primary keys student_id and course_id for table course and student respectively.*/

ALTER TABLE course 
ADD PRIMARY KEY(course_id);


/*FOREGIN KEY*/
/* F.K. is used to create relationship between two tables, where foreign key in child table will act as a Primary key 
in parent table*/
ALTER TABLE student_info 
ADD CONSTRAINT fk_constraint
FOREIGN KEY (courseID)
REFERENCES course (course_id);


/*SUPER KEY*/
/*super key is the key which helps to identify the row uniquely with a set of columns, but in super key we can have 
unnecessary column. As in this 'course' table i create a superKey with 'course_duration' column which is not helping with course_id to make 
the row unique,course_id column is itself a unique value.*/
ALTER TABLE course 
ADD CONSTRAINT superKey_course
PRIMARY KEY(course_id,course_duration); 


/*COMPOSITE KEY*/
/*create a composite key, when a single column is not sufficient for the uniquely idenitifying the row. No unnecessary columns 
will added in composite key to make the composite key as unique pair. 
So here, in 'student_info' table, we can combine 'registeredEmail and courseID' to uniquely identify the row.
STEPS to create composite key in same table is :
	1. alter table 
    2. mark columns with primary key 
*/
ALTER TABLE student_info
ADD CONSTRAINT compositeKey_student
PRIMARY KEY(registeredEmail,courseID);

/*STEPS for creating composite key for two different tables: 
		1) create a new Link Table 
		2) add the columns which we want to combine
		3) make both columns as primary key 
        4) mark columns in new Link table as foreign key also
*/

/*CANDIDATE KEY*/
/**/

/*
Composite Key = a key made of two or more columns together to uniquely identify a row (e.g., AuthorID + BookID).
Candidate Key = any minimal set of columns that can uniquely identify a row. There can be multiple candidate keys in a table.
*/




/*What is the need of adding unnecessary columns in super keys??
Because in database design, super keys are a broader concept - they represent all possible ways to uniquely identify a row. From this big 
set, we pick out the candidate keys, and then finally decide which one will serve as the primary key.So, you can think of super keys as the
“superset,” and candidate/composite keys as the “most efficient, trimmed-down” versions we actually use in practice.Minimal super key = candidate key.
Candidate key (if it’s made of >1 column) = composite key.
*/