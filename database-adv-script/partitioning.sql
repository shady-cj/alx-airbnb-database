-- in mysql 8+ partitioning a table with foreign key isn't allowed
-- The foreign key key constraint would be enforced on the application level rather than the database level

CREATE TABLE new_bookings (
	booking_id INT NOT NULL,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    status ENUM('pending', 'confirmed', 'cancelled') DEFAULT 'pending',
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    check_in_quarter INT GENERATED ALWAYS AS (
        QUARTER(check_in_date)
    ) STORED,
    PRIMARY KEY(booking_id, check_in_date, check_in_quarter)
)

PARTITION BY RANGE (check_in_quarter) (
	PARTITION quarter1 VALUES LESS THAN (5),
    PARTITION quarter2 VALUES LESS THAN (9),
    PARTITION quarter3 VALUES LESS THAN MAXVALUE
);

CREATE TABLE new_users (
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
CREATE TABLE new_locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    country VARCHAR(100) NOT NULL
);

-- ==========================
-- PROPERTIES TABLE
-- ==========================
CREATE TABLE new_properties (
    property_id INT PRIMARY KEY AUTO_INCREMENT,
    owner_id INT NOT NULL,
    location_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    price_per_night DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Foreign Keys
    CONSTRAINT new_fk_property_owner FOREIGN KEY (owner_id) REFERENCES new_users(user_id),
    CONSTRAINT new_fk_property_location FOREIGN KEY (location_id) REFERENCES new_locations(location_id)
);

-- seeding the tables

INSERT INTO new_users (name, email, phone, password_hash) VALUES
('Alice Johnson', 'alice@example.com', '555-111-1111', 'hash1'),
('Bob Smith', 'bob@example.com', '555-111-1112', 'hash2'),
('Charlie Brown', 'charlie@example.com', '555-111-1113', 'hash3'),
('Diana Prince', 'diana@example.com', '555-111-1114', 'hash4'),
('Ethan Hunt', 'ethan@example.com', '555-111-1115', 'hash5'),
('Fiona Gallagher', 'fiona@example.com', '555-111-1116', 'hash6'),
('George Miller', 'george@example.com', '555-111-1117', 'hash7'),
('Hannah Davis', 'hannah@example.com', '555-111-1118', 'hash8'),
('Ivan Petrov', 'ivan@example.com', '555-111-1119', 'hash9'),
('Julia Roberts', 'julia@example.com', '555-111-1120', 'hash10'),
('Kevin Hart', 'kevin@example.com', '555-111-1121', 'hash11'),
('Laura Bush', 'laura@example.com', '555-111-1122', 'hash12'),
('Mike Ross', 'mike@example.com', '555-111-1123', 'hash13'),
('Nina Simone', 'nina@example.com', '555-111-1124', 'hash14'),
('Oscar Wilde', 'oscar@example.com', '555-111-1125', 'hash15'),
('Paula Abdul', 'paula@example.com', '555-111-1126', 'hash16'),
('Quincy Adams', 'quincy@example.com', '555-111-1127', 'hash17'),
('Rachel Green', 'rachel@example.com', '555-111-1128', 'hash18'),
('Sam Wilson', 'sam@example.com', '555-111-1129', 'hash19'),
('Tina Turner', 'tina@example.com', '555-111-1130', 'hash20');


INSERT INTO new_locations (city, state, country) VALUES
('New York', 'NY', 'USA'),
('Los Angeles', 'CA', 'USA'),
('Chicago', 'IL', 'USA'),
('Houston', 'TX', 'USA'),
('Phoenix', 'AZ', 'USA'),
('London', 'England', 'UK'),
('Manchester', 'England', 'UK'),
('Paris', 'Ile-de-France', 'France'),
('Berlin', 'Berlin', 'Germany'),
('Munich', 'Bavaria', 'Germany'),
('Tokyo', 'Tokyo', 'Japan'),
('Osaka', 'Osaka', 'Japan'),
('Beijing', 'Beijing', 'China'),
('Shanghai', 'Shanghai', 'China'),
('Sydney', 'NSW', 'Australia'),
('Melbourne', 'Victoria', 'Australia'),
('Toronto', 'Ontario', 'Canada'),
('Vancouver', 'British Columbia', 'Canada'),
('Cape Town', 'Western Cape', 'South Africa'),
('Lagos', 'Lagos', 'Nigeria');


