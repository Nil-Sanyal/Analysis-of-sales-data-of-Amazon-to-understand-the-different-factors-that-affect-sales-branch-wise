USE Amazon_Myanmar;
-- 1. What is the count of distinct cities in the dataset?
Select City, Count(Distinct City) As Count_of_Distinct_City
  From Amazon_Myanmar
  Group By City;
  
-- 2. For each branch, what is the corresponding city?
Select distinct city, Branch 
from Amazon_Myanmar;

-- 3. What is the count of distinct product lines in the dataset?

Select Count(Distinct product_line) As product_lines_Count
from amazon_myanmar;

-- 4. Which payment method occurs most frequently?

Select Distinct payment_mode, count(payment_mode) As Total_No_Transaction 
from amazon_myanmar
Group By payment_mode
Order by Count(payment_mode) DESC;


-- 5. Which product line has the highest sales?
Select product_line, Sum(quantity * unit_price) As Sales
from amazon_myanmar
Group By product_line
Order by Sum(quantity * unit_price) DESC;

-- 6. How much revenue is generated each month?

Select Month_Name, Sum(quantity * unit_price) as Revenue_Earned
From amazon_myanmar
Group By Month_Name
Order By Sum(quantity * unit_price) DESC;

-- 7. In which month did the cost of goods sold reach its peak?

Select Month_Name, max(cogs) As maximum_Cost_of_Goods_Sold
from amazon_myanmar
Group By Month_Name
Order by max(cogs) DESC;


-- 8. Which product line generated the highest revenue?

Select product_line, max(quantity * unit_price) As Maximum_Revenue
from amazon_myanmar
Group By product_line
Order By max(quantity * unit_price) DESC;


-- 9 In which city was the highest revenue recorded?

Select city, Sum(quantity * unit_price) as Revenue_Recorded
from amazon_myanmar
Group By city
Order By Sum(quantity * unit_price) DESC;


-- 10. Which product line incurred the highest Value Added Tax?

Select product_line, max(VAT) As Highest_Value_Added_Tax
from amazon_myanmar
Group By product_line
Order By max(VAT) DESC;

-- 11. For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."

With Avg_Sale As (
    Select Avg(gross_income) As avg_income
    FROM amazon_myanmar
)
SELECT 
    product_line, 
    gross_income AS Sales,
    CASE
        WHEN gross_income > avg_income THEN 'Good'
        ELSE 'Bad'
    END AS Sales_Cat
FROM amazon_myanmar, Avg_Sale;

-- 12. Identify the branch that exceeded the average number of products sold.

With Avg_Quantity As (
    Select Avg(quantity) As avg_quantity
    FROM amazon_myanmar
)
SELECT 
    branch, Sum(quantity) AS Product_Sold 
    From amazon_myanmar
    Group By branch
    Having Sum(quantity) > (Select avg_quantity FROM Avg_Quantity);


-- 13. Which product line is most frequently associated with each gender?

SELECT 
    product_line, 
    gender, 
    Count_product
FROM (
    SELECT 
        product_line, 
        gender, 
        COUNT(product_line) AS Count_product,
        ROW_NUMBER() OVER (PARTITION BY gender ORDER BY COUNT(product_line) DESC) 
    FROM 
        amazon_myanmar
    GROUP BY 
        product_line, gender
) RankedProducts


-- 14. Calculate the average rating for each product line.

Select avg(rating) as Avg_rating, product_line
from Amazon_myanmar
Group By product_line
order By avg(rating) Desc;

-- 15. Count the sales occurrences for each time of day on every weekday.

Select time_of_day, Day_Name, 
Count(*) As Num_Sales 

From amazon_myanmar
Group By time_of_day, Day_Name;

-- 16. Identify the customer type contributing the highest revenue.

Select customer_type, max(quantity * unit_price) As Max_Revenue
from amazon_myanmar
Group By customer_type;

-- 17. Determine the city with the highest VAT percentage.

Select City, max(VAT) As Maximum_VAT_Contributing_city
from amazon_myanmar
Group By City
Order By max(VAT) DESC;

-- 18. Identify the customer type with the highest VAT payments.

Select customer_type, Max(VAT) As Maximum_VAT_Contributing_Customer_Type
from amazon_myanmar
Group by Customer_type
Order By Max(VAT) DESC;

-- 19. What is the count of distinct customer types in the dataset?

Select customer_type, Count(Distinct customer_type) As Count_Distinct_Customer_Type
from amazon_myanmar
Group By Customer_type;

-- 20. What is the count of distinct payment methods in the dataset?

Select payment_mode, Count(distinct payment_mode) As Count_Dist_Payment_Mode
from amazon_myanmar
Group By payment_mode;

-- 21. Which customer type occurs most frequently?

Select Customer_type, count(Customer_type) As Frequency_of_Customer
from amazon_myanmar
Group BY Customer_type;


-- 22. Identify the customer type with the highest purchase frequency.

Select Customer_type, Count(*) As Purchase_frequency
from amazon_myanmar
Group BY Customer_type; 


-- 23. Determine the predominant gender among customers.

Select gender, count(gender) As Gender_Insights
from amazon_myanmar
Group By gender;

-- 24. Examine the distribution of genders within each branch.

Select branch, gender, count(gender) As Gender_Insights
from amazon_myanmar
Group By branch, gender;

-- 25. Identify the time of day when customers provide the most ratings.

Select time_rec, max(rating) as Max_rating
from amazon_myanmar
Group by time_rec;

-- 26. Determine the time of day with the highest customer ratings for each branch.

Select branch, time_rec, max(rating) as Max_rating
from amazon_myanmar
Group by time_rec, branch;


-- 27. Identify the day of the week with the highest average ratings.


With Avg_Rating As (
Select Day_Name, avg(rating) As Average_Rating
From amazon_myanmar
GROUP BY Day_Name
) 
Select Day_name, max(Average_Rating) As Highest_Average_Ratings
From Avg_Rating
Group By Day_name
Order By max(Average_Rating) DESC
limit 1;
 
-- 28. Determine the day of the week with the highest average ratings for each branch.


With Avg_Rating As (
Select branch, Day_Name, avg(rating) As Average_Rating
From amazon_myanmar
GROUP BY Day_Name, branch
) 
Select branch, Day_name, max(Average_Rating) As Highest_Average_Ratings
From Avg_Rating
Group By Day_name, branch
Order By max(Average_Rating) DESC
limit 1;
