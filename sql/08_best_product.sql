/*
Determine:
        Number of best products
        Top 20 best products
        Average discount
        Average rating
        Average engagement
        Best-performing category
*/



WITH best_product AS (
    SELECT
        product_name,
        category,
        rating,
        rating_count,
        discount_percentage,
        discounted_price
    FROM amazon
    WHERE rating >= 4.0
        AND rating_count >= (
            SELECT AVG(rating_count)
            FROM amazon
            WHERE rating_count IS NOT NULL
        ) AND
        discount_percentage > (
            SELECT AVG(discount_percentage)
            FROM amazon
        )
)
SELECT 
    COUNT(*) AS best_product_count,
    ROUND(AVG(discounted_price), 2)AS avg_discount,
    ROUND(AVG(rating), 2) AS avg_rating,
    ROUND(AVG(rating_count), 2) avg_engagement,
    category AS best_performing_category
FROM best_product
GROUP BY category
ORDER BY avg_engagement DESC, best_product_count DESC
LIMIT 20;

/*
KEY INSIGHT

The analysis identifies products that combine strong ratings with significant customer engagement. These products represent potential flagship products because they have both positive customer feedback and substantial customer interest.
*/