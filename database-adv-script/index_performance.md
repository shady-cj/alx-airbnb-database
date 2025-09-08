# Indexing Strategy

This project uses indexes to improve query performance for joins, filtering, and ordering.

## Indexes Created

### Bookings
- `booking_user_idx` → speeds up joins between `bookings.user_id` and `users.user_id`.
- `bookings_property_idx` → optimizes joins/queries involving `bookings.property_id`.

### Properties
- `properties_created_at_idx` → supports queries that sort or filter properties by `created_at`.

### Reviews
- `reviews_property_idx` → speeds up joins between `reviews.property_id` and `properties.property_id`.

## Notes
- Primary keys (`users.user_id`, `properties.property_id`) are **already indexed** automatically by the database.  
  No extra indexes were added for them.  
- Composite indexes (e.g., `(user_id, created_at)`) can be considered if queries filter or sort by both together.  
- Extra indexes come with a trade-off: faster reads, but slower writes (insert/update/delete).

## Checking Index Usage

To verify indexes are being used, run queries with `EXPLAIN` (or `EXPLAIN ANALYZE` for actual runtime):

```sql
EXPLAIN
SELECT * 
FROM bookings 
WHERE user_id = 42
ORDER BY created_at DESC;
