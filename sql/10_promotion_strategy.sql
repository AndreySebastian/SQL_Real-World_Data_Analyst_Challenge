-- CHALLENGE 10
-- Promotion Strategy

WITH product_ranking AS (
    SELECT
        product_name,
        split_part(category, '|', 1) AS category,
        actual_price,
        discount_percentage,

        RANK() OVER (
            ORDER BY rating DESC
        ) AS rating_rank,

        RANK() OVER (
            ORDER BY rating_count DESC
        ) AS engagement_rank,

        RANK() OVER (
            ORDER BY discount_percentage DESC
        ) AS discount_rank

    FROM amazon
),

product_scoring AS (
    SELECT
        product_name,
        category,
        actual_price,
        discount_percentage,
        rating_rank,
        engagement_rank,
        discount_rank,
        (
            rating_rank +
            engagement_rank +
            discount_rank
        ) AS promotion_score
    FROM product_ranking
)

SELECT
    product_name,
    category,
    actual_price,
    discount_percentage,
    rating_rank,
    engagement_rank,
    discount_rank,
    promotion_score
FROM product_scoring
WHERE actual_price > (
    SELECT AVG(actual_price)
    FROM amazon
)
AND discount_percentage > (
    SELECT AVG(discount_percentage)
    FROM amazon
)
ORDER BY promotion_score ASC
LIMIT 10;

/*
KEY INSIGHT

Products priced above the average while offering above-average discounts can represent strong promotional opportunities. Prioritizing products with strong ratings and customer engagement can help businesses focus promotions on products with proven customer demand.
*/