/*What is TRANSACTION?
  Suppose we have two users, user A and user B. Now, user A wants to transfer 500 to user B. So this transfer of money from user A to user B is called Transaction. 
  And the transaction is held via an entity. In real world transaction from user A to user B will be held via a Bank.*/
/*BASIC STEPS FOR TRANSACTION BETWEEN TWO USERS:
  1) Get Balance 
  2) Check Balance if a user has enough balance to tranfer.
  3) Debit Balance
  4) Credit Balance
*/
/*Suppose we are using any ecommerce website, multiple users are using that website and doing transactions at same time. So there is possiblity of some challanges. 
  Challanges like :
  1) Data Misplaced or Data lost when more than one user is paying at same time.
  2) System can crashed when more than one user is paying the bills.
  So to overcome such challanges we need to build logical grouping for better transaction.
*/
/*
  TRANSACTION is a set of database operations that are logically grouped together to perform a specific task. 
  TRANSACTION PROPERTIEES/ ACID PROPERTIES:
  A->Atomicity
  C->Consistency
  I->Isolation
  D->Durability
*/
/*ATOMICITY : Atomicity is like atom, means single whole unit. 
			  So when we are doing any transaction ensure that the transaction will either completely done or rejected The intermediate steps are taken care by transaction itself.
              */
              
/*CONSISTENCY : Consistency means logically, correct and accurat. 
				When we are doing any transaction the transaction should be in logically correct before and after transaction,transaction should be in correct state.
                Consistency maintains database rules as well, it ensure transaction brings in database from one valid state to another.
                */
                
/*ISOLATION : Isolation means two transactions occur independently without any interfare. 
			  Suppose user A is transferring money to user B and at same time user B is sending money to user C, so in these cases transaction should be isolated.
			  There are different levels of Isolation:
              1) Read Uncommited 
              2) Read Commited
              3) Repeatable Read
              4) Serializeable
              */
              
/*DURABILITY : Once a transaction is committed it will remain as it is, even in the event of system failure. */

/*COMMIT AND ROLLBACK TRANSACTION 
  COMMIT command : Commit command is used to save all the changes made by transaction.
					Using commit command we did permanent changes.
					 BEGIN TRANSACTION 
                     -----write your queries here
                     -----
                     COMMIT;
  ROLLBACK Command : Rollback is used to undo all the changes. 
					 Reverting the database to its previous state. 
                     BEGIN TRANSACTION 
                     -----write your queries here
                     -----
                     ROLLBACK;*/