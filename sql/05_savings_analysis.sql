/*

Find:
    Top 10 products by absolute savings
    Top 10 products by percentage discount
    Average savings across all products
    Category with the highest average savings
    Category with the highest total potential customer savings
*/

--Top 10 products by absolute savings
SELECT
    product_name,
    actual_price,
    discounted_price,
    (actual_price - discounted_price) AS savings
FROM amazon
ORDER BY savings DESC
LIMIT 10;

--Top 10 products by percentage discount
SELECT
    product_name,
    actual_price,
    discounted_price,
    discount_percentage,
    (actual_price - discounted_price) AS savings
FROM amazon
ORDER BY discount_percentage DESC
LIMIT 10;

--Average savings across all products
SELECT
    ROUND(AVG(actual_price - discounted_price), 2) AS avg_savings,
FROM amazon;

--Category with the highest average savings
SELECT
    split_part(category, '|', 1) AS category,
    ROUND(AVG(actual_price - discounted_price), 2) AS avg_savings
FROM amazon
GROUP BY 
    split_part(category, '|', 1)
ORDER BY avg_savings DESC
LIMIT 1;

--Category with the highest total potential customer savings
SELECT
    split_part(category, '|', 1) AS category,
    ROUND(SUM(actual_price - discounted_price), 2) AS avg_savings,
FROM amazon
GROUP BY 
    split_part(category, '|', 1)
ORDER BY avg_savings DESC
LIMIT 1;





WITH saving_tb AS (
    SELECT
        (actual_price - discounted_price) AS savings,
    FROM amazon
),
avg_savings AS (
    SELECT
        SUM(savings) AS total_savings
    FROM saving_tb
)
SELECT
    AVG(total_savings)
FROM avg_savings;

/*
KEY INSIGHT

Some products provide substantially higher absolute savings due to their higher original prices, while others offer larger percentage discounts. This distinction helps separate products with the largest monetary savings from those with the most aggressive promotions.
*/

