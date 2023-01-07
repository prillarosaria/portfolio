USE dqlab;

# Overall Performance by Year
SELECT 
    YEAR(order_date) as years, 
    SUM(sales) as sales, 
    COUNT(order_quantity) as number_of_order 
FROM dqlab_sales_store 
WHERE order_status = 'Order Finished' 
GROUP BY YEAR(order_date) 
ORDER BY YEAR(order_date)

# Overall Performance by Product Sub Category
SELECT 
    YEAR(order_date) as years, 
    product_sub_category, 
    SUM(sales) as sales 
FROM dqlab_sales_store 
WHERE 
    order_status = "Order Finished" 
    AND 
    YEAR(order_date)>=2011 AND YEAR(order_date)<=2012 
GROUP BY YEAR(order_date), product_sub_category 
ORDER BY years ASC, sales DESC;

# Promotion Effectiveness and Efficiency by Years
SELECT 
    YEAR(order_date) as years, 
    SUM(sales) as sales, 
    SUM(discount_value) as promotion_value, 
    ROUND((SUM(discount_value)/SUM(sales))*100, 2) as burn_rate_percentage 
FROM dqlab_sales_store 
WHERE order_status = 'Order Finished' 
GROUP BY YEAR(order_date) 
ORDER BY YEAR(order_date)

# Promotion Effectiveness and Efficiency by Product Sub Category
SELECT 
    YEAR(order_date) as years, 
    product_sub_category, 
    product_category, 
    SUM(sales) as sales, 
    SUM(discount_value) as promotion_value, 
    ROUND((SUM(discount_value)/SUM(sales))*100, 2) as burn_rate_percentage 
FROM dqlab_sales_store 
WHERE 
    order_status = 'Order Finished' 
    AND 
    YEAR(order_date)=2012 
GROUP BY 
    YEAR(order_date), 
    product_sub_category, 
    product_category 
ORDER BY sales DESC

# Customers Transactions per Year
SELECT 
    YEAR(order_date) as years, 
    COUNT(DISTINCT(customer)) as number_of_customer 
FROM dqlab_sales_store 
WHERE order_status = 'Order Finished' 
GROUP BY YEAR(order_date) 
ORDER BY YEAR(order_date)

