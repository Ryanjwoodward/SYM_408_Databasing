/*Author: Ryan Woodward 
Date: 9/9/2022 
Class: SYM408 – Databases for Business Applications 
*/
CREATE TABLE category(category_id VARCHAR(2) PRIMARY KEY NOT NULL, name VARCHAR(30) NOT NULL);   

  

CREATE TABLE customer(customer_id VARCHAR(7) PRIMARY KEY NOT NULL, name VARCHAR(20) NOT NULL, zipcode INT NOT NULL);  

  

CREATE TABLE vendor(vendor_id VARCHAR(2) PRIMARY KEY NOT NULL, name VARCHAR(20) NOT NULL);  

  

CREATE TABLE region(region_id VARCHAR(1) PRIMARY KEY NOT NULL, name VARCHAR(20) NOT NULL);  

  

CREATE TABLE product(product_id VARCHAR(3) PRIMARY KEY NOT NULL, name VARCHAR(30) NOT NULL, price INT NOT NULL, vendor_id VARCHAR(2) 

	FOREIGN KEY  REFERENCES vendor(vendor_id) NOT NULL, category_id VARCHAR(2) FOREIGN KEY REFERENCES category(category_id));  

  

CREATE TABLE store(store_id VARCHAR(2) PRIMARY KEY NOT NULL, name INT NOT NULL, region_id VARCHAR(1) FOREIGN KEY REFERENCES region(region_id));  

  

CREATE TABLE salesTransaction(transaction_id VARCHAR(10) PRIMARY KEY NOT NULL, customer_id VARCHAR(7) FOREIGN KEY REFERENCES customer(customer_id), store_id VARCHAR(2) FOREIGN KEY REFERENCES store(store_id), tdate VARCHAR(12));  

  

CREATE TABLE soldVia(product_id VARCHAR(3) FOREIGN KEY REFERENCES product(product_id), transaction_id VARCHAR(10) FOREIGN KEY REFERENCES salesTransaction(transaction_id), quantitySold INT);   

  

Insert INTO vendor Values ('PG', 'Pacific Gear') 

Insert INTO vendor Values ('MK', 'Mountain King') 

Insert INTO category VALUES ('CP', 'Camping') 

Insert INTO category VALUES ('FW', 'Footwear') 

Insert INTO product VALUES ('1X1', 'Zzz Bag', 100, 'PG','CP') 

Insert INTO product VALUES ('2X2', 'Easy Boot', 70, 'MK','FW') 

Insert INTO product VALUES ('3X3', 'Cosy Sock', 15, 'MK','FW') 

Insert INTO product VALUES ('4X4', 'Dura Boot', 90, 'PG','FW') 

Insert INTO product VALUES ('5X5', 'Tiny Tent', 150, 'MK','CP') 

Insert INTO product VALUES ('6X6', 'Biggy Tent', 250, 'MK','CP') 

Insert INTO region Values ('C', 'Chicagoland') 

Insert INTO region Values ('T', 'Tristate') 

Insert INTO store VALUES ('S1','60600','C') 

Insert INTO store VALUES ('S2','60605','C') 

Insert INTO store VALUES ('S3','35400','T') 

Insert INTO customer VALUES ('1-2-333', 'Tina', '60137') 

Insert INTO customer VALUES ('2-3-444', 'Tony', '60611') 

Insert INTO customer VALUES ('3-4-555', 'Pam', '35401') 

Insert INTO salesTransaction VALUES ('T111', '1-2-333', '01/Jan/2013','S1') 

Insert INTO salesTransaction VALUES ('T222', '2-3-444', '01/Jan/2013','S2') 

Insert INTO salesTransaction VALUES ('T333', '1-2-333', '02/Jan/2013','S3') 

Insert INTO salesTransaction VALUES ('T444', '3-4-555', '02/Jan/2013','S3') 

Insert INTO salesTransaction VALUES ('T555', '2-3-444', '02/Jan/2013','S3') 

Insert Into soldvia values ('1x1','T111',1) 

Insert Into soldvia values ('2x2','T222',1) 

Insert Into soldvia values ('3x3','T333',5) 

Insert Into soldvia values ('1x1','T333',1) 

Insert Into soldvia values ('4x4','T444',1) 

Insert Into soldvia values ('2x2','T444',2) 

Insert Into soldvia values ('4x4','T555',4) 

Insert Into soldvia values ('5x5','T555',2) 

Insert Into soldvia values ('6x6','T555',1) 