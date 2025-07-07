use ndap;


-- ----------------------------------------------------------------------------------------------
-- SECTION 1. 
-- SELECT Queries [5 Marks]

-- 	Q1.	Retrieve the names of all states (srcStateName) from the dataset.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
-- <write your answers in the empty spaces given, the length of solution queries (and the solution writing space) can vary>
select distinct srcStateName
from farmerinsurancedata;

###

-- 	Q2.	Retrieve the total number of farmers covered (TotalFarmersCovered) 
-- 		and the sum insured (SumInsured) for each state (srcStateName), ordered by TotalFarmersCovered in descending order.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcStateName,sum(TotalFarmersCovered) as TotalFarmers,
sum(SumInsured) as TotalSumInsured
from farmerinsurancedata
group by srcStateName
order by TotalFarmers desc;

-- ###

-- --------------------------------------------------------------------------------------
-- SECTION 2. 
-- Filtering Data (WHERE) [15 Marks]

-- 	Q3.	Retrieve all records where Year is '2020'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select * from farmerinsurancedata
where srcYear = 2020;

-- ###

-- 	Q4.	Retrieve all rows where the TotalPopulationRural is greater than 1 million and the srcStateName is 'HIMACHAL PRADESH'.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select TotalPopulationRural,srcStateName from farmerinsurancedata
where srcStateName ='HIMACHAL PRADESH' and TotalPopulationRural > 1000000;

-- ###

-- 	Q5.	Retrieve the srcStateName, srcDistrictName, and the sum of FarmersPremiumAmount for each district in the year 2018, 
-- 		and display the results ordered by FarmersPremiumAmount in ascending order.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcStateName, srcDistrictName, sum(FarmersPremiumAmount) as TotalFarmerspremiums
from farmerinsurancedata
where srcYear = 2018
group by srcStateName ,srcDistrictName
order by TotalFarmerspremiums asc;
-- ###

-- 	Q6.	Retrieve the total number of farmers covered (TotalFarmersCovered) and the sum of premiums (GrossPremiumAmountToBePaid) for each state (srcStateName) 
-- 		where the insured land area (InsuredLandArea) is greater than 5.0 and the Year is 2018.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcStateName,
sum(TotalFarmersCovered) as TotalFarmersCovered,
sum(GrossPremiumAmountToBePaid) as TotalGrossperiums
from farmerinsurancedata
where InsuredLandArea > 5.0 and srcYear=2018
group by srcStateName
order by TotalGrossperiums ;

	  
-- ###
-- ------------------------------------------------------------------------------------------------

-- SECTION 3.
-- Aggregation (GROUP BY) [10 marks]

-- 	Q7. 	Calculate the average insured land area (InsuredLandArea) for each year (srcYear).
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT avg(InsuredLandArea) as AvgLandArea ,srcYear
from farmerinsurancedata
group by srcYear
order by AvgLandArea;


-- ###

-- 	Q8. 	Calculate the total number of farmers covered (TotalFarmersCovered) for each district (srcDistrictName) where Insurance units is greater than 0.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcStateName,srcDistrictName,
sum(TotalFarmersCovered) as TotalFarmersCovered
from farmerinsurancedata
where `Insurance units` > 0
group by srcStateName,srcDistrictName
order by TotalFarmersCovered;


-- ###

-- 	Q9.	For each state (srcStateName), calculate the total premium amounts (FarmersPremiumAmount, StatePremiumAmount, GOVPremiumAmount) 
-- 		and the total number of farmers covered (TotalFarmersCovered). Only include records where the sum insured (SumInsured) is greater than 500,000 (remember to check for scaling).
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcStateName,
 sum(FarmersPremiumAmount)as TotalFarmersperiums,
 sum(StatePremiumAmount) as TotalStatepermiums,
 sum(GOVPremiumAmount) as TotalperiumsAmount,
 sum(TotalFarmersCovered) as TotalFarmersCovered
 from farmerinsurancedata
 where SumInsured > '500,000'
 group by srcStateName
 order by TotalFarmersCovered;
 


-- ###

-- -------------------------------------------------------------------------------------------------
-- SECTION 4.
-- Sorting Data (ORDER BY) [10 Marks]

