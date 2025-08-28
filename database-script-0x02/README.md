# Seed Data for Airbnb clone Database

This `seed.sql` file contains **sample data inserts** for the airbnb clone Database schema.  
It populates the database with example users, locations, properties, bookings, payments, reviews, and messages.

---

## 📌 Purpose
The seed data is meant for:
- Testing the database structure after running the schema SQL script.
- Demonstrating realistic usage scenarios (users booking properties, making payments, leaving reviews, sending messages).
- Serving as dummy data for development and learning.

---

## 📂 What It Contains
The `seed.sql` script inserts data into these tables:

1. **Users** – Hosts and guests with names, emails, and passwords.  
2. **Locations** – Cities across Africa where properties are listed.  
3. **Properties** – Listings created by users and tied to locations.  
4. **Bookings** – Reservations with statuses (`confirmed`, `pending`, `canceled`).  
5. **Payments** – Linked to bookings, showing amounts and payment status.  
6. **Reviews** – Guest feedback with ratings and comments.  
7. **Messages** – Conversations between guests and hosts.

---

## ▶️ Usage

1. Ensure you have already created the database schema (run `schema.sql` in database-script-0x01
first).  
2. Run the `seed.sql` file to populate the database:

```bash
mysql -u your_username -p your_database < seed.sql
