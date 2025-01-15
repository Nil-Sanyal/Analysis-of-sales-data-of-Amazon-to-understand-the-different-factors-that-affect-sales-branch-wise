
CREATE DATABASE Amazon_Myanmar ;
USE Amazon_Myanmar;

CREATE TABLE Amazon_Myanmar (
    invoice_id VARCHAR(50) PRIMARY KEY NOT NULL,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    VAT FLOAT(6, 4) NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    date_rec DATE NOT NULL,
    time_rec TIME NOT NULL,
    payment_mode VARCHAR(30) NOT NULL,
    cogs DECIMAL(10, 2) NOT NULL,
    gross_margin_percentage FLOAT(10,2) NOT NULL,
    gross_income DECIMAL(10, 2) NOT NULL,
    rating FLOAT(2, 1) NOT NULL

);

-- select * from Amazon_Myanmar;

 -- DROP DATABASE Amazon_Myanmar; 

/* Setting the 'Safe Update mode to 'OFF' */ 

USE Amazon_Myanmar;

SET SQL_SAFE_UPDATES = 0;
 
-- SELECT * FROM Amazon_Myanmar;

/* Adding a new Column Time_of_Day to our Database */ 
 ALTER TABLE Amazon_Myanmar
 Add time_of_day VARCHAR(100); 
 
 
 /* Updating newly added coloumn with the value of existing column by using CASE as there is condion */
 
 UPDATE Amazon_Myanmar
SET time_of_day = CASE
	WHEN HOUR(time_rec) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN HOUR(time_rec) BETWEEN 12 AND 18 THEN 'Afternoon'
    WHEN HOUR(time_rec) BETWEEN 18 AND 21 THEN 'Evening'
    ELSE 'Night'
END;

/* Adding a new Column Day_Name to our Database */ 
 ALTER TABLE Amazon_Myanmar
 Add Day_Name VARCHAR(100); 
 
 -- Updating Day_nmae Column
 UPDATE Amazon_Myanmar
SET Day_Name = DAYName(date_rec)  

-- SELECT Day_Name FROM Amazon_Myanmar;

/* Adding a new Column Month_Name to our Database */ 
 ALTER TABLE Amazon_Myanmar
 Add Month_Name VARCHAR(100); 
 
 -- Updating Month_name Column
 UPDATE Amazon_Myanmar
SET Month_Name = MONTHNAME(date_rec) 

-- SELECT Month_Name FROM Amazon_Myanmar;

SELECT * FROM Amazon_Myanmar;

/* DROP COLUMN time_of_day;  */ 





