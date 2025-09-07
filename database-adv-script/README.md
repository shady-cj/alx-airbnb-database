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