-- 	Q10.	Retrieve the top 5 districts (srcDistrictName) with the highest TotalPopulation in the year 2020.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcDistrictName,TotalPopulation,srcStateName
from farmerinsurancedata
where srcYear = 2020
order by TotalPopulation desc
limit 5;



-- ###

-- 	Q11.	Retrieve the srcStateName, srcDistrictName, and SumInsured for the 10 districts with the lowest non-zero FarmersPremiumAmount, 
-- 		ordered by insured sum and then the FarmersPremiumAmount.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcStateName, srcDistrictName, SumInsured,FarmersPremiumAmount
from farmerinsurancedata
where  FarmersPremiumAmount > 0
order by SumInsured asc,FarmersPremiumAmount asc
limit 10;


###

-- 	Q12. 	Retrieve the top 3 states (srcStateName) along with the year (srcYear) where the ratio of insured farmers (TotalFarmersCovered) to the total population (TotalPopulation) is highest. 
-- 		Sort the results by the ratio in descending order.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcStateName,srcYear,
round(sum(TotalFarmersCovered)/sum(TotalPopulation),4) as Ratio
from farmerinsurancedata
where TotalPopulation > 0
group by  srcStateName,srcYear
order by Ratio desc
limit 3;


-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 5.
-- String Functions [6 Marks]

-- 	Q13. 	Create StateShortName by retrieving the first 3 characters of the srcStateName for each unique state.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select distinct srcStateName,
left(srcStateName,3) as StateShortName
FROM farmerinsurancedata;


-- ###

-- 	Q14. 	Retrieve the srcDistrictName where the district name starts with 'B'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

select  distinct srcDistrictName 
from farmerinsurancedata
WHERE srcDistrictName like 'B%';

-- ###

-- 	Q15. 	Retrieve the srcStateName and srcDistrictName where the district name contains the word 'pur' at the end.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcStateName , srcDistrictName
from farmerinsurancedata
where srcDistrictName like '%pur';
-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 6.
-- Joins [14 Marks]

-- 	Q16. 	Perform an INNER JOIN between the srcStateName and srcDistrictName columns to retrieve the aggregated FarmersPremiumAmount for districts where the district’s Insurance units for an individual year are greater than 10.
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

select a.srcStateName , a.srcDistrictName,
sum(a.FarmersPremiumAmount) as TotalFarmersPremium
from farmerinsurancedata   a
inner join farmerinsurancedata b
on a.srcStateName =  b.srcStateName
and a.srcDistrictName =  b.srcDistrictName 
and a.srcYear = b.srcYear
where b.`Insurance units` > 10 
group by a.srcStateName , a.srcDistrictName
order by TotalFarmersPremium  desc;



-- ###

-- 	Q17.	Write a query that retrieves srcStateName, srcDistrictName, Year, TotalPopulation for each district and the the highest recorded FarmersPremiumAmount for that district over all available years
-- 		Return only those districts where the highest FarmersPremiumAmount exceeds 20 crores.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcStateName, srcDistrictName, srcYear, TotalPopulation,
max(FarmersPremiumAmount) as MaxPremium
from farmerinsurancedata
group by srcStateName, srcDistrictName, srcYear, TotalPopulation
having MaxPremium >'20,000000';


-- ###

-- 	Q18.	Perform a LEFT JOIN to combine the total population statistics with the farmers’ data (TotalFarmersCovered, SumInsured) for each district and state. 
-- 		Return the total premium amount (FarmersPremiumAmount) and the average population count for each district aggregated over the years, where the total FarmersPremiumAmount is greater than 100 crores.
-- 		Sort the results by total farmers' premium amount, highest first.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select p.srcStateName, p.srcDistrictName,
sum(f.FarmersPremiumAmount) AS TotalPremiumAmount,
avg(p.TotalPopulation) AS AvgPopulation
from farmerinsurancedata p
left join farmerinsurancedata f
on p.srcStateName =  f.srcStateName
and p.srcDistrictName =  f.srcDistrictName 
and p.srcYear = f.srcYear
group by p.srcStateName , p.srcDistrictName
having TotalPremiumAmount > '100,0000000'  
order by TotalPremiumAmount desc;



-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 7.
-- Subqueries [10 Marks]

