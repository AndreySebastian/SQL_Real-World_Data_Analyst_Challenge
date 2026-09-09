-- Before analyzing anything, prove that the dataset is trustworthy.

-- This query will determine these:
    -- Total number of products
    -- Number of unique products
    -- Duplicate product_id count
    -- Products with missing ratings
    -- Products with missing rating counts
    -- Products where discounted price > actual price
    -- Products where discount percentage is negative
    -- Products where rating is outside the valid 0–5 range
    -- Products with zero or negative prices

DESCRIBE amazon;

SELECT
    COUNT(*) AS total_product_count,
    COUNT(DISTINCT product_id) AS unique_product_count,
    COUNT(*) - COUNT(DISTINCT product_id) AS duplicate_product_count,
    SUM(
        CASE
            WHEN rating IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_rating_count_value,
    SUM(
        CASE
            WHEN rating_count IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_rating_count,
    SUM(
        CASE
            WHEN discounted_price > actual_price THEN 1
            ELSE 0
        END
    ) AS discounted_price_greater_than_actual_price,
    SUM(
        CASE
            WHEN discount_percentage < 0 THEN 1
            ELSE 0
        END
    ) AS negative_discount_percentage,
    SUM(
        CASE
            WHEN rating < 0 OR rating > 5 THEN 1
            ELSE 0
        END
    ) AS invalid_rating_count,
    SUM(
        CASE
            WHEN actual_price <= 0
                OR discounted_price <= 0
            THEN 1
            ELSE 0
        END
    ) AS invalid_price_count
FROM amazon;

/*
KEY INSIGHT

The dataset contains issues such as missing values, duplicate records, and inconsistent data formats that can affect analytical accuracy. Cleaning and validating these fields is essential before using the data for business analysis.
*/

