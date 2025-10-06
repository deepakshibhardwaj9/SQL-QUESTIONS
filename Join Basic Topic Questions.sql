
/*QUES-> Why Compound join, self join, natural join,etc. are not part of Types of Joins.As in Types of Joins we have Inner Join, Left Join,
Right Join, Full Join. 
ANS-> The simplest way to think about it is "Fundamental Types vs. Techniques."
The Four Main Types (INNER, LEFT, RIGHT, FULL) are the core mechanisms of how SQL combines rows. They define the rules for what to do with
 matching and non-matching records.
Other Joins (SELF, NATURAL, COMPOUND) are not new mechanisms. They are special techniques or shortcuts that use one of the four fundamental
types "under the hood."
The Four Fundamental Join Types : 
These are the building blocks. They answer the question: "How should we merge rows from Table A and Table B?"
1.INNER JOIN: Returns only the rows that have matching values in both tables.
2.LEFT JOIN: Returns all rows from the left table, and the matched rows from the right table. If there's no match, the right side is NULL.
3.RIGHT JOIN: Returns all rows from the right table, and the matched rows from the left table. If there's no match, the left side is NULL.
4.FULL OUTER JOIN: Returns all rows when there is a match in either the left or the right table. It's a combination of LEFT and RIGHT JOIN
Other Joins as Techniques:
These are not new types of joins; they are different ways of using the fundamental joins.
1.SELF JOIN:
What it is: This is a technique where you join a table to itself.
How it relates: It's not a new keyword. You use a standard INNER JOIN or LEFT JOIN, but you list the same table twice with different aliases.
This is useful for finding relationships within the same table (e.g., finding employees who have the same manager).
2.NATURAL JOIN:
What it is: This is a syntactic shortcut. It automatically performs an INNER JOIN based on all columns in both tables that have the same name.
How it relates: It's just a shorthand for an INNER JOIN. Most developers avoid it because it can be unpredictable if table schemas change,
and it's less explicit than specifying the ON clause.
3.COMPOUND JOIN:
What it is: This is a join that uses more than one condition in the ON clause, linked by AND.
How it relates: It isn't a separate type. It's just a regular INNER JOIN or LEFT JOIN with a more complex condition. 
For example: ON a.id = b.id AND a.date = b.date.
*/


/*
QUES -> we join tables with ON condition, and we get the result of matching rows and this is same in Types of joins as well as in other joins.
ANS-> Imagine your Join Type (like INNER JOIN or LEFT JOIN) is a tool—for example, a hammer. A hammer's basic job is always the 
same: to hit nails.
Now, think about how you can use this one tool:
Scenario 1 (Standard Join): You can use the hammer to nail one piece of wood to a different piece of wood. This is the normal, standard 
way you'd expect to use it.
Scenario 2 (Self Join): You can also use the exact same hammer to nail a hook onto that same piece of wood.
You are right that in both cases you are "joining" things with a nail (the ON condition). But the key difference is what you are joining. 
In one case, it's two different things, and in the other, you're working on the same single thing.
A Self Join is not a different type of tool. It's just a different action or technique for using the same hammer you already know. 
This is what "same type, but with the same table" means.
*/


/*
QUES-> What is Compound Join? how it is different from self-join?
ANS-> Self Join: Comparing a Group to Itself
Imagine you have one room full of people.
Your task is to find all the people in that room who are related to someone else in the same room.
To do this, you would have to compare each person to every other person inside that single room.
This is a Self Join. You are joining a group to itself to find internal relationships.
Compound Join: Matching with Multiple Rules
Now, imagine you have two different rooms of people.
Your task is to find a pair of people (one from each room) who have the same last name AND the same hometown.
Here, you are joining two different groups, but the match is stricter because it must follow multiple rules. A last name match alone isn't enough.
This is a Compound Join. You are joining groups using more than one condition.
So, the simplest difference is:
Self Join is about comparing a group to itself.
Compound Join is about using multiple rules to compare groups.
*/


/*
QUE-> How the order of columns decide when we join two tables?
ANS-> Column order doesn’t depend on LEFT or RIGHT join — it depends on the order of tables in your query.
SELECT * FROM A LEFT JOIN B → shows A’s columns first.
SELECT * FROM A RIGHT JOIN B → still shows A’s columns first.
If you want B’s columns first, write SELECT * FROM B LEFT JOIN A.
Join type only affects which table’s unmatched rows appear, not column order
*/

/*
While JOINING the two tables, always give column names in a order in which you are joining the tables,otherwise it will not give you required result.
for example :
select * from table_a
join table_b
on table_a.column = table_b.column
*/
