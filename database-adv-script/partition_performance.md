## 1. Initial Setup (Non-Partitioned)

We began with standard relational tables:

```
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    status ENUM('pending', 'confirmed', 'cancelled') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    country VARCHAR(100) NOT NULL
);

CREATE TABLE properties (
    property_id INT PRIMARY KEY AUTO_INCREMENT,
    owner_id INT NOT NULL,
    location_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    price_per_night DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES users(user_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);
```

## 2. Partitioned Tables

MySQL 8.0+ does not support foreign keys with partitioning, we created new_* tables where new_bookings is partitioned.

```
CREATE TABLE new_bookings (
    booking_id INT NOT NULL,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    status ENUM('pending', 'confirmed', 'cancelled') DEFAULT 'pending',
    check_in_quarter TINYINT UNSIGNED GENERATED ALWAYS AS (
        QUARTER(check_in_date)
    ) STORED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, check_in_date, check_in_quarter)
)
PARTITION BY RANGE (check_in_quarter) (
    PARTITION quarter1 VALUES LESS THAN (5),   -- Jan–Apr
    PARTITION quarter2 VALUES LESS THAN (9),   -- May–Aug
    PARTITION quarter3 VALUES LESS THAN MAXVALUE -- Sep–Dec
);

CREATE TABLE new_users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE new_locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    country VARCHAR(100) NOT NULL
);

CREATE TABLE new_properties (
    property_id INT PRIMARY KEY AUTO_INCREMENT,
    owner_id INT NOT NULL,
    location_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    price_per_night DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES new_users(user_id),
    FOREIGN KEY (location_id) REFERENCES new_locations(location_id)
);

```

## 3. Performance Testing Queries
### a. Range Queries
__Non-partitioned__
```
EXPLAIN SELECT * FROM bookings 
WHERE check_in_date BETWEEN '2024-03-01' AND '2024-03-31';
```
__Partitioned__

```
EXPLAIN SELECT * FROM new_bookings 
WHERE check_in_date BETWEEN '2024-03-01' AND '2024-03-31';
```

✅ On new_bookings, only quarter1 partition is scanned.
On bookings, the entire table is scanned.

### b. Aggregate Queries
__Count bookings in Q2 (May–Aug)__

__Non-partitioned__
```
EXPLAIN SELECT COUNT(*) FROM bookings
WHERE check_in_date BETWEEN '2024-05-01' AND '2024-08-31';
```

__Partitioned__
```
EXPLAIN SELECT COUNT(*) FROM new_bookings
WHERE check_in_date BETWEEN '2024-05-01' AND '2024-08-31';
```

✅ Partition pruning ensures only quarter2 is read in new_bookings.

### c. Profiling Execution

```
SET profiling = 1;

-- Non-partitioned
SELECT COUNT(*) FROM bookings WHERE check_in_date BETWEEN '2024-01-01' AND '2024-04-30';

-- Partitioned
SELECT COUNT(*) FROM new_bookings WHERE check_in_date BETWEEN '2024-01-01' AND '2024-04-30';

SHOW PROFILES;

```
<img width="683" height="181" alt="image" src="https://github.com/user-attachments/assets/496ef43f-3824-4229-aa32-9c68c608b941" />
