# Index Performance: Properties & Reviews Query

We tested the performance impact of adding an index on the `reviews.property_id` column.  
The query under test was:

```sql
SELECT * 
FROM properties 
JOIN reviews 
  ON properties.property_id = reviews.property_id 
WHERE properties.property_id IN (
  SELECT property_id 
  FROM reviews 
  GROUP BY property_id 
  HAVING AVG(rating) > 4.0
);
```

## 1. Without Index

EXPLAIN
```
id  select_type  table      type  possible_keys        key               key_len  ref                                                   rows  filtered  Extra
1   PRIMARY      properties ALL   PRIMARY              NULL              NULL     NULL                                                  4     100.00    Using where
1   PRIMARY      reviews     ref  fk_review_property   fk_review_property 4      alx_airbnb_database.properties.property_id           1     100.00
2   SUBQUERY     reviews     index fk_review_property  fk_review_property 4      NULL                                                  4     100.00
```


EXPLAIN ANALYZE
```
-> Nested loop inner join  (cost=2.05 rows=4) (actual time=0.429..0.493 rows=2 loops=1)
    -> Filter: <in_optimizer>(properties.property_id, properties.property_id in (select #2))
       (cost=0.65 rows=4) (actual time=0.405..0.455 rows=2 loops=1)
        -> Table scan on properties (cost=0.65 rows=4) (actual time=0.215..0.248 rows=4 loops=1)
        -> Select #2 (subquery in condition; run only once)

```
👉 Here, reviews was relying on a foreign key (fk_review_property), but performance was limited because property_id in reviews had no dedicated index.
This led to table scans inside the subquery.

## 2. Adding Index

We added a covering index on reviews.property_id:
```
CREATE INDEX reviews_property_idx ON reviews(property_id);
```

No index was needed on properties.property_id because it is already the primary key.

## 3. With Index

EXPLAIN
```
id  select_type  table      type  possible_keys            key                  key_len  ref                                                   rows  filtered  Extra
1   PRIMARY      properties ALL   PRIMARY                  NULL                 NULL     NULL                                                  4     100.00    Using where
1   PRIMARY      reviews     ref  reviews_property_idx      reviews_property_idx 4      alx_airbnb_database.properties.property_id           1     100.00
2   SUBQUERY     reviews     index reviews_property_idx     reviews_property_idx 4      NULL                                                  4     100.00
```

EXPLAIN ANALYZE
```
-> Nested loop inner join  (cost=2.05 rows=4) (actual time=0.243..0.292 rows=2 loops=1)
    -> Filter: <in_optimizer>(properties.property_id, properties.property_id in (select #2))
       (cost=0.65 rows=4) (actual time=0.22..0.251 rows=2 loops=1)
        -> Table scan on properties (cost=0.65 rows=4) (actual time=0.0991..0.115 rows=4 loops=1)
        -> Select #2 (subquery in condition; run only once)
```
## 4. Performance Comparison

Before Index:

Subquery relied on scanning reviews table using only FK metadata.

Actual execution time: 0.429..0.493 ms

After Index:

reviews_property_idx was used in both main join and subquery.

Actual execution time dropped: 0.243..0.292 ms
