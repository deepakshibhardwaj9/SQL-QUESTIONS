/*LEVELS OF ISOLATION or TRANSACTION LEVELS*/
/*1) READ UNCOMMITED : 
	 Suppose we wrote transaction A which is ROLLBACK query. Now there are two transactions , transaction A and B.
     Transaction A is updated but not yet committed. Meanwhile transaction B executed and it reads the data which gets updated by transaction A.
     Now, Transaction B reads the uncommitted data which is invalid data, which makes the transaction invalid.
     So this scenario is called DIRTY READ.
     DIRTY READ is the lowest isolation level, when a transaction read the data which is not yet commited by another transaction.
     So Dirty Read is a issue.
*/
/*2) READ COMMITED : 
     This is second level of isolation and according to this level, database can only read committed data. 
     This will solve Dirty Read problem. 
     Suppose we have two Transactions A and B. Now according to this transaction level, query can read only committed data. 
     Steps of Transaction A : I) SELECT * FROM revenue_table; 
							 II) SELECT SUM(revenue) FROM revenue_table;
	 Steps of Transaction B : I) UPDATE revenue_table SET quantity = 6 WHERE orderId = 3;
     
	 Now these transactions are running parallely, when step I) of Transaction A executes, it gives total revenue of 2300 rupees. Meanwhile the second step executes of Transaction A, Transaction B executed and data is committed.
     When the Step II) of transaction B executed it will give us total revenue of 2900. Here arises a new issue, i.e., in same transaction we get different data from same table. This situation arrises a new issue that is called PHANTOM READS.
     To overcome this problem, one solution is print a message which will show the date-time when executing the query. By showing the date-time before the result, user will not confuse if he will get different results from same transaction.
     */
/*3) REPEATABLE READ
	 */
/*4) SERIALIZABLE*/