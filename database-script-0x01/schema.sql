-- ==========================
-- USERS TABLE
-- ==========================
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================
-- LOCATIONS TABLE
-- ==========================
CREATE TABLE locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    country VARCHAR(100) NOT NULL
);

-- ==========================
-- PROPERTIES TABLE
-- ==========================
CREATE TABLE properties (
    property_id INT PRIMARY KEY AUTO_INCREMENT,
    owner_id INT NOT NULL,
    location_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    price_per_night DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Foreign Keys
    CONSTRAINT fk_property_owner FOREIGN KEY (owner_id) REFERENCES users(user_id),
    CONSTRAINT fk_property_location FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- ==========================
-- BOOKINGS TABLE
-- ==========================
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    status ENUM('pending', 'confirmed', 'cancelled') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Foreign Keys
    CONSTRAINT fk_booking_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_booking_property FOREIGN KEY (property_id) REFERENCES properties(property_id)
);

-- ==========================
-- PAYMENTS TABLE
-- ==========================
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('credit_card', 'paypal', 'bank_transfer') NOT NULL,
    status ENUM('pending', 'completed', 'failed') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Foreign Key
    CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- ==========================
-- REVIEWS TABLE
-- ==========================
CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Foreign Keys
    CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_review_property FOREIGN KEY (property_id) REFERENCES properties(property_id)
);

-- ==========================
-- MESSAGES TABLE
-- ==========================
CREATE TABLE messages (
    message_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    content TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Foreign Keys
    CONSTRAINT fk_message_sender FOREIGN KEY (sender_id) REFERENCES users(user_id),
    CONSTRAINT fk_message_receiver FOREIGN KEY (receiver_id) REFERENCES users(user_id)
);

-- ==========================
-- INDEXES
-- ==========================

CREATE INDEX idx_user_email ON users(email)
CREATE INDEX idx_property_location_id ON properties(location_id)
CREATE INDEX Idx_booking_property_id ON bookings(property_id)
CREATE INDEX idx_payment_booking_id ON payments(booking_id)