-- 	Q19.	Write a query to find the districts (srcDistrictName) where the TotalFarmersCovered is greater than the average TotalFarmersCovered across all records.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcStateName,srcDistrictName,TotalFarmersCovered
from farmerinsurancedata
where TotalFarmersCovered > (select avg(TotalFarmersCovered) 
from farmerinsurancedata)
order by TotalFarmersCovered desc;
-- ###

-- 	Q20.	Write a query to find the srcStateName where the SumInsured is higher than the SumInsured of the district with the highest FarmersPremiumAmount.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select  distinct srcStateName
from farmerinsurancedata
group by srcStateName
having sum( SumInsured )>
 ( 
select SumInsured from farmerinsurancedata
order by farmersPremiumAmount desc 
limit 1
) ;
-- ###

-- 	Q21.	Write a query to find the srcDistrictName where the FarmersPremiumAmount is higher than the average FarmersPremiumAmount of the state that has the highest TotalPopulation.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select   srcDistrictName,srcStateName,FarmersPremiumAmount
from farmerinsurancedata
where srcStateName=(select srcStateName from farmerinsurancedata
group by srcStateName
order by sum(TotalPopulation) desc
limit 1)
and
FarmersPremiumAmount > 
(select avg(FarmersPremiumAmount) from farmerinsurancedata
where srcStateName =(select srcStateName from farmerinsurancedata 
group by  srcStateName
order by sum(TotalPopulation) desc
limit 1)
)
order by FarmersPremiumAmount desc;

-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 8.
-- Advanced SQL Functions (Window Functions) [10 Marks]

-- 	Q22.	Use the ROW_NUMBER() function to assign a row number to each record in the dataset ordered by total farmers covered in descending order.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select  srcStateName ,srcDistrictName,TotalFarmersCovered,
row_number() over (order by TotalFarmersCovered desc) as Rownumber
from farmerinsurancedata;
-- ###

-- 	Q23.	Use the RANK() function to rank the districts (srcDistrictName) based on the SumInsured (descending) and partition by alphabetical srcStateName.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcStateName,srcDistrictName,SumInsured,
rank() over (partition by srcStateName order by  SumInsured desc) as RankinState
from farmerinsurancedata;

-- ###

-- 	Q24.	Use the SUM() window function to calculate a cumulative sum of FarmersPremiumAmount for each district (srcDistrictName), ordered ascending by the srcYear, partitioned by srcStateName.
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcStateName ,srcDistrictName,srcYear,FarmersPremiumAmount,
sum(FarmersPremiumAmount) over (partition by srcStateName,srcDistrictName order by srcYear asc) as CumulativeSumPREMIUM
from farmerinsurancedata
order by srcStateName ,srcDistrictName,srcYear;
-- ###
-- -------------------------------------------------------------------------------------------------

-- SECTION 9.
-- Data Integrity (Constraints, Foreign Keys) [4 Marks]

-- 	Q25.	Create a table 'districts' with DistrictCode as the primary key and columns for DistrictName and StateCode. 
-- 		Create another table 'states' with StateCode as primary key and column for StateName.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
create table STATES ( StateCode int primary key,StateName varchar(100));
create table DISTRICTS (DistrictCode int primary key, DistrictName varchar(100),StateCode int);

-- ###

-- 	Q26.	Add a foreign key constraint to the districts table that references the StateCode column from a states table.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
alter table Districts
add constraint fk_states_new 
foreign key (StateCode) 
references States(StateCode);

-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 10.
-- UPDATE and DELETE [6 Marks]

-- 	Q27.	Update the FarmersPremiumAmount to 500.0 for the record where rowID is 1.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
set sql_safe_updates=0;
update farmerinsurancedata set FarmersPremiumAmount = 500.0
where rowID =1;
set sql_safe_updates=0;


-- ###

-- 	Q28.	Update the Year to '2021' for all records where srcStateName is 'HIMACHAL PRADESH'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
set sql_safe_updates=0;
update farmerinsurancedata set srcYear = 2021
where srcStateName = 'HIMACHAL PRADESH';
set sql_safe_updates=0;

-- ###

-- 	Q29.	Delete all records where the TotalFarmersCovered is less than 10000 and Year is 2020.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
delete from farmerinsurancedata 
where TotalFarmersCovered < 10000 and srcYear = 2020;


-- ###