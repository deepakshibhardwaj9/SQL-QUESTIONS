/*LEVELS OF ISOLATION or TRANSACTION LEVELS*/
/*1) READ UNCOMMITED : 
	 Suppose we wrote transaction A which is ROLLBACK query. Now there are two transactions , transaction A and B.
     Transaction A is updated but not yet committed. Meanwhile transaction B executed and it reads the data which gets updated by transaction A.
     Now, Transaction B reads the uncommitted data which is invalid data, which makes the transaction invalid.
     So this scenario is called DIRTY READ.
     DIRTY READ is the lowest isolation level, occur when a transaction reads data that has been modified by another transaction but not yet committed, resulting in inconsistency if the other transaction fails.
     So Dirty Read is a issue.
*/

use sakila;
/*Examples:
transaction T1*/
set transaction isolation level read uncommitted;
select * from film where film_id = 1;
update film set release_year = 2004 
where film_id = 1;
commit;

/*T2 transaction*/ 
set transaction isolation level read uncommitted;
select * from film where film_id = 1;
commit;

/*2) READ COMMITED : 
     This is second level of isolation and according to this level, database can only read committed data. 
     This will solve Dirty Read problem. 
     Suppose we have two Transactions A and B. Now according to this transaction level, query can read only committed data. 
     Steps of Transaction A : I) SELECT * FROM revenue_table; 
							 II) SELECT SUM(revenue) FROM revenue_table;
	 Steps of Transaction B : I) UPDATE revenue_table SET quantity = 6 WHERE orderId = 3;
     
	 Now these two transactions are running parallely, when step I) of Transaction A executes, by counting mannually it gives total revenue of 2300 rupees. Meanwhile the second step executes of Transaction A, Transaction B executed and data is committed.
     When the Step II) of transaction A executed it will give us total revenue of 2900. Here arises a new issue, i.e., in same transaction we get different data from same table. This situation arrises a new issue that is called PHANTOM READS.
     This again raise a issue that is repeatable reads.
     
     To overcome this problem, one solution is print a message which will show the date-time when executing the query. Now because we are showing the date-time along with the data, this will help the user to understand the data if he get manipulated data with same tables.
     */
/*Examples :
transaction t1*/
SELECT current_timestamp() ;
set transaction isolation level read committed;
select * from actor where actor_id = 1;
update actor set first_name = 'PENELOPES'
where actor_id =1;
rollback;

/*transaction t2*/
select current_timestamp();
set transaction isolation level read committed;
select * from actor where actor_id = 1;
commit;

/*3) REPEATABLE READ : 
	 This transaction level ensures that if a transaction reads a row, it will read the same row throughout the execution. Transaction will read the same data throughout its execution,even if another transaction modified the data.
	 Repeatable read can solve the problem of non-repeatable read but still suffers from phantom read.
     Phantom Read occur when a transaction reads a set of rows matching a condition, another transaction adds or deletes rows meeting that condition, and the first transaction re-reads the condition and gets a different set of rows.
	 For Example: A transaction reads a set of rows. If another transaction inserts a new row that meets the query criteria, the first transaction will not see the new row if it's using repeatable read.
	 */
     /*Examples:
	transaction T1*/
	set transaction isolation level repeatable read ;
	select * from actor where actor_id = 2;
    update actor 
    set first_name = 'NICK JOHNAS..'
    where actor_id = 2;
    select * from actor where actor_id = 2;
    rollback;
	/*transaction T2*/
    set transaction isolation level repeatable read;
    select * from actor where actor_id = 2;
    commit;
/*4) SERIALIZABLE :
	 Serializable is the last level of isolation. Serializable means in serial order. 
     In serialization when you are reading a data from one transaction you are not allowed to add/update that data unless this transaction completes.
     Transactions are completely isolated from one another.
     In serialization, once we create a serializable transaction, a locl is created around the set of data so that no one can update it.
     So while reading any data a lock is created around the record. But if we want to create a lock around the record without reading the data than serialization wont work.
     It can be compared to locks in multithreading, where every transaction must acquire locks before proceeding, ensuring no overlaps occur
     */
     /*Transaction T1*/
     set transaction isolation level serializable ;
	select * from actor where actor_id = 2;
    update actor 
    set first_name = 'NICK'
    where actor_id = 2;
    select * from actor where actor_id = 2;
    commit;
	/*transaction T2*/
    set transaction isolation level serializable;
    select * from actor where actor_id = 2;
    commit;
    
    /*When transctions are waiting for each other to complete than this will create a deadlock situation.
     Deadlock situation is a system crashing situation.
     In deadlocks,it will create a cycle of dependency with no resolution.
     To prevent deadlock situation :
     - write queries according to pre-given content.
     - found deadlock situation, detect the cycle and resolve it, often by aborting one of the transaction and break the cycle.*/ 
