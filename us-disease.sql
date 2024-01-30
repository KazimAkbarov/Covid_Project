use Disease;

drop table if exists US_Diseases;
 
 
CREATE TABLE US_Diseases (
    Start_Year int null,
    End_Year int null,
    Location_ABBR VARCHAR(255) null,
    Location VARCHAR(255) null,
    Data_Source VARCHAR(255) null,
    Topic VARCHAR(255) null,
    Question VARCHAR(255) null,
    Data_Value_Type VARCHAR(50) null,
    Data_Value decimal(10, 2) null,
    Data_Value_Alt decimal(10, 2) null,
    Low_Confidence_Limit decimal(10,2) null,
    High_Confidence_Limit DECIMAL(10, 2) null,
    Stratification_Category_1 VARCHAR(255) null,
    Stratification_1 VARCHAR(255) null,
    Geo_Location varchar(100) null,
    Location_ID INT null,
    Topic_ID VARCHAR(50) null,
    Question_ID VARCHAR(50) null,
    Data_Value_Type_ID VARCHAR(50) null,
    Stratification_Category_ID_1 VARCHAR(50) null,
    Stratification_ID_1 VARCHAR(50) null
);

describe us_diseases;

(-- For error in MYSQL, not let modfy the rows 
SET SQL_SAFE_UPDATES = 0;

-- For error in MYSQL, not able to import from csv
SHOW GLOBAL VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = true;

);

-- Impport the CSV
LOAD DATA LOCAL INFILE '/Users/kazimakbarov/Documents/Project_3.csv'
INTO TABLE US_Diseases
FIELDS TERMINATED BY ';'
-- ENCLOSED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
;


(-- Used for to elimintae the Null cell.
-- delete from us_diseases 
-- where DataValue = 0 or DataValueAlt = 0;

-- update us_disease
-- set LowConfidenceLimit = null
-- where LowConfidenceLimit = 0;

-- update us_disease
-- set HighConfidenceLimit = null
-- where HighConfidenceLimit = 0;


-- LOAD DATA LOCAL INFILE '/Users/kazimakbarov/Documents/US_Disease.csv' 
-- INTO TABLE US_Diseases
-- FIELDS TERMINATED BY ',' 
-- ignore 1 lines;

-- alter table us_diseases

-- Modify YearStart year,
-- Modify YearEnd year,
-- Modify LocationAbbr text,
-- Modify LocationDesc text,
-- Modify DataSource text,
-- Modify Topic text,
-- Modify Question text,
-- Modify Response text,
-- Modify DataValueType varchar(100),
-- Modify DataValue decimal(10,2),
-- Modify DataValueAlt decimal(10,2),
-- Modify DataValueFootnoteSymbol text,
-- Modify DatavalueFootnote text,
-- Modify LowConfidenceLimit decimal(10,2),
-- Modify HighConfidenceLimit decimal(10,2),
-- Modify StratificationCategory1 text,
-- Modify Stratification1 text,
-- Modify GeoLocation varchar(100),
-- Modify ResponseID text,
-- Modify LocationID int,
-- Modify TopicID varchar(50),
-- Modify QuestionID varchar(50),
-- Modify DataValueTypeID varchar(50),
-- Modify StratificationCategoryID1 text,
-- Modify StratificationID1 text;
);


select Gender from US_Diseases;

alter table US_Diseases
drop column  Data_Value_Alt, drop column Data_Value_Type;

select  Stratification_Category_1 from US_Diseases;

alter table US_Diseases

add Gender text;


select Stratification_1 from US_Diseases
where Stratification_Category_1 = 'Gender';

select Data_Value_Type_ID from us_diseases;

drop table diseases_1;


CREATE TABLE Diseases_1 (
    Start_Year int null,
    End_Year int null,
    Location VARCHAR(255) null,
    Data_Source VARCHAR(255) null,
    Topic VARCHAR(255) null,
    Question VARCHAR(255) null,
    Data_Value decimal(10, 2) null,
    Low_Confidence_Limit decimal(10,2) null,
    High_Confidence_Limit DECIMAL(10, 2) null,
    Race VARCHAR(100) null,
    Geo_Location varchar(100) null,
    Location_ID INT null,
    Topic_ID VARCHAR(50) null,
    Question_ID VARCHAR(50) null
);

CREATE TABLE Diseases (
    Start_Year int null,
    End_Year int null,
    Location VARCHAR(255) null,
    Data_Source VARCHAR(255) null,
    Topic VARCHAR(255) null,
    Question VARCHAR(255) null,
    Data_Value decimal(10, 2) null,
    Low_Confidence_Limit decimal(10,2) null,
    High_Confidence_Limit DECIMAL(10, 2) null,
    Gender VARCHAR(100) null,
    Geo_Location varchar(100) null,
    Location_ID INT null,
    Topic_ID VARCHAR(50) null,
    Question_ID VARCHAR(50) null
);

(insert into Diseases_1
	(Start_Year, End_Year , Location, Data_Source,Topic,Question, Data_Value, Low_Confidence_Limit, High_Confidence_Limit , Race, Geo_Location, Location_ID, Topic_ID , Question_ID)
select 
	Start_Year, End_Year , Location, Data_Source,Topic,Question, Data_Value, Low_Confidence_Limit, High_Confidence_Limit , Stratification_1, Geo_Location, Location_ID, Topic_ID , Question_ID
from
	US_diseases
where   Stratification_Category_1 = 'Race/Ethnicity';

insert into Diseases
	(Start_Year, End_Year , Location, Data_Source,Topic,Question, Data_Value, Low_Confidence_Limit, High_Confidence_Limit , Gender, Geo_Location, Location_ID, Topic_ID , Question_ID)
select 
	Start_Year, End_Year , Location, Data_Source,Topic,Question, Data_Value, Low_Confidence_Limit, High_Confidence_Limit , Stratification_1, Geo_Location, Location_ID, Topic_ID , Question_ID
from
	US_diseases
where   Stratification_Category_1 = 'Gender';);


select * from diseases_1;






