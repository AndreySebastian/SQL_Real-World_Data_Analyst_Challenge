--Ranking

WITH ranking AS (
    SELECT
        product_name,
        rating,
        rating_count,
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

scored_products AS (
    SELECT
        product_name,
        rating,
        rating_count,
        discount_percentage,
        rating_rank,
        engagement_rank,
        discount_rank,

        rating_rank
        + engagement_rank
        + discount_rank AS overall_rank_score

    FROM ranking
)
--1,351 × 10% ≈ 135 products
SELECT
    product_name,
    rating,
    rating_count,
    discount_percentage,
    rating_rank,
    engagement_rank,
    discount_rank,
    overall_rank_score
FROM scored_products
WHERE rating_rank < 135
    AND engagement_rank <= 135
    AND discount_rank <= 135
ORDER BY overall_rank_score ASC;

/*
KEY INSIGHT

Ranking products across rating, engagement, and discount performance provides a broader view of overall product strength. Combining these rankings helps identify products that perform consistently well across multiple business dimensions.
*/