-- Initial Table --
SELECT *
FROM salesstore;

-- First off, I will be analyzing the regions to evaluate which had the highest sales (Top 3) --
SELECT region, ROUND(AVG(sales), 2) AS amount_per_region
FROM salesstore
GROUP BY region
ORDER BY amount_per_region DESC
LIMIT 3;

-- Looking at product category that made the highest profit --
SELECT Product_Category, ROUND(SUM(profit)) AS category_profit, COUNT(Product_Category) AS total_sales
FROM salesstore
GROUP BY Product_Category
ORDER BY category_profit DESC
;

-- Up Next, I selected the common sold product names. This helps to know the most popular brand or product names (Top 5)--
SELECT substring(Product_Name, 1, 5) AS _product_name , count(substring(Product_Name, 1, 5)) AS count_product_name
FROM salesstore
GROUP BY substring(Product_Name, 1, 5)
ORDER BY count_product_name DESC
LIMIT 5
;

-- Viewing Xerox Products to see the profit makers and the loss makers --
SELECT Product_Name, Profit
FROM salesstore
WHERE Product_Name LIKE 'Xerox%'
ORDER BY Profit DESC;

-- I saw the order priority and I wanted to know if the higher the Priority of the order translates to higher order amounts --
SELECT DISTINCT Order_Priority, ROUND(SUM(Order_Quantity * Sales)) AS total_money_orders, ROUND(SUM(Order_Quantity * Profit)) AS total_order_profit
FROM salesstore
GROUP BY Order_Priority
ORDER BY total_order_profit DESC;

-- Up next, viewing the regions and the profit yield from the regions --
SELECT Region, ROUND(SUM(Profit)) AS profit_per_region
FROM salesstore
GROUP BY Region
ORDER BY profit_per_region DESC
;

-- Because the region with the highest profit was 'Northwest Territories', we want to look and see what was really making the profits there
-- I want to know the customers that have spent the most from the 'Northwest Territories'--
SELECT Customer_Name, COUNT(Customer_Name) AS times_patronized, ROUND(SUM(Profit)) AS money_made_from_customer
FROM salesstore
WHERE Region = 'Northwest Territories'
GROUP BY Customer_Name
ORDER BY money_made_from_customer DESC
LIMIT 5
;

-- Let's look at top 5 from all regions --
SELECT Customer_Name, Region, COUNT(Customer_Name) AS times_patronized, ROUND(SUM(Profit)) AS money_made_from_customer
FROM salesstore
GROUP BY Customer_Name, Region
ORDER BY money_made_from_customer DESC
LIMIT 5
;

-- To see which shipping mode yields more profits --
SELECT  Ship_Mode, AVG(Profit) AS Ship_Mode_Profit
FROM salesstore
GROUP BY Ship_Mode
ORDER BY Ship_Mode_Profit desc
;                                    -- #With this, we have seen that the Regular Air yields more profit# --

-- Looking at the most desired of the box packaging --
SELECT Product_Container, COUNT(Product_Container)
FROM salesstore
GROUP BY Product_Container
ORDER BY Product_Container DESC;

-- Customer Transaction that caused the most losses (Top 10) --
SELECT Order_ID , Customer_Name, Product_Category, Order_Quantity, Sales, Profit
FROM salesstore
ORDER BY Profit 
LIMIT 10;

-- That's all for this little MySQL Project. If there was another table I could query off, it would have made coding this more fun --
-- THANKS FOR VIEWING... ODIGIE EROMONSELE --