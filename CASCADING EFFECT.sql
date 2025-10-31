/*Create a databse students AND USE IT */
CREATE DATABASE students;
USE students;
/* Create tables in students database,tables would be student_info,courses*/

/* course table has information about different courses, 
it has course_id as primary key */
CREATE TABLE course
(
course_id INT PRIMARY KEY,
course_name VARCHAR(50) NOT NULL,
course_duration INT NOT NULL,
coursePassingMarks INT NOT NULL
);

/* student_info has columns student_id,email,enrollment_year,cousrse_id;
where student_id is primary key, enrollment_year cant be null, course_id is foreign key from Courses table.*/
CREATE TABLE student_info 
(
student_id INT PRIMARY KEY,
student_name VARCHAR(50) NOT NULL,
registeredEmail VARCHAR(50),
enrollmentYear DATE NOT NULL, 
courseID INT NOT NULL,
FOREIGN KEY (courseID) REFERENCES course(course_id)
);

/*ALTER THE tables to set PRimary keys on AUTO Increment*/

ALTER TABLE student_info
MODIFY student_id INT AUTO_INCREMENT;

/*Here we restart/reset the key value for auto-increment */
ALTER TABLE course AUTO_INCREMENT = 101;

/*DELETE AUTO_INCREMENT, we set the coulumn to int only  */
ALTER TABLE course 
MODIFY course_id INT PRIMARY KEY;  

/*add values to the table*/
INSERT INTO course (course_id,course_name,course_duration,coursePassingMarks)
VALUES(101,'Data Structures and Algorithm',6,75);
INSERT INTO course (course_id,course_name,course_duration,coursePassingMarks)
VALUES(102,'SQL',2,70);
insert into course
values(103,'LLD',3,80);
insert into course
values(104,'LLD-1',2,80);
insert into course
values(105,'HLD',3,80);

INSERT INTO student_info(student_name,registeredEmail,enrollmentYear,courseID)
VALUES('deepakshi','deepakshi@gmail.com','2024-10-10',101);
INSERT INTO student_info(student_name,registeredEmail,enrollmentYear,courseID)
VALUES('Shivam','shivam@gmail.com','2024-09-29',101);
INSERT INTO student_info(student_name,registeredEmail,enrollmentYear,courseID)
VALUES('eipsa','eipsa@gmail.com','2024-02-01',102);
INSERT INTO student_info(student_name,registeredEmail,enrollmentYear,courseID)
VALUES('eipsafff','eipsa@gmail.com','2024-02-01',102);
INSERT INTO student_info(student_name,registeredEmail,enrollmentYear,courseID)
VALUES('MONIKA','monika@gmail.com','2024-02-02',104);
INSERT INTO student_info(student_name,registeredEmail,enrollmentYear,courseID)
VALUES('adhiraj','adhi@gmail.com','2024-02-05',103);
INSERT INTO student_info(student_name,registeredEmail,enrollmentYear,courseID)
VALUES('harshita','harshi@gmail.com','2024-02-01',105);


/*
delete multiple records with same where clause
*/
DELETE FROM student_info
WHERE student_id =1;
DELETE FROM student_info
WHERE student_id IN (2,3);

/*APPLY ON CASCASE on already existing table i.e. course
1. delete the constraints which are already applied on column
2. alter the table and apply the constraint which you deleted + add ON UPDATE CASCADE ON DELETE CASCADE 
*/

/*show the structure of table,because we need to know the foreign key constraint, which is created by default, as we didnot create it ourself.*/
SHOW CREATE TABLE student_info; 

/*drop the foreign key constraint*/
ALTER TABLE student_info
DROP CONSTRAINT student_info_ibfk_1;

/*ADD on cascade on foreign key in child table And set null values when deleting*/
ALTER TABLE student_info 
ADD CONSTRAINT onCascadeConstraint_courseID
FOREIGN KEY (courseID) 
REFERENCES course (course_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

/*
DELETE a value from course table (parent Table) and along with it values from child table gets deleted as well deleted because we apply cascasde functionality.
The ON CASCADE functionality works on the parent table to propagate changes to the child table. When you perform a DELETE or UPDATE operation on a row in the parent table, the ON CASCADE constraint automatically applies the same change to 
the corresponding rows in the child table(s) to maintain referential integrity.
*/
/*REFRENTIAL INTEGRITY, it is a database constraint that ensures the relationship between child table and parent table remains consistent,validating the foreign key values. It will check that every foreign key value in child table must have its
matching value in parent table.*/


delete from course where course_id = 102;

/* 
In MySQL we can’t use SET DEFAULT with foreign keys (only CASCADE, SET NULL, RESTRICT, NO ACTION are allowed).
If we need a default value, either:
Define a DEFAULT for the column and handle it with a trigger, or manage it in your application logic.
Direct ON DELETE/UPDATE SET DEFAULT isn’t supported in MySQL
*/


/*Retrieve the data from tables.*/
SELECT * FROM student_info;
SELECT * FROM course;
