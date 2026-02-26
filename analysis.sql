-- PROJECT: Zomato Bangalore Restaurant Analysis
-- OBJECTIVE: Use SQL to identify top business opportunities and customer behavior.

---------------------------------------------------------
-- 1. CUSTOMER LOYALTY ANALYSIS
-- Goal: Identify top 5 customers by order volume and total spend.
---------------------------------------------------------
SELECT 
    user_id, 
    COUNT(order_id) AS total_orders, 
    SUM(total_amount) AS total_spent
FROM orders
GROUP BY user_id
ORDER BY total_orders DESC
LIMIT 5;


---------------------------------------------------------
-- 2. "BEST VALUE" RESTAURANT FINDER
-- Goal: Find highly-rated restaurants (4.0+) that are affordable (under ₹500).
---------------------------------------------------------
SELECT 
    restaurant_name, 
    avg_rating, 
    average_cost_for_two
FROM restaurants
WHERE avg_rating > 4.0 
AND average_cost_for_two < 500
ORDER BY avg_rating DESC;


---------------------------------------------------------
-- 3. MARKET DOMINANCE RANKING (Advanced)
-- Goal: Rank restaurants within each city by revenue using Window Functions.
---------------------------------------------------------
SELECT 
    city, 
    restaurant_name, 
    SUM(total_amount) as revenue,
    RANK() OVER (PARTITION BY city ORDER BY SUM(total_amount) DESC) as city_rank
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY city, restaurant_name;
