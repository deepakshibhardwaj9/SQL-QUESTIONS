/*C- CREATE */
/*create data in table*/
CREATE TABLE student_info_cc
(
student_id INT NOT NULL AUTO_INCREMENT,
student_name VARCHAR(50) NOT NULL,
registeredEmail VARCHAR(50),
enrollmentYear DATE NOT NULL, 
courseID INT ,

PRIMARY KEY (student_id),
FOREIGN KEY (courseID) 
REFERENCES  course (course_id)
);
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
INSERT INTO student_info(student_name,registeredEmail,enrollmentYear,courseID)
VALUES('deepakshi','deepakshi@gmail.com','2024-10-10',105);

/*R- READ*/
/*READ the structure of table*/
show create table student_info;
/*Read data from tables*/
select * from course;
select * from student_info;
/*Read distinct values from one column of a table. */
SELECT distinct student_name 
FROM student_info;
/*Read multiple distinct values from a table.*/ 
SELECT DISTINCT student_name,courseID 
FROM student_info;
/*Copy data from one table to another.
 1. Create one new copy table i.e. student_info_cc
 2. using select and insert statement add values from one table to another. */
CREATE TABLE student_info_cc
(
student_id INT NOT NULL AUTO_INCREMENT,
student_name VARCHAR(50) NOT NULL,
registeredEmail VARCHAR(50),
enrollmentYear DATE NOT NULL, 
courseID INT ,

PRIMARY KEY (student_id),
FOREIGN KEY (courseID) 
REFERENCES  course (course_id)
);
INSERT INTO student_info_cc
SELECT * FROM student_info;
SELECT * FROM student_info_cc;

/*WHERE CLAUSE--> it is similar to if-condition we applied in coding, i.e. if the condition matches print the value otherwise do not print 
  the value.
  We can use AND, OR, NOT with WHERE clause as well.*/
SELECT * FROM student_info 
WHERE courseID =105;

SELECT * FROM student_info 
WHERE courseID = 105 && student_id = 7;

SELECT * FROM student_info 
WHERE courseID = 105 || student_id = 7;

SELECT * FROM student_info 
WHERE courseID !=105;

/*IN OPERATOR---> is used to read the data which belongs to particular defined set of things.*/
SELECT * FROM student_info 
WHERE courseID IN(105,103);

/*NOT IN OPERATOR ---> is used to read the data which does not belong to a defined set.*/
SELECT * FROM student_info
WHERE courseID NOT IN(104,105);
