# My ERD Design (3NF)

## 1. First Normal Form (1NF)
- All attributes are **atomic** (no repeating groups or arrays).  
- Each entity represents a **single subject**:  
  - `USER` stores user details.  
  - `PROPERTY` stores property details.  
  - `PAYMENT` stores payment details, etc.  
- No redundant repeating columns exist.  

✅ My design satisfies **1NF**.

---

## 2. Second Normal Form (2NF)
- Each table has a **clear primary key**.  
- Every non-key attribute depends on the **whole primary key**:  
  - In `BOOKING`, attributes like `check_in_date` and `check_out_date` depend entirely on `booking_id`, not on just `user_id` or `property_id`.  
  - In `PAYMENT`, attributes depend entirely on `payment_id`.  
  - In `REVIEW`, attributes depend entirely on `review_id`.  

✅ My design satisfies **2NF** by eliminating partial dependency.

---

## 3. Third Normal Form (3NF)
- There are **no transitive dependencies** (non-key attributes do not depend on other non-key attributes).  
- To achieve this:  
  - `LOCATION` is separated from `PROPERTY` → avoids redundant storage of city, state, and country.  
  - `BOOKING` links `USER` and `PROPERTY` without duplicating details.  
  - `PAYMENT` links to `BOOKING`, avoiding user/property redundancy.  
  - `REVIEW` connects `USER` and `PROPERTY`, ensuring reviews stay linked without duplication.  
  - `MESSAGE` links users by IDs (sender and receiver) instead of copying user details repeatedly.  

✅ Every non-key attribute depends **only on its table’s primary key**.

