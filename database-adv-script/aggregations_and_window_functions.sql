-- a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.


SELECT user_id, COUNT(*) FROM bookings GROUP BY user_id 

-- a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.

SELECT property_id, booking_count, ROW_NUMBER() OVER(ORDER BY booking_count), RANK () OVER(ORDER BY booking_count) FROM (SELECT COUNT(*) AS  booking_count, property_id FROM bookings GROUP BY property_id) derived;
