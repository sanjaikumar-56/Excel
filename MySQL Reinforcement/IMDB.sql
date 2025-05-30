-- 1 count the total number of records in each table of database.

use imdb;
show tables;
select count(*) from director_mapping ;
select count(*) from genre ;
select count(*) from movie ;
select count(*) from names ;
select count(*) from ratings ;
select count(*) from role_mapping ; 

-- 2 identify which columns in the movie table contain null values

select * from movie;
select *
from movie 
where id is null
or title is null
or year is null
or date_published is null
or duration is null
or country is null
or worlwide_gross_income is null
or languages is null 
or production_company is null;

-- 3 Determine the total number of movies released each year,and analyze how the trend changes month_wise

select * from movie;
select
year (date_published) as release_year,
month (date_published) as release_month,
count(*) as total_movies from movie 
where date_published is not null 
group by release_year, release_month
order by release_year, release_month;

-- 4 How many movies were produced in either the USA or INDIA in the year 2019? 

select count(*) as total_movies from movie 
where country in ("USA") AND year = 2019; 

-- 5 List the unique genres in the dataset, and count how many movies belong exclusively to one genre

select * from genre;
select genre, count(movie_id) as moviecount 
from genre 
group by genre
having count(movie_id);  

-- 7  Calculate the average movie duration for each genre

select g.genre, avg(m.duration) as avgduration from movie m 
join genre g on m.id= g.movie_id group by g.genre; 

-- 8 Identify actors or actresses who have appeared in more than three movies with an average rating below 5. 

select n.name, count(rm.movie_id) as moviecount 
from role_mapping rm join names n ON rm.name_id =n.id
join ratings r ON rm.movie_id =r.movie_id 
where rm.category ='actor' AND r.avg_rating < 5 
group by n.name
having count(rm.movie_id) >3; 

-- 9 Find the minimum and maximum values for each column in the ratings table, excluding the movie_id column.

select min(avg_rating) as minrating, max(avg_rating) as maxrating,
min(total_votes) as minvotes, max(total_votes) as maxvotes, min(median_rating) as minmedian, 
max(median_rating) as maxmedian from ratings ;  

-- 10  Which are the top 10 movies based on their average rating?

select m.title, r.avg_rating from movie m
join ratings r ON m.id = r.movie_id
order by r.avg_rating desc limit 10 ;

-- 11 Summarize the ratings table by grouping movies based on their median ratings.

select median_rating, count(movie_id) as totalmovies from ratings
group by median_rating; 

-- 12  How many movies, released in March 2017 in the USA within a specific genre, had more than 1,000 votes? 

select count(*) as moviecount from movie m
join ratings r ON m.id = r.movie_id WHERE year = 2017 AND MONTH (date_published) = 3 
AND country = 'USA' AND r.total_votes > 1000; 

-- 13 Find movies from each genre that begin with the word “The” and have an average rating greater than 8. 

select m.title, g.genre, r.avg_rating 
from movie m join genre g ON m.id = g.movie_id
join ratings r ON m.id = r.movie_id 
where m.title like 'the%' AND r.avg_rating >8; 

-- 14 Of the movies released between April 1, 2018, and April 1, 2019, how many received a median rating of 8? 

select count(*) as moviecount from movie m 
join ratings r ON m.id = r.movie_id 
where date_published between '2018-04-01' and '2019-04-01' 
and r.median_rating =8; 

-- 15 Do German movies receive more votes on average than Italian movies? 

select country, avg(r.total_votes) as avgvotes 
from movie m join ratings r ON m.id = r.movie_id 
where country IN ('germany','italy') group by country; 

-- 16 Identify the columns in the names table that contain null values. 

select 'name' as columnName, count(*) as nullcount from names 
where name is null union all 
select 'height', count(*) from names 
where height is null union all 
select 'date_of_birth', count(*) from names
where date_of_birth is null union all
select 'known_for_movies', count(*) from names
where 'known_for_movies' is null; 

-- 17  Who are the top two actors whose movies have a median rating of 8 or higher?

select n.name, count(rm.movie_id) as moviecount 
from role_mapping rm join names n ON rm.name_id = n.id
join ratings r ON rm.movie_id = r.movie_id 
where r.median_rating >=8 AND rm.category = 'actor' 
group by n.name 
order by moviecount DESC limit 2; 

-- 18  Which are the top three production companies based on the total number of votes their movies received? 

select m.production_company, sum(r.total_votes) as totalvotes from movie m 
join ratings r ON m.id = r.movie_id 
group by m.production_company 
order by totalvotes DESC limit 3; 

-- 19  How many directors have worked on more than three movies?

select dm.name_id, n.name, 
count(dm.movie_id) as moviecount 
from director_mapping dm 
join names n ON dm.name_id = n.id 
group by dm.name_id, n.name 
having count(dm.movie_id) >3; 

-- 20 Calculate the average height of actors and actresses separately.

select rm.category, avg(n.height) as avgheight 
from role_mapping rm 
join names n ON rm.name_id = n.id 
where rm.category IN ('actor', 'actress') 
group by rm.category; 

-- 21. List the 10 oldest movies in the dataset along with their title, country, and director.

SELECT  m.title, m.country, n.name AS Director
FROM movie m
JOIN director_mapping dm ON m.id = dm.movie_id
JOIN names n ON dm.name_id = n.id
ORDER BY m.year ASC limit 10; 

-- 22. List the top 5 movies with the highest total votes, along with their genres.

SELECT  m.title, g.genre, r.total_votes
FROM movie m
JOIN ratings r ON m.id = r.movie_id
JOIN genre g ON m.id = g.movie_id
ORDER BY r.total_votes DESC limit 5; 

-- 23. Identify the movie with the longest duration, along with its genre and production company.

SELECT  m.title, g.genre, m.production_company, m.duration
FROM movie m
JOIN genre g ON m.id = g.movie_id
ORDER BY m.duration DESC limit 3; 

-- 24. Determine the total number of votes for each movie released in 2018.

SELECT m.title, SUM(r.total_votes) AS TotalVotes
FROM movie m
JOIN ratings r ON m.id = r.movie_id
WHERE year = 2018
GROUP BY m.title; 

-- 25. What is the most common language in which movies were produced?

SELECT  languages, COUNT(*) AS MovieCount
FROM movie
GROUP BY languages
ORDER BY MovieCount DESC limit 3;













