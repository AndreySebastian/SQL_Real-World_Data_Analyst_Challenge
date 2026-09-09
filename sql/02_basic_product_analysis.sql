/*
This query will answers:

    What are the 10 most expensive products based on actual price?
    What are the 10 cheapest products?
    What are the 10 products with the highest ratings?
    What are the 10 products with the most rating counts?
    What is the average product rating?
    What is the average actual price?
    What is the average discounted price?
    What is the average discount percentage?
*/

--What are the 10 most expensive products based on actual price?
SELECT
    product_name,
    actual_price
FROM amazon
WHERE actual_price > (
    SELECT MEDIAN(actual_price)
    FROM amazon
)
ORDER BY actual_price DESC
LIMIT 10;

--What are the 10 cheapest products?
SELECT
    product_name,
    actual_price
FROM amazon
WHERE actual_price < (
    SELECT MEDIAN(actual_price)
    FROM amazon
)
ORDER BY actual_price ASC
LIMIT 10;

--What are the 10 products with the highest ratings?
SELECT
    product_name,
    rating
FROM amazon
WHERE rating > 4.5
ORDER BY actual_price DESC
LIMIT 10;

--What are the 10 products with the most rating counts?
SELECT
    product_name,
    rating_count
FROM amazon
WHERE rating_count > (
    SELECT AVG(rating_count)
    FROM amazon
)
ORDER BY rating_count DESC
LIMIT 10;

--What is the average product rating?
SELECT
    ROUND(AVG(rating), 0) AS avg_product_rating
FROM amazon;

--What is the average actual price?
SELECT
    ROUND(AVG(actual_price), 0) AS avg_product_price
FROM amazon;

--What is the average discounted price?
SELECT
    ROUND(AVG(discounted_price), 2) AS avg_discounted_price
FROM amazon;

--What is the average discount percentage?
SELECT
    ROUND(AVG(discount_percentage), 2) || '%' AS avg_discount_percentage
FROM amazon;

/*
KEY INSIGHT

The analysis provides an overview of product pricing, ratings, discounts, and customer engagement across the catalog. This establishes the baseline for identifying high-performing products and pricing patterns.
*/



