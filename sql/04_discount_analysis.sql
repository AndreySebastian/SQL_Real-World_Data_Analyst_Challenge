/*
"Management wants to know whether discounting is associated with product performance."

Create discount bands:
    Discount	Segment
        0–20%	Low Discount
        21–40%	Moderate Discount
        41–60%	High Discount
        61–80%	Very High Discount
        81–100%	Extreme Discount

    Then calculate for each segment:
        Product count
        Average rating
        Average rating count
        Average actual price
        Average discounted price

Business question
    Do heavily discounted products actually receive better customer engagement?
*/

SELECT
    CASE
        WHEN discount_percentage BETWEEN 0 AND 20 THEN 'Low Discount'
        WHEN discount_percentage BETWEEN 21 AND 40 THEN 'Moderate Discount'
        WHEN discount_percentage BETWEEN 41 AND 60 THEN 'High Discount'
        WHEN discount_percentage BETWEEN 61 AND 80 THEN 'Very High Discount'
        WHEN discount_percentage BETWEEN 81 AND 100 THEN 'Extreme Discount'
    END AS discount_bands,
    COUNT(*) AS product_count,
    ROUND(AVG(rating), 2) AS avg_rating,
    ROUND(AVG(rating_count), 2)AS avg_rating_count,
    ROUND(AVG(actual_price), 2) AS avg_price,
    ROUND(AVG(discounted_price), 2) AS avg_discounted_price
FROM amazon
GROUP BY
    CASE
            WHEN discount_percentage BETWEEN 0 AND 20 THEN 'Low Discount'
            WHEN discount_percentage BETWEEN 21 AND 40 THEN 'Moderate Discount'
            WHEN discount_percentage BETWEEN 41 AND 60 THEN 'High Discount'
            WHEN discount_percentage BETWEEN 61 AND 80 THEN 'Very High Discount'
            WHEN discount_percentage BETWEEN 81 AND 100 THEN 'Extreme Discount'
    END
ORDER BY product_count DESC;

/*
KEY INSIGHT

Discount percentages vary considerably across products, highlighting different promotional strategies. Products with higher discounts can attract customers, but discounts should be evaluated alongside ratings and engagement.
*/