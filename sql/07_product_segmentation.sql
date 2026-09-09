/*
Product Segmentaion

    Rating	Engagement	Segment
    High	High	    Star Products
    High	Low	        Hidden Gems
    Low	    High	    Popular but Poorly Rated
    Low	    Low	        Underperformers
*/
WITH product_segment AS (
        SELECT
            product_name,
            rating,
            rating_count,
            CASE 
                WHEN rating >= 4.0 THEN 'HIGH'
                ELSE 'LOW'
            END AS rating_segment,
            CASE 
                WHEN rating_count >= (
                    SELECT AVG(rating_count)
                    FROM amazon
                    WHERE rating_count IS NOT NULL
                ) THEN 'HIGH'
                ELSE 'LOW'
            END AS engagement_segment,
        FROM amazon
        WHERE
            rating IS NOT NULL AND
            rating_count IS NOT NULL
)
SELECT
    product_name,
    rating,
    rating_count,
    rating_segment,
    engagement_segment,
    CASE
        WHEN rating_segment = 'HIGH'
                AND engagement_segment = 'HIGH' 
            THEN 'Star Products'
        WHEN rating_segment = 'HIGH' 
                AND engagement_segment = 'LOW' 
            THEN 'Hidden Gems'
        WHEN rating_segment = 'LOW' 
                AND engagement_segment= 'HIGH' 
            THEN 'Popular but Poorly Rated'
        WHEN rating_segment = 'LOW' 
                AND engagement_segment = 'LOW' 
            THEN 'Underperformers'
    END AS final_segment
FROM product_segment
;

/*
KEY INSIGHT

Products can be classified into segments such as Star Products, Hidden Gems, Popular but Poorly Rated, and Underperformers based on rating and engagement. This segmentation helps businesses identify products that should be promoted, improved, or monitored.
*/