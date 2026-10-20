--DATA_ANALYSIS--

--1)ARE THERE MORE MOVIES OR TV SHOWS ON NETFLIX?
select "type",count(*) as total
from netflix_clean
group by "type";
--INSIGHT:Most netflix content is movies:6131(~70%) vs 2676 tv shows:(~30%).


--2)WHAT IS THE MOST COMMON RATING ON NETFLIX?
select rating,count(*) as total_rating
from netflix_clean
group by rating
order by total_rating desc;

--INSIGHT: TV-MA is the most common rating(3207,~36%).Together with TV-14 (2160,~25%),they make up ~61% of all content so most
--Netflix content targets adult and teen audiences.


--3)WHICH RELEASE YEARS HAVE THE MOST CONTENT?(TOP 10)
select release_year,count(*) as total_content
from netflix_clean
group by release_year
order by total_content desc
limit 10;
--check lates date_added to see  if 2021 is complete.
select max(date_added) from netflix_clean;

--INSIGHT:Most content was released in 2017-2019, and these three years are very close.(2018:1147,2017:1032,2019:1030)
--There is a drop in 2020 and 2021.This may be partly due to Covid-19 and  2021 is also incomplate because the data set ends in 2021.

--4) IN WHICH YEAR WAS THE MOST CONTENT ADDED TO NETFLIX?
select extract(year from date_added)as year_added ,count(*) as total_content
from netflix_clean
where extract(year from date_added) is not null
group by extract(year from date_added)
order by total_content desc;

-- INSIGHT: The most content was added in 2019 (2016). Very little content was added 
-- before 2016, followed by fast growth between 2016 and 2019.
-- Unlike release years (Q3), content added in 2020 stayed high (1879): new production
-- may have slowed during COVID-19, but Netflix kept adding content to its catalogue.
-- 2021 looks lower only because the data covers about 9 months.


--5)WHO ARE THE TOP 10 DIRECTORS WITH THE MOST MOVIES?(EXCLUDING 'UNKNOWN')
select director,count(*)as total_content
from netflix_clean
where director <> 'unknown' and "type"='Movie'
group by director
order by total_content desc
limit 10;

-- INSIGHT: Rajiv Chilaka is the top director with 19 movies. The numbers in the top 10
-- are very close (11-19), and three directors have 12 movies each. Well-known names
-- like Martin Scorsese and Steven Spielberg are also in the list.
-- Note: some cells contain more than one director (e.g. "Raúl Campos, Jan Suter"), so they are counted together.


--6)HOW MANY MOVIES WERE ADDED TO NETFLIX IN 2020 AND LATER?
select "type",count(*) as total_content
from netflix_clean
where "type"='Movie' and extract(year from date_added)>=2020
group by "type";

-- INSIGHT: 2277 movies were added to Netflix from 2020 to September 2021.
-- This is about 37% of all movies (6131), added in less than two years,
-- which shows that Netflix kept growing its movie catalogue during COVID-19.


-- SUMMARY OF FINDINGS
-- 1) Most Netflix content is movies (~70%); TV shows are ~30%.
-- 2) TV-MA and TV-14 make up ~61% of content, so most content targets adult and teen audiences.
-- 3) Most content was released in 2017-2019; fewer titles in 2020-2021 (possible COVID-19 effect, and 2021 data is incomplete).
-- 4) Netflix added the most content in 2019; its catalogue grew fast between 2016 and 2019.
-- 5) Rajiv Chilaka is the top director with 19 movies; the top 10 directors are very close (11-19).
-- 6) About 37% of all movies were added from 2020 to September 2021, so the catalogue kept growing during COVID-19.
