-- retrieve all bookings and the user associated to them
SELECT * FROM bookings JOIN users ON bookings.user_id = users.user_id;

--  retrieve all properties and their reviews, including properties that have no reviews.
SELECT * FROM properties LEFT JOIN reviews ON properties.property_id = reviews.property_id;

-- to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user. 
-- full outer join isn't direct supported in native mysql so we'll use union

SELECT * FROM users LEFT JOIN bookings ON users.user_id = bookings.user_id
UNION
SELECT * FROM users RIGHT JOIN bookings ON users.user_id = bookings.user_id;



