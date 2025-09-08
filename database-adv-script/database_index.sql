EXPLAIN ANALYZE SELECT * 
FROM properties 
JOIN reviews ON properties.property_id = reviews.property_id
WHERE properties.property_id IN (
    SELECT property_id 
    FROM reviews 
    GROUP BY property_id 
    HAVING AVG(rating) > 4.0
);


CREATE INDEX reviews_property_idx ON reviews(property_id);

EXPLAIN ANALYZE SELECT * 
FROM properties 
JOIN reviews ON properties.property_id = reviews.property_id
WHERE properties.property_id IN (
    SELECT property_id 
    FROM reviews 
    GROUP BY property_id 
    HAVING AVG(rating) > 4.0
);
