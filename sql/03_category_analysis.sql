/*
The category column contains hierarchical categories separated by |.

Extract the top-level category.
    For example:
    Electronics
    Computers&Accessories
    Home&Kitchen

Then answer:
    How many products exist in each top-level category?
    Which category has the highest average rating?
    Which category has the highest average discount?
    Which category has the highest average actual price?
    Which category has the highest average discounted price?
    Which category has the greatest number of highly-rated products?

*/

WITH extract_category AS (
    SELECT
        *,
        split_part(category, '|', 1) AS top_category,
    FROM amazon
)
SELECT
    top_category,
    COUNT(*) AS product_count
FROM extract_category
GROUP BY top_category;

SELECT
    split_part(category, '|', 1) AS top_category,
    COUNT(*) AS product_count
FROM amazon
GROUP BY split_part(category, '|', 1);

--How many products exist in each top-level category?
SELECT
    split_part(category, '|', 1) AS top_category,
    COUNT(*) AS product_count
FROM amazon
GROUP BY split_part(category, '|', 1)
ORDER BY product_count DESC;

--Which category has the highest average rating?
SELECT
    split_part(category, '|', 1) AS top_category,
    ROUND(AVG(rating), 2) AS avg_rating
FROM amazon
GROUP BY split_part(category, '|', 1)
ORDER BY avg_rating DESC;

--Which category has the highest average discount?
SELECT
    split_part(category, '|', 1) AS top_category,
    ROUND(AVG(discount_percentage), 2) || '%' AS avg_discount
FROM amazon
GROUP BY split_part(category, '|', 1)
ORDER BY avg_discount DESC;

--Which category has the highest average actual price?
SELECT
    split_part(category, '|', 1) AS top_category,
    ROUND(AVG(actual_price), 2) AS avg_actual_price
FROM amazon
GROUP BY split_part(category, '|', 1)
ORDER BY avg_actual_price DESC;

--Which category has the highest average discounted price?
SELECT
    split_part(category, '|', 1) AS top_category,
    ROUND(AVG(discounted_price), 2) AS avg_discounted_price,
FROM amazon
GROUP BY split_part(category, '|', 1)
ORDER BY avg_discounted_price DESC;

--Which category has the greatest number of highly-rated products?
SELECT
    split_part(category, '|', 1) AS top_category,
    ROUND(AVG(rating_count), 0) AS highly_rated
FROM amazon
GROUP BY split_part(category, '|', 1)
ORDER BY avg_discounted_price DESC;

/*
KEY INSIGHT

Product categories show differences in product volume and average customer ratings. These variations can help identify categories with stronger customer satisfaction and areas with greater product availability.
*/

