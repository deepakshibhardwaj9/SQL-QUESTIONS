/*
Below are **easy visual diagrams** that show how **GROUP BY** and **WINDOW (OVER)** work on rows — using simple boxes so you can *see* the difference clearly.

---

# 🔷 1. How `GROUP BY` works (Collapses rows)
Suppose the `payment` table has:
| customer_id | amount |
| ----------- | ------ |
| 1           | 5      |
| 1           | 7      |
| 1           | 4      |
| 2           | 6      |
| 2           | 9      |
### 🔍 `GROUP BY customer_id`

```sql
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id;
```

### 📌 Diagram of processing

```
Initial rows:
[ 1 | 5 ] ┐
[ 1 | 7 ] ├── Group together (customer_id = 1) → SUM = 16
[ 1 | 4 ] ┘

[ 2 | 6 ] ┐
[ 2 | 9 ] ┘── Group together (customer_id = 2) → SUM = 15
```

### Final result after GROUP BY

```
[ 1 | 16 ]
[ 2 | 15 ]
```

✔ Rows are **collapsed/grouped**
❌ Original rows are **discarded**

-----------------------------------------------------------------------------------------------------------------------------------------------

# 🔷 2. How `OVER()` window function works (Does NOT collapse rows)
Same original rows:
| customer_id | amount |
| ----------- | ------ |
| 1           | 5      |
| 1           | 7      |
| 1           | 4      |
| 2           | 6      |
| 2           | 9      |

### 🔍 `SUM(amount) OVER()`

```sql
SELECT customer_id, amount, SUM(amount) OVER() AS total_all
FROM payment;
```

### 📌 Diagram of processing

```
Window frame = All rows in table

Total of all amounts = 5 + 7 + 4 + 6 + 9 = 31

Window SUM shows 31 alongside every row:
[ 1 | 5 | 31 ]
[ 1 | 7 | 31 ]
[ 1 | 4 | 31 ]
[ 2 | 6 | 31 ]
[ 2 | 9 | 31 ]
```

✔ Keeps **all rows**
✔ Adds window calculation column
❌ Does **not** group rows

--------------------------------------------------------------------------------------------------------------------------------------------

# 🔷 3. Window with PARTITION (like group by, but keeps rows)

```sql
SELECT customer_id, amount,
       SUM(amount) OVER(PARTITION BY customer_id) AS total_by_customer
FROM payment;
```

### 📌 Diagram of processing

```
Partition 1 (customer_id = 1):
[ 1 | 5 ] ┐
[ 1 | 7 ] ├── Sum = 16
[ 1 | 4 ] ┘

Partition 2 (customer_id = 2):
[ 2 | 6 ] ┐
[ 2 | 9 ] ┘── Sum = 15
```

### Final output

```
[ 1 | 5 | 16 ]
[ 1 | 7 | 16 ]
[ 1 | 4 | 16 ]
[ 2 | 6 | 15 ]
[ 2 | 9 | 15 ]
```

✔ Groups logically *but does not collapse* rows

---

# 🚦 Quick visual comparison

| Operation            | Result Row Count | Example         |
| -------------------- | ---------------- | --------------- |
| `GROUP BY`           | Reduced          | 5 rows → 2 rows |
| `OVER()`             | Same as input    | 5 rows → 5 rows |
| `OVER(PARTITION BY)` | Same as input    | 5 rows → 5 rows |

```
GROUP BY      →  summarizes & removes rows
OVER()        →  keeps rows & adds global summary
OVER(PARTITION BY) → keeps rows & adds group summary
```
-------------------------------------------------------------------------------------------------------------------------------------------
Absolutely! Here are **very clear visual diagrams** that show how **ROW_NUMBER(), RANK(), LAG(), and LEAD()** work on rows — using simple visuals that are easy to understand.

---

## 📌 Sample data used for all examples

| customer_id | amount |
| ----------- | ------ |
| 1           | 80     |
| 2           | 75     |
| 3           | 75     |
| 4           | 60     |
| 5           | 45     |

---------------------------------------------------------------------------------------------------------------------------------------------

## 🔹 4. `ROW_NUMBER()` — gives unique ranking (no ties)

```sql
SELECT customer_id, amount,
       ROW_NUMBER() OVER(ORDER BY amount DESC) AS row_num
FROM payment_summary;
```

### 🔍 Visual Workflow

```
Order by amount DESC:

1st → [ 1 | 80 ]
2nd → [ 2 | 75 ]
3rd → [ 3 | 75 ]
4th → [ 4 | 60 ]
5th → [ 5 | 45 ]

ROW_NUMBER assigns:
[ 1 | 80 | 1 ]
[ 2 | 75 | 2 ]
[ 3 | 75 | 3 ]
[ 4 | 60 | 4 ]
[ 5 | 45 | 5 ]
```

✔ No duplicates
❌ Ignores ties

---------------------------------------------------------------------------------------------------------------------------------------------

## 🔹 5. `RANK()` — same rank for ties (gap after tie)

```sql
SELECT customer_id, amount,
       RANK() OVER(ORDER BY amount DESC) AS rnk
FROM payment_summary;
```

### 🔍 Visual Workflow

```
Order by amount DESC:

[ 1 | 80 ]         → Rank 1
[ 2 | 75 ] ┐       → Rank 2 (tie)
[ 3 | 75 ] ┘
[   gap — skip rank 3 ]
[ 4 | 60 ]         → Rank 4
[ 5 | 45 ]         → Rank 5
```

### Final result

```
[ 1 | 80 | 1 ]
[ 2 | 75 | 2 ]
[ 3 | 75 | 2 ]
[ 4 | 60 | 4 ]
[ 5 | 45 | 5 ]
```

✔ Ties share rank
⚠ Rank numbers skip after ties

--------------------------------------------------------------------------------------------------------------------------------------------

## 🔹 6. `LAG()` — look *back* at previous row (previous value)

```sql
SELECT customer_id, amount,
       LAG(amount) OVER(ORDER BY amount DESC) AS previous_amount
FROM payment_summary;
```

### 🔍 Visual Workflow

```
[ 1 | 80 ] → previous = NULL (first row)
[ 2 | 75 ] → previous = 80
[ 3 | 75 ] → previous = 75
[ 4 | 60 ] → previous = 75
[ 5 | 45 ] → previous = 60
```

### Final result

```
[ 1 | 80 | NULL ]
[ 2 | 75 | 80 ]
[ 3 | 75 | 75 ]
[ 4 | 60 | 75 ]
[ 5 | 45 | 60 ]
```

Used to calculate difference/change from previous transaction.

----------------------------------------------------------------------------------------------------------------------------------------------

## 🔹 7. `LEAD()` — look *forward* to next row (next value)

```sql
SELECT customer_id, amount,
       LEAD(amount) OVER(ORDER BY amount DESC) AS next_amount
FROM payment_summary;
```

### 🔍 Visual Workflow

```
[ 1 | 80 ] → next = 75
[ 2 | 75 ] → next = 75
[ 3 | 75 ] → next = 60
[ 4 | 60 ] → next = 45
[ 5 | 45 ] → next = NULL (last row)
```

### Final result

```
[ 1 | 80 | 75 ]
[ 2 | 75 | 75 ]
[ 3 | 75 | 60 ]
[ 4 | 60 | 45 ]
[ 5 | 45 | NULL ]
```

Used for gap analysis / forecasting / next value comparison.

--------------------------------------------------------------------------------------------------------------------------------------------

## ⭐ Summary Table for Quick Memory

| Function       | Purpose            | Keeps all rows | Handles ties | Nulls appear |
| -------------- | ------------------ | -------------- | ------------ | ------------ |
| `ROW_NUMBER()` | Unique numbering   | ✔              | ❌            | No           |
| `RANK()`       | Ranking with ties  | ✔              | ✔            | No           |
| `LAG()`        | Previous row value | ✔              | N/A          | On first row |
| `LEAD()`       | Next row value     | ✔              | N/A          | On last row  |

-------------------------------------------------------------------------------------------------------------------------------------------

*/