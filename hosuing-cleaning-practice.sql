create schema Housing;

drop table Housing;

CREATE TABLE Housing (
    Unique_ID int  not null primary key,
    Parcel_ID text null,
    Land_Use VARCHAR(255) null,
    Property_Adress VARCHAR(255) null,
    Sale_Date VARCHAR(255) null,
    Sale_Price int null,
    Legal_Reference VARCHAR(255) null,
    Sold_as_vacant VARCHAR(50) null,
    Owner_Name text null,
    Owner_Adress text null,
    Acreage text null,
    Tax_Distrcit VARCHAR(255) null,
    Land_Value int null,
    Building_Value int null,
    Total_Value int null,
    Year_built int null,
    Bedrooms int null,
    Full_bath int null,
    Half_bath int null
);


-- Impport the CSV
LOAD DATA LOCAL INFILE '/Users/kazimakbarov/Documents/Housing_data.csv'
INTO TABLE Housing
FIELDS TERMINATED BY ';'
ENCLOSED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 2 ROWS
;

select * from Housing;

---------------------------------------------------------------------------


Select sale_date
From housing;


(-- Testing Date replacement

select sale_date from housing where sale_date  like '%January%';

drop table test;
create table  test as
select sale_date, concat(right(sale_date,4),"-1","-",replace(mid(sale_date,8,3), ',',"")) as datt from housing
where sale_date  like '%January%';

select * from test;

update test

set datt = replace(datt, " ", '');

update test

set datt = convert(datt, date););


Select *
From housing
Where Property_adress is null
order by Parcel_ID;



Select a.Parcel_ID, a.Property_Adress, b.Parcel_ID, b.Property_Adress 
From housing a
JOIN housing b
	on a.parcel_id = b.parcel_id AND a.Unique_ID <> b.Unique_ID
Where a.property_adress is null;

select property_adress from housing;

select 
	substring(property_adress, 1,(locate(",", property_adress)-1)),
	substring(property_adress,(locate(",", property_adress)+1), length (property_adress))
 from housing;
 
 alter table housing
 
 add column Property_Address text;
 
alter table housing
add column Property_City text;
 
 update housing
 set Property_address = substring(property_adress, 1,(locate(",", property_adress)-1));
 
update housing
set property_city =   substring(property_adress,(locate(",", property_adress)+1), length (property_adress));
 
 
select owner_adress from housing;
 
 
select substring_index( owner_adress, ',',1) from housing;
 
 
alter table housing 
add column Owner_Address text;
 
update housing
set Owner_Address  = substring_index( owner_adress, ',',1);
 
 
alter table housing
add column Owner_city text;
 
update housing
set Owner_City  = substring_index( owner_adress, ',',2);
 
alter table housing
add column Owner_State text;
 
update housing
set Owner_State  = substring_index( owner_adress, ',',3);
 
 
 
Select 
	distinct sold_as_vacant, count(sold_as_vacant) 
from 
	housing
group by 
	sold_as_vacant
order by 2;


select 
	sold_as_vacant, 
   ( case
		when sold_as_vacant = 'Y' then 'Yes'
        when sold_as_vacant = 'N' then 'No'
        else sold_as_vacant end)
from
	housing;
    
update housing
set sold_as_vacant =  (case
						when sold_as_vacant = 'Y' then 'Yes'
						when sold_as_vacant = 'N' then 'No'
						else sold_as_vacant end);
					
    


with tem_table as(

select *,
	row_number() over (
						partition by parcel_id, property_adress, sale_price, legal_reference
						order by unique_id) tem
                        
from
	housing)
select * 
	from tem_table
where
	tem>1;

select * from housing;

alter table housing

drop column Property_adress, drop column owner_adress;

alter table housing
;
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    

