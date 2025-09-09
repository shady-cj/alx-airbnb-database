-- Write an initial query that retrieves all bookings along with the user details, property details, and payment details and save it on perfomance.sql

SELECT * FROM bookings, users, properties, payments WHERE
bookings.user_id = users.user_id AND properties.property_id = bookings.property_id
AND payments.booking_id = bookings.booking_id;

EXPLAIN ANALYZE SELECT * FROM bookings, users, properties, payments WHERE
bookings.user_id = users.user_id AND properties.property_id = bookings.property_id
AND payments.booking_id = bookings.booking_id;

CREATE INDEX bookings_user_idx ON bookings(user_id);
CREATE INDEX bookings_property_idx ON bookings(property_id);
CREATE INDEX payments_booking_idx ON payments(booking_id);

EXPLAIN ANALYZE SELECT users.name as name, bookings.booking_id, bookings.status, properties.title, payments.amount, payments.payment_method
FROM bookings
JOIN users ON
bookings.user_id = users.user_id
JOIN properties ON
properties.property_id = bookings.property_id
JOIN payments ON
payments.booking_id = bookings.booking_id;



