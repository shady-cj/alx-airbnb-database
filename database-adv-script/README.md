This project demonstrates different types of SQL joins using a simple schema of users, bookings, properties, and reviews.

# Queries
1. Retrieve all bookings and their associated user
```
SELECT * 
FROM bookings 
JOIN users ON bookings.user_id = users.user_id;
```


Uses an INNER JOIN.

Returns only bookings that have a linked user.

2. Retrieve all properties and their reviews

```
SELECT * 
FROM properties 
LEFT JOIN reviews ON properties.property_id = reviews.property_id;
```

Uses a LEFT JOIN.

Returns all properties, including those without any reviews.

3. Retrieve all users and all bookings (full outer join emulation for mysql)

```
SELECT * 
FROM users 
LEFT JOIN bookings ON users.user_id = bookings.user_id
UNION
SELECT * 
FROM users 
RIGHT JOIN bookings ON users.user_id = bookings.user_id;
```

for sql servers and other sql language that supports full outer join natively
```

SELECT *
FROM users
FULL OUTER JOIN bookings
    ON users.user_id = bookings.user_id;
```


# subqueries.sql

This script contains two example SQL queries demonstrating the use of subqueries:

1. Find properties with an average rating greater than 4.0
```
SELECT * 
FROM properties 
WHERE property_id IN (
    SELECT property_id 
    FROM reviews 
    GROUP BY property_id 
    HAVING AVG(rating) > 4.0
);

```

Uses a non-correlated subquery in the WHERE clause.

The inner query groups reviews by property_id and filters those with AVG(rating) > 4.0.

The outer query retrieves all property details for those IDs.

2. Find users who have made more than 3 bookings

```
SELECT * 
FROM users 
WHERE (
    SELECT COUNT(*) 
    FROM bookings 
    WHERE bookings.user_id = users.user_id
) > 3;
```

Uses a correlated subquery.

For each user, the inner query counts their bookings.

The outer query returns users only if the count is greater than 3.


# aggregations_and_window_functions.sql

This script demonstrates two SQL techniques:

1. Aggregate with GROUP BY

```
SELECT user_id, COUNT(*) 
FROM bookings 
GROUP BY user_id;
```

Returns the total number of bookings made by each user.

2. Window functions (ROW_NUMBER, RANK)

```
SELECT property_id, booking_count, 
       ROW_NUMBER() OVER(ORDER BY booking_count) 
FROM (
    SELECT property_id, COUNT(*) AS booking_count 
    FROM bookings 
    GROUP BY property_id
) derived;
```

Counts bookings per property, then ranks properties based on total bookings received.
