/*
Author: Ryan Woodward 9/16/2022 
*/

CREATE DATABASE SalesDataWarehouse; 

  

USE SalesDataWarehouse 

  

/* DIMENSION TABLES -------------------------------------------------------------------*/ 

CREATE TABLE store(store_id INT NOT NULL IDENTITY PRIMARY KEY, zipcode INT NOT NULL, regionName NVARCHAR(50)); 

  

/* If we have control over the data use VARCHAR if we do not have control use NVARCHAR*/ 

CREATE TABLE Product(product_id INT NOT NULL IDENTITY PRIMARY KEY, productName VARCHAR(50) NOT NULL, price DECIMAL(5,2) ,vendor NVARCHAR(30), categoryName NVARCHAR(50));  

/*Altering table to change the datatype can go into 'design' menu for an individual table*/ 

  

CREATE TABLE customer(customer_id INT NOT NULL IDENTITY PRIMARY KEY, firstName NVARCHAR(50), lastName NVARCHAR(50), zipcode INT NOT NULL); 

  

CREATE TABLE Calendar(calendar_id INT NOT NULL IDENTITY PRIMARY KEY, fulldate DATETIME, day_of_week INT, day_of_month INT, month_Of_Sale INT, quarter_of_sale INT, year_of_sale INT); 

  

/* FACT TABLE -------------------------------------------------------------------*/ 

CREATE TABLE Sale(dollars_sold DECIMAL(5,2), units_sold INT, calendar_id INT FOREIGN KEY REFERENCES Calendar(calendar_id), store_id INT FOREIGN KEY REFERENCES Store(store_id), 

customer_id INT FOREIGN KEY REFERENCES Customer(customer_id), product_id INT FOREIGN KEY REFERENCES Product(product_id)); 

  

/* DATA INSERTION ------------------------------------------------------------------*/  

/*store: store_id, zipcode, regionName*/ 

INSERT store VALUES(81234, 'Peoria'), (31235, 'Phoenix'), (31777, 'Glendale'),(00000, 'Online Store'); 

  

/* customer: customer_id, firstName, lastName, zipcode*/ 

INSERT customer VALUES('John', 'Smith', 85381),('Joe', 'Block', 85482), ('Jimmy', 'John', 83482), ('Pork', 'Chop', 12482), ('Tater', 'Tot', 13672); 

  

/* calendar: calendar_id, fulldate, dayOfWeek, dayOfMonth, monthOfSale, quarterOfSale, yearOfSale NOTE: SUN=1, MON=2...*/ 

INSERT INTO Calendar VALUES('2022-09-01 12:05:00', 5, 1, 9, 3, 2022),('2022-09-14 1:04:10', 4, 14, 9, 3, 2022),('2022-09-13', 3, 13, 9, 3, 2022); 

  

/* product: product_id, productName, price, vendor, categoryName*/ 

INSERT INTO Product VALUES('Semi-Gloss White Paint', 74.23, 'Behr', 'Paint'),('Paradise Palm Artificial Tree', 89.95, 'Tree Vendor A', 'Lawn and Garden'), 

('Cushioned Bar Stool', 390.17,'HomeFun','Furniture'),('Smoke Detector', 29.88,'Kiddie','Fire Safety'), ('Flat Black Paint', 50.75,'Behr','Paint'),  

('Satin Pink Paint', 68.52,'Behr','Paint'),('Loveseat', 486.62,'HomeFun','Furniture'),('Outdoor Green Paint', 98.52,'Behr','Paint'),('ABC Fire Extinguisher', 29.89,'Kiddie','Fire Safety'), 

('Dog and Cat Paint', 798.52,'Behr','Paint'),('Fire Extinguisher Cabinet', 42.66,'Kidie','Fire Safety'); 

 

/* FACT TABLE DATA INSERTION -----------------------------------------------------*/ 

/* Sale:  dollarSold, unitsSold, calendar_id, store_id, customer_id, product_id, */ 

INSERT INTO Sale VALUES(74.23, 1, 1, 1, 1, 1),(89.95, 3, 1, 1, 1, 2),(390.17, 4, 1, 1, 1, 3),  

(29.88, 5, 2, 2, 2, 4),(50.75, 7, 2, 2, 2, 5),(68.52, 2, 2, 3, 3, 6),(486.62, 7, 2, 3, 3, 7), 

(98.52, 1, 3, 4, 4, 8),(29.89, 3, 3, 4, 4, 9), (798.52, 1, 3, 4, 5, 10), (42.66, 3, 3, 4, 5,11); 

 

 

 

/*  Original Query  */ 

SELECT SUM(Sale.units_sold) Qty FROM Sale  

JOIN Calendar cal ON Sale.calendar_id = cal.calendar_id 

JOIN Product prd ON Sale.product_id = prd.product_id 

JOIN store ON Sale.store_id = store.store_id  

WHERE cal.day_of_week = '4'  

AND prd.categoryName = 'paint' 

AND prd.vendor = 'Behr' 

AND store.regionName IN ('Phoenix','Peoria','Glendale') 

AND cal.quarter_of_sale = '3' 

AND cal.year_of_sale = '2022'; 

  

/* Altered Query   */ 

SELECT SUM(Sale.units_sold) Qty FROM Sale  

JOIN Calendar cal ON Sale.calendar_id = cal.calendar_id 

JOIN Product prd ON Sale.product_id = prd.product_id 

JOIN store ON Sale.store_id = store.store_id  

WHERE DATEPART(DW, cal.fulldate) = '4'  

AND prd.categoryName = 'paint' 

AND prd.vendor = 'Behr' 

AND store.regionName IN ('Phoenix','Peoria','Glendale') 

AND DATEPART(QUARTER, cal.fulldate) = '3' 

AND DATEPART(YEAR, cal.fulldate) = '2022'; 