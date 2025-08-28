-- ==========================
-- Sample Data Inserts
-- ==========================

-- 1. USERS
INSERT INTO users (name, email, password_hash, created_at) VALUES
('Alice Johnson', 'alice@example.com', 'hashed_pw_123', NOW()),
('Bob Smith', 'bob@example.com', 'hashed_pw_456', NOW()),
('Charlie Brown', 'charlie@example.com', 'hashed_pw_789', NOW()),
('Diana Prince', 'diana@example.com', 'hashed_pw_101', NOW());

-- 2. LOCATIONS
INSERT INTO locations (city, state, country) VALUES
('Lagos', 'Lagos State', 'Nigeria'),
('Nairobi', 'Nairobi County', 'Kenya'),
('Cape Town', 'Western Cape', 'South Africa'),
('Accra', 'Greater Accra', 'Ghana');

-- 3. PROPERTIES
INSERT INTO properties (user_id, location_id, title, description, price_per_night, created_at) VALUES
(1, 1, 'Beachside Apartment', '2-bedroom apartment with ocean view', 150.00, NOW()),
(2, 2, 'City Loft', 'Modern loft in downtown Nairobi', 120.00, NOW()),
(3, 3, 'Mountain Cabin', 'Rustic cabin near Table Mountain', 100.00, NOW()),
(1, 4, 'Cozy Studio', 'Affordable studio in Accra city center', 60.00, NOW());

-- 4. BOOKINGS
INSERT INTO bookings (user_id, property_id, check_in_date, check_out_date, status, created_at) VALUES
(2, 1, '2025-09-10', '2025-09-15', 'confirmed', NOW()),
(3, 2, '2025-10-01', '2025-10-05', 'pending', NOW()),
(4, 3, '2025-09-20', '2025-09-25', 'confirmed', NOW()),
(2, 4, '2025-11-01', '2025-11-03', 'canceled', NOW());

-- 5. PAYMENTS
INSERT INTO payments (booking_id, amount, status, created_at) VALUES
(1, 750.00, 'completed', NOW()),  -- 5 nights x 150
(2, 480.00, 'pending', NOW()),    -- 4 nights x 120
(3, 500.00, 'completed', NOW()),  -- 5 nights x 100
(4, 120.00, 'refunded', NOW());   -- 2 nights x 60

-- 6. REVIEWS
INSERT INTO reviews (property_id, user_id, rating, comment, created_at) VALUES
(1, 2, 5, 'Amazing stay with a beautiful ocean view!', NOW()),
(2, 3, 4, 'Modern and clean, but a bit noisy at night.', NOW()),
(3, 4, 5, 'Peaceful and cozy cabin, highly recommend!', NOW()),
(4, 2, 3, 'Good location but very small space.', NOW());

-- 7. MESSAGES
INSERT INTO messages (sender_id, receiver_id, message_text, created_at) VALUES
(2, 1, 'Hi Alice, is your apartment available in December?', NOW()),
(1, 2, 'Hi Bob, yes it is! Do you want to book?', NOW()),
(3, 2, 'Hey Bob, can you recommend places near your loft?', NOW()),
(4, 3, 'Charlie, the cabin was perfect, thanks!', NOW());
