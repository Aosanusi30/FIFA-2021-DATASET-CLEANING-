-- Running the database through the directory 
use datacleaningchallenge

-- The Dataset consists of 18979 fields and 77 columns 
SELECT count(*) as [Number of fields]
from fifadatasets

-- Inspecting the database for cleaning 
SELECT * 
FROM fifadatasets

-- Inspecting ID, name and longname field
SELECT ID, name, longname
FROM fifadatasets

/* COMMENT
Most of the names and longnames are written in the players native language and are ok. 
There is not need in cleaning these columns 
*/

-- photourl and playerurl are needed so these columns will be droped
ALTER TABLE fifadatasets
DROP COLUMN photourl, playerurl

-- inspecting the next four column nationality, age ova, pot 
SELECT nationality, Age, OVA, POT 
FROM fifadatasets

-- Changing the OVA and POT TO  Overall rating and  Potential rating,
EXEC sp_rename 'fifadatasets.OVA','Overall_rating','COLUMN'

EXEC sp_rename 'fifadatasets.POT','Potential_rating','COLUMN'

-- Inspecting the datasets
SELECT * 
FROM fifadatasets

-- Cleaning the club column
UPDATE fifadatasets 
SET CLUB = SUBSTRING(CLUB, 5, 40)


-- Cleaning the contract column replace the ~ with -
UPDATE fifadatasets 
SET Contract = REPLACE(CONTRACT, ' ~ ', ' - ') 

-- Creating additional column for the contract to differencial the type of contract 
ALTER TABLE fifadatasets
ADD Contract_type nvarchar(255)

-- Inspecting values into the column created 
UPDATE fifadatasets
SET Contract_type = CASE
						WHEN contract like '20%' THEN 'Contract'
						WHEN contract like '%on loan%' THEN 'On loan'
						WHEN contract like '%Free%' THEN 'Free'
						ELSE Contract
						END


-- Removing the on loan at the end of the Contract 
UPDATE fifadatasets
SET Contract = REPLACE(Contract, 'On Loan', '')
where contract like '%on loan%'


-- Convert height from inches to cm 
UPDATE fifadatasets
SET Height = CASE 
				WHEN Height LIKE '%cm' then SUBSTRING(height, 1,3)
				when Height like '%''%"' then SUBSTRING(height, 1, CHARINDEX('''', Height)-1) * 30.48 +
				SUBSTRING(Height, 3, CHARINDEX('"', height)-3) 
				ELSE height 
				end 
FROM fifadatasets
where height like '%''%"'

-- Add the unit to the name of the height column
EXEC sp_rename 'fifadatasets.height','height(cm)','COLUMN'

-- Removing the cm from the height value 
UPDATE fifadatasets
SET [height(cm)] = REPLACE([height(cm)], 'cm','')

-- Converting the height value to decimal places.
ALTER TABLE fifadatasets
alter column [height(cm)] decimal(10,0) 


-- Inspecting the database for cleaning 
SELECT * 
FROM fifadatasets

-- Convert weight from lbs to kg 
UPDATE fifadatasets
SET Weight = CASE 
				WHEN Weight like '%kg' then SUBSTRING(Weight, 1,2)
				when Weight like '%lbs' then try_convert(decimal(10,0), SUBSTRING (Weight, 1,3)) * 0.45
				ELSE Weight
				END

-- Changing the data type from nvarchar to decimal
ALTER TABLE fifadatasets
ALTER COLUMN Weight decimal(10,0)

-- Renaming the weight from weight to weight(kg) 
EXEC sp_rename 'fifadatasets.weight','Weight(kg)','COLUMN'

-- Changing the Joined date type from date/time to date 
ALTER TABLE fifadatasets
ALTER COLUMN Joined date

-- Inserting 00:00:00 into Loan Date End when Loan Date End is Null 
UPDATE fifadatasets
SET [Loan Date End] = CASE 
						WHEN [Loan Date End] like '' THEN '00:00:00'
						ELSE [Loan Date End]
						END
FROM fifadatasets
where [Loan Date End] like ''

-- Cleaning the Value, Wage and Release Clause column.
-- Removing the €, K and M
UPDATE fifadatasets
SET Value = CASE 
			WHEN Value like '€%' AND Value like '%K' THEN TRY_CONVERT(decimal(10,0),REPLACE(REPLACE(Value,'€',''),'K','')) * 1000
			WHEN Value like '€%' AND Value like '%M' THEN TRY_CONVERT(decimal(10,0),REPLACE(REPLACE(Value,'€',''),'M','')) * 1000000
			WHEN Value like '€%' THEN TRY_CONVERT(decimal(10,0),REPLACE(Value,'€',''))
			ELSE Value
			END 

update fifadatasets
set Wage = case 
			when Wage LIKE '€%' and Wage LIKE '%M' THEN TRY_CONVERT(decimal(10,0),REPLACE(REPLACE(Wage,'€',''),'M','')) * 1000000
			when Wage like '€%' and Wage LIKE '%K' THEN TRY_CONVERT(decimal(10,0), REPLACE(REPLACE(Wage,'€',''),'K','')) * 1000
			when Wage like '€%' THEN TRY_CONVERT(decimal(10,0),REPLACE(Wage,'€',''))
			else Wage
			end

update fifadatasets
set [Release Clause] = case 
			when [Release Clause] LIKE '€%' and [Release Clause] LIKE '%M' THEN TRY_CONVERT(decimal(10,0),REPLACE(REPLACE([Release Clause],'€',''),'M','')) * 1000000
			when [Release Clause] like '€%' and [Release Clause] LIKE '%K' THEN TRY_CONVERT(decimal(10,0), REPLACE(REPLACE([Release Clause],'€',''),'K','')) * 1000
			when [Release Clause] like '€%' THEN TRY_CONVERT(decimal(10,0),REPLACE([Release Clause],'€',''))
			else [Release Clause]
			end

-- CLeaning the W/F, SM, IR by removing the ★
update fifadatasets
set [W/F] = SUBSTRING([W/F],1,1)

update fifadatasets
set SM = SUBSTRING([W/F],1,1)

update fifadatasets
set IR = SUBSTRING([W/F],1,1)

-- Converting K in the hits column to 1000 
update fifadatasets
SET Hits = case 
			when Hits like '%K' then try_convert(float,SUBSTRING(hits, 1, CHARINDEX('K',hits)-1)) * 1000
			ELSE hits
			END 
where hits like '%K'

-- Inspecting the columns for further cleaning 
SELECT * 
from fifadatasets

-- END OF CLEANING 