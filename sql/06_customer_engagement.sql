/*
Use:
    rating_count
    as your proxy for customer engagement/popularity.

Find:
    Top 10 most-engaged products
    Average rating of the top 10 most-engaged products
    Categories with the highest average rating count
    Products with:
        rating >= 4.0
        AND
        rating_count >= 10000

These are high-confidence products.
*/

--Top 10 most-engaged products
SELECT
    product_name,
    ROUND(SUM(rating_count), 2) AS most_engagement_products
FROM amazon
GROUP BY product_name
ORDER BY most_engagement_products DESC
LIMIT 10;

--Average rating of the top 10 most-engaged products
SELECT
    product_name,
    ROUND((rating * rating_count), 2) AS most_engagement_products,
    ROUND(AVG(rating), 2) AS avg_rating
FROM amazon
GROUP BY 
    product_name,
    rating,
    rating_count
ORDER BY most_engagement_products DESC
LIMIT 10;

--Categories with the highest average rating count
SELECT
    split_part(category, '|', 1) AS category,
    ROUND(AVG(rating_count), 2) AS avg_rating_count
FROM amazon
GROUP BY 
    split_part(category, '|', 1),
ORDER BY avg_rating_count DESC
;

-- Products with:
--         rating >= 4.0
--         AND
--         rating_count >= 10000
SELECT
    product_name,
    rating,
    rating_count
FROM amazon
WHERE 
    rating >= 4.0 AND
    rating_count >= 10000
ORDER BY 
    rating DESC
;

/*
KEY INSIGHT

Products with higher rating counts demonstrate stronger customer engagement and greater review activity. However, high engagement does not necessarily mean high customer satisfaction, so rating and review volume should be analyzed together.
*/