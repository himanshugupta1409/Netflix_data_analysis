SELECT * FROM customer_behaviour.netflix_data;
use customer_behaviour;

-- 1. Count the number of Movies vs TV Shows
select type,count(id)  from netflix_data
group by type;

-- 2. Find the most common rating for movies and TV shows
WITH RatingCounts AS (
    SELECT 
        type,
        rating,
        COUNT(*) AS rating_count
    FROM netflix_data
    GROUP BY type, rating
),
RankedRatings AS (
    SELECT 
        type,
        rating,
        rating_count,
        ROW_NUMBER() OVER (
            PARTITION BY type 
            ORDER BY rating_count DESC
        ) AS rn
    FROM RatingCounts
)
SELECT type, rating, rating_count
FROM RankedRatings
WHERE rn = 1;

-- 3. List all movies released in a specific year (e.g., 2020)
select * From netflix_data
where release_year = 2020 and type = "Movie";

-- 4. Find the top 5 countries with the most content on Netflix
select country,count(*) as country_show_counts from netflix_data
where country is not null
group by country
order by country_show_counts desc
limit 5;


-- 5. Identify the longest movie
SELECT *
FROM netflix_data
WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC
limit 1;

-- 6. Find content added in the last 5 years
SELECT *
FROM netflix_data
WHERE release_year >= YEAR(CURDATE()) - 5;

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select type,director from netflix_data
where director = 'Rajiv Chilaka';

-- 8. List all TV shows with more than 5 seasons
SELECT *
FROM netflix_data
WHERE type = 'TV show' and CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)>5;

-- 9. Find all content without a director
SELECT * FROM netflix
WHERE director IS NULL;

-- 10. List all movies that are documentaries
SELECT *
FROM netflix_data
WHERE listed_in LIKE '%Documentaries%';










 
 



 