INSERT INTO new_properties (owner_id, location_id, title, description, price_per_night) VALUES
(1, 1, 'Luxury Loft in NYC', 'Beautiful loft in Manhattan with skyline views.', 250.00),
(2, 2, 'Hollywood Hills Villa', 'Modern villa with private pool.', 500.00),
(3, 3, 'Downtown Chicago Apartment', 'Cozy apartment near Millennium Park.', 150.00),
(4, 4, 'Houston Family House', 'Spacious house perfect for families.', 180.00),
(5, 5, 'Desert Retreat in Phoenix', 'Quiet retreat in the desert.', 120.00),
(6, 6, 'London Flat', 'Trendy flat in central London.', 300.00),
(7, 7, 'Manchester Townhouse', 'Charming townhouse near city center.', 200.00),
(8, 8, 'Paris Studio', 'Stylish studio near Eiffel Tower.', 350.00),
(9, 9, 'Berlin Loft', 'Modern loft in Mitte district.', 220.00),
(10, 10, 'Munich Cottage', 'Bavarian-style cottage.', 180.00),
(1, 11, 'Tokyo Capsule Room', 'Minimalist capsule accommodation.', 80.00),
(2, 12, 'Osaka Apartment', 'Convenient apartment near train station.', 140.00),
(3, 13, 'Beijing Condo', 'Luxury condo with city views.', 200.00),
(4, 14, 'Shanghai Penthouse', 'High-rise penthouse with skyline views.', 400.00),
(5, 15, 'Sydney Beach House', 'House by Bondi Beach.', 450.00),
(6, 16, 'Melbourne City Flat', 'Modern flat in Melbourne CBD.', 220.00),
(7, 17, 'Toronto Downtown Condo', 'Close to CN Tower and waterfront.', 210.00),
(8, 18, 'Vancouver Cabin', 'Mountain cabin retreat.', 190.00),
(9, 19, 'Cape Town Villa', 'Villa with ocean and Table Mountain views.', 350.00),
(10, 20, 'Lagos Apartment', 'City apartment in Victoria Island.', 130.00);


INSERT INTO new_bookings (booking_id, user_id, property_id, check_in_date, check_out_date, status) VALUES
(1, 1, 1, '2024-01-10', '2024-01-15', 'confirmed'),
(2, 2, 2, '2024-02-05', '2024-02-12', 'pending'),
(3, 3, 3, '2024-03-20', '2024-03-25', 'confirmed'),
(4, 4, 4, '2024-04-02', '2024-04-06', 'cancelled'),
(5, 5, 5, '2024-05-15', '2024-05-20', 'confirmed'),
(6, 6, 6, '2024-06-10', '2024-06-15', 'pending'),
(7, 7, 7, '2024-07-22', '2024-07-28', 'confirmed'),
(8, 8, 8, '2024-08-05', '2024-08-12', 'confirmed'),
(9, 9, 9, '2024-09-10', '2024-09-15', 'pending'),
(10, 10, 10, '2024-10-01', '2024-10-05', 'confirmed'),
(11, 11, 11, '2024-11-15', '2024-11-18', 'cancelled'),
(12, 12, 12, '2024-12-20', '2024-12-25', 'confirmed'),
(13, 13, 13, '2024-01-03', '2024-01-07', 'confirmed'),
(14, 14, 14, '2024-02-14', '2024-02-18', 'pending'),
(15, 15, 15, '2024-03-30', '2024-04-04', 'confirmed'),
(16, 16, 16, '2024-04-10', '2024-04-15', 'cancelled'),
(17, 17, 17, '2024-05-05', '2024-05-10', 'confirmed'),
(18, 18, 18, '2024-06-18', '2024-06-22', 'pending'),
(19, 19, 19, '2024-07-01', '2024-07-05', 'confirmed'),
(20, 20, 20, '2024-08-25', '2024-08-30', 'confirmed');
