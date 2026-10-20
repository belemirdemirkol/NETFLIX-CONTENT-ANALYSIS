--DATA_CLEANING--

create table netflix_clean as
select * from netflix;
--1) First of all I got a backup called netflix_clean, i will do ant processes on this table because I dont want to change original data.


select show_id,rating,duration
from netflix_clean
where rating like '%min';
--2A)First off all I checked which column is wrong

update netflix_clean
set duration=rating,
rating=null
where show_id in ('s5542','s5795','s5814');
--2B) I moved to data at right column.

select show_id,duration,rating
from netflix_clean
where show_id in('s5542','s5795','s5814');
--2C) I checked for everything is done.


update netflix_clean
set director='unknown'
where director is null or trim(director)='';
update netflix_clean
set "cast"='unknown'
where "cast" is null or trim("cast")='';
update netflix_clean
set country='unknown'
where country is null or trim(country)='';
--3A)Filled null or blank values in director(2634),cast(825) and country(831) with 'unknown'.
select
count(*)filter(where(director is null or trim(director)='')) as null_director,
count(*)filter(where("cast" is null or trim("cast")=''))as null_cast,
count(*)filter(where(country is null or trim(country)='')) as null_country
from netflix_clean;
--3B)Checked no null and blank values left in these columns.


update netflix_clean
set date_added=null
where trim(date_added)='';
--4A) The 10 missing date_added values were blank text no NULL.Converted them to NULL so the column can be changed to date type.
update netflix_clean
set date_added=trim(date_added)
where date_added <> trim(date_added);
--4B)Removed extra spaces from 88 date_added values with TRIM
alter table netflix_clean
alter column date_added type date
using date_added::date;
--4C)Converted date_added from text to date type.
select date_added
from netflix_clean
limit 10;
--4D)Checked date_added  values are now in date format(e.g. 2016-05-26).The 10 missing values remain NULL.

update netflix_clean
set rating='unknown'
where rating is null or trim(rating)='';
--5)Filled 7 missing rating values (3 null+4 blank)with 'unknown.'

