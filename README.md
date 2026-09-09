# Amazon Products SQL Analysis

This project uses SQL to analyze Amazon product listings, pricing, discounts, ratings, and customer engagement. The goal is to turn product-level marketplace data into insights that can support pricing, promotion, assortment, and merchandising decisions.

## Dataset

The analysis uses the cleaned [Amazon products CSV](data/amazon_products_cleaned.csv), attached to the MotherDuck database `clean_amazondb`.

| Column | Description |
| --- | --- |
| `product_id` | Unique product identifier |
| `product_name` | Product title |
| `category` | Hierarchical category path separated by `\|` |
| `discounted_price` | Current selling price |
| `actual_price` | Listed price before discount |
| `discount_percentage` | Percentage discount |
| `rating` | Customer rating |
| `rating_count` | Number of customer ratings; used as an engagement proxy |

## Query Engine

The SQL is written for **MotherDuck**, a cloud data warehouse built on DuckDB. The project uses the `clean_amazondb` database, with the attached CSV available to the queries as the `amazon` table.

Example connection setup in DuckDB/MotherDuck:

```sql
ATTACH 'md:clean_amazondb' AS clean_amazondb;
USE clean_amazondb;
```

Run the scripts in numeric order from the [SQL analysis](sql/) directory.

## Business Problems

This project answers practical marketplace questions:

- Is the dataset reliable enough for analysis, and are there duplicates, missing values, invalid ratings, or invalid prices?
- Which products are the most expensive, cheapest, highest-rated, or most reviewed?
- Which top-level categories have the most products and the strongest pricing, discount, and rating performance?
- Are larger discounts associated with higher ratings or customer engagement?
- Which products and categories offer the greatest absolute and percentage savings to customers?
- Which products have strong evidence of customer confidence based on both rating and rating volume?
- Which products are star products, hidden gems, popular but poorly rated, or underperformers?
- Which products are strong candidates for promotion based on rating, engagement, discount, and price?

## SQL Skills Demonstrated

- Data profiling and quality checks with `COUNT`, `COUNT(DISTINCT ...)`, `SUM`, `CASE`, and `DESCRIBE`
- Aggregation with `AVG`, `SUM`, `MEDIAN`, `ROUND`, `GROUP BY`, and `HAVING`-style filtering
- Subqueries and common table expressions (`WITH`)
- Conditional business logic with `CASE` expressions and discount bands
- Hierarchical category parsing with `split_part`
- Calculated metrics such as savings and composite promotion scores
- Product segmentation using rating and engagement thresholds
- Window functions with `RANK()` for multi-factor product ranking
- Sorting, filtering, and top-N analysis with `ORDER BY` and `LIMIT`

## Project Files

### Data

- [data/amazon_products_cleaned.csv](data/amazon_products_cleaned.csv) - Cleaned product dataset attached to `clean_amazondb`

### SQL analysis

- [sql/01_data_quality.sql](sql/01_data_quality.sql) - Validates product identifiers, missing values, prices, discounts, and rating ranges.
- [sql/02_basic_product_analysis.sql](sql/02_basic_product_analysis.sql) - Finds product price, rating, review-volume, and overall summary statistics.
- [sql/03_category_analysis.sql](sql/03_category_analysis.sql) - Compares top-level categories by size, price, discount, rating, and engagement.
- [sql/04_discount_analysis.sql](sql/04_discount_analysis.sql) - Groups products into discount bands and compares performance.
- [sql/05_savings_analysis.sql](sql/05_savings_analysis.sql) - Measures absolute savings and category-level customer savings potential.
- [sql/06_customer_engagement.sql](sql/06_customer_engagement.sql) - Identifies highly engaged and high-confidence products.
- [sql/07_product_segmentation.sql](sql/07_product_segmentation.sql) - Classifies products into four rating and engagement segments.
- [sql/08_best_product.sql](sql/08_best_product.sql) - Defines and evaluates products with above-average engagement, strong ratings, and above-average discounts.
- [sql/09_product_ranking.sql](sql/09_product_ranking.sql) - Ranks products across rating, engagement, and discount dimensions.
- [sql/10_promotion_strategy.sql](sql/10_promotion_strategy.sql) - Selects higher-priced, above-average-discount products for promotion consideration.
