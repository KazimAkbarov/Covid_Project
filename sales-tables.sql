
use Sales;

drop table Sales_1;
 
CREATE TABLE Sales_1 (
	Count int null,
    Sales_ID int null,
    Product_ID int null,
    Product_Name VARCHAR(255) null,
    Product_Category VARCHAR(255) null,
    Product_Price Decimal(5,2) null,
    Sales_Date varchar(20) null,
    Discount_Campaign VARCHAR(50) null,
    Loyalty_Card varchar(10) null,
    Store varchar(50) null,
    Store_lat varchar(100) null,
    Store_long varchar(100) null
    
);

select * from Sales_1
where Sales_ID = null or Product_ID = null;

-------------------------------------------


CREATE TABLE Transactions (
	Transaction_Date text null,
    Expired_Date text null,
    Store_ID varchar(50) null,
    Product_ID text null,
    Product_Category text null,
    Salesperson_ID text null,
    Sales_Volume int null,
    Sales_Sum int null
);

drop table Transactions;
Select * 
from Transactions 
where
	Transaction_date = '01.01.01';
    
ALTER Table transactions 
drop column sales_sum;

-- Making the safe mode deactived and able to import csv files
SET SQL_SAFE_UPDATES = 0;

-- modify the table
update Transactions
set
	Product_Category = 'Idman'
where
	Product_Category =  '_dman';

CREATE TABLE Sales_Person (
	Salesperson_ID text null,
    Salesperson_Full_Name text null,
    Salesperson_Store TEXT null
);

drop table Sales_person;
Select * from Sales_person ;

-- modify the table
update Sales_person

set
	Salesperson_Store = 'Izmir'
where
	Salesperson_Store = '_ZM_R';


CREATE TABLE Products (
	Product_ID text null,
    Product_name text null,
    Product_type TEXT null,
    Product_Price int null
);

-- drop table PRODUCTS	;
Select distinct product_type from Products ;

-- modify the table
update Products

set
	product_type = 'Idman'
where
	product_type = '_dman';

CREATE TABLE Stores (
	Store_ID text null,
    Store_name text null,
    Store_area TEXT null
);

-- drop table Stores	;
Select * from Stores ;

-- modify the table
update Stores

set
	Store_area = 'Seki-Zaqatala'
where
	Store_area = 'Seki-Zaqatala';


LOAD DATA LOCAL INFILE '/Users/kazimakbarov/Documents/Process.csv'
INTO TABLE Transactions
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
ignore 1 rows
;


-- modify the table
alter table stores rename column store_id_1 to store_id;

select * from sales_All;

select * from stores;

create table Sales_All as 

select *
from 
	transactions 
inner join 
	sales_person
on transactions.salesperson_id = sales_person.salesperson_id_1;

-- join products

-- on transcations.product_id = products.product_id;

-- join stores st

-- on sl.store_id = st.store_id);

select * from sales_All

where store_name <> null ;



