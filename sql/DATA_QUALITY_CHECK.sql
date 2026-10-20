
--DATA QUALITY CHECK-- 

select* from netflix
limit 10;

select count(*) as value_count
from netflix;
--1)Netflix data set contains 8807 rows.

select count(distinct show_id) as distinct_value
from netflix;
--2)All show_id values are unique.

select
count(*) filter(where "type" is null or trim("type")='') as null_type,
count(*) filter(where title is null or trim(title)='') as null_title,
count(*) filter(where director is null or trim (director)='') as null_director,
count(*) filter(where "cast" is null or trim("cast")='') as null_cast,
count(*) filter(where country is null or trim(country)='') as null_country,
count(*) filter(where date_added is null or trim(date_added)='' ) as null_date_added,
count(*) filter(where release_year is null) as null_release_year,
count(*) filter(where duration is null or trim(duration)='') as null_duration,
count(*) filter(where rating is null or trim(rating)='') as null_rating,
count(*) filter(where listed_in is null or trim(listed_in)='') as null_listed,
count(*) filter(where description is null or trim(description)='') as null_description
from netflix;
--3)I checked all of data for null or trim value.I found for director=2634 null or trim,
--cast=825,country=831,date_added=10,duration=3,rating=4 also type-title-listed_in-description and release_year not including null or trim value.
--I checked only null control for release_year because this column is integar thats why i cant use trim, null control is enough

select distinct "type" from netflix;
select distinct duration from netflix;
select distinct rating from netflix;
select distinct country from netflix;
--4) I checked distinct values in type,duration rating  and country:
--Type:2 different value type;movie and tv show
--Duration:2 different value type; min and season
--Rating: some values are in the wron column (duration like  74 min).I will move to right section.
--Country:rows some have multiple countries in one cell (e.g. "United States, India"). Needs splitting for country analysis


select show_id,title,rating
from netflix
where rating like '%min';
--5)3 rows have duration values in the rating column = s5542,s5795,s5814

select min(release_year) as min_year,max(release_year) as max_year,round(avg(release_year),2) as avg_year
from netflix;
--6)release year ranges from 1925 to 2021. the average is 2014 so most content is relatively recent

select distinct date_added
from netflix
limit 20;
--7)I found trim for some rows thats why I need to check also I noticed date_added are registered wrong type.Currently type is text,
--I have to convert date type at cleaning step

select count(*)
from netflix
where date_added<> trim(date_added);
--8) I found 88 extra space in date_added I need to fix during cleaning.

select 
count(*) filter(where "type"<> trim("type"))as space_type,
count(*) filter(where title <> trim(title)) as space_title,
count(*) filter(where country <> trim(country)) as space_country,
count(*) filter(where date_added <> trim(date_added)) as space_date,
count(*) filter(where rating <> trim(rating)) as space_rating,
count(*) filter(where duration <> trim(duration)) as space_duration,
count(*) filter(where listed_in <> trim(listed_in)) as space_listed
from netflix;
--9) Cheked extra space  in all text columns,only date_added has 88 extra space.Other columns are clean.


-- SUMMARY (cleaning plan)
-- 1) Create a working copy of the table; the raw table stays unchanged.
-- 2) Fill missing director, cast and country with 'Unknown'. Keep NULL in date_added, rating and duration (very few rows).
-- 3) Move the 3 duration values from rating to duration, set rating to NULL.
-- 4) Trim the 88 extra spaces in date_added and convert it to date type.
-- 5) Split multiple countries for country analysis (will be done in python).

