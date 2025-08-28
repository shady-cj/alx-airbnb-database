# Airbnb clone Database Schema

This project defines a **relational database schema** for airbnb clone project.  
The SQL script creates all the required tables, primary keys, foreign keys, constraints, and indexes to ensure **data integrity and performance**.

---

## 📂 Schema Overview

### Entities
- **Users**: Stores user accounts (guests and hosts).
- **Locations**: Normalized table for city, state, and country.
- **Properties**: Listings owned by users and tied to a location.
- **Bookings**: Reservations made by users for properties.
- **Payments**: Transactions tied to bookings.
- **Reviews**: Ratings and comments on properties by users.
- **Messages**: Direct communication between users.

---

## ⚙️ Features

- **Primary Keys**: Auto-increment IDs for each entity.
- **Foreign Keys**: Maintain relationships between users, properties, bookings, payments, etc.
- **Constraints**: 
  - `CHECK` ensures valid ratings (1–5).
  - `UNIQUE` enforces unique emails and prevents duplicate reviews.
- **Indexes**: 
  - Optimized for frequent lookups (e.g., users by email, properties by location/price, bookings by dates).
  - Composite indexes speed up common multi-column queries.
- **Timestamps**: Automatic `created_at` columns for tracking activity.

---

## 🚀 Usage

1. Open MySQL 8+ (or compatible RDBMS).
2. Run the SQL file:
   ```bash
   mysql -u your_user -p < schema.sql
