--- Advance SQL Projects
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

SELECT * FROM spotify;
SELECT COUNT(*) FROM spotify;
SELECT AVG(duration_min) FROM spotify;
SELECT max(duration_min) FROM spotify;
SELECT min(duration_min) FROM spotify;
SELECT * FROM spotify WHERE duration_min = 0;
DELETE FROM spotify WHERE duration_min = 0;

----- EASY LEVEL QUESTION------
/* 
1.Retrieve the names of all tracks that have more than 1 billion streams.
2.List all albums along with their respective artists.
3.Get the total number of comments for tracks where licensed = TRUE.
4.Find all tracks that belong to the album type single.
5.Count the total number of tracks by each artist. */

--1.Retrieve the names of all tracks that have more than 1 billion streams.

SELECT * FROM spotify WHERE stream >1000000000;
--2.List all albums along with their respective artists.
SELECT DISTINCT album , artist FROM spotify;
---3.Get the total number of comments for tracks where licensed = TRUE.
SELECT SUM(comments) AS total_comments FROM spotify
where licensed = 'true';
----4.Find all tracks that belong to the album type single.
SELECT * FROM spotify 	where album_type = 'single';
---5.Count the total number of tracks by each artist
SELECT artist ,COUNT(track) as total_number_of_tracks
 FROM spotify GROUP BY artist ORDER BY 1 ;


----- Medium Level questions------
/*
Calculate the average danceability of tracks in each album.
Find the top 5 tracks with the highest energy values.
List all tracks along with their views and likes where official_video = TRUE.
For each album, calculate the total views of all associated tracks.
Retrieve the track names that have been streamed on Spotify more than YouTube.
*/

---1.Calculate the average danceability of tracks in each album.
SELECT album , AVG(danceability) FROM spotify GROUP BY album;
---2Find the top 5 tracks with the highest energy values.
SELECT * FROM spotify ORDER BY energy DESC LIMIT 5;
---3 List all tracks along with their views and likes where official_video = TRUE.
SELECT track , views , likes,official_video  FROM spotify
WHERE official_video = 'true';
---4 For each album, calculate the total views of all associated tracks.
SELECT album ,track , SUM(views) FROM spotify GROUP BY album, track;
----5.Retrieve the track names that have been streamed on Spotify more than YouTube.
WITH new_spotify AS 
( SELECT track ,
SUM(CASE WHEN LOWER(TRIM(most_played_on)) = 'spotify' THEN stream ELSE 0 END) AS total_spotify,
    SUM(CASE WHEN LOWER(TRIM(most_played_on)) = 'youtube' THEN stream ELSE 0 END) AS total_youtube
 FROM spotify
 group by track)
 SELECT * FROM new_spotify WHERE total_spotify>total_youtube 
 Order by total_youtube DESC;

 -----ADVANCE QUESTIONS
 /*
 Find the top 3 most-viewed tracks for each artist using window functions.
Write a query to find tracks where the liveness score is above the average.
Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
*/
 
 --1.Find the top 3 most-viewed tracks for each artist using window functions
WITH cte AS
(
 SELECT track , artist ,
 views ,
 DENSE_RANK()OVER(PARTITION BY artist ORDER BY VIEWS desc) AS ranking
 FROM spotify
)
SELECT * FROM cte WHERE ranking<=3;

---2.Write a query to find tracks where the liveness score is above the average.
SELECT * FROM spotify 
WHERE liveness >(SELECT (AVG(liveness)) FROM spotify)
;
---3.Use a WITH clause to calculate the difference between
--the highest and lowest energy values for tracks in each album.

WITH new_album AS
(
	SELECT  album, 
	MAX(energy) AS highest_energy,
	MIN(energy) AS Lowest_energy
	FROM spotify
	GROUP BY 1 )

SELECT album , 
highest_energy - Lowest_energy AS diff_energy
FROM new_album;

---4.Find tracks where the energy-to-liveness ratio is greater than 1.2
SELECT 
    track,
    ROUND((SUM(energy) / NULLIF(SUM(liveness), 0))::numeric, 2) AS ratio
FROM 
    spotify
GROUP BY 
    track
HAVING 
    (SUM(energy) / NULLIF(SUM(liveness), 0)) > 1.2
ORDER BY 
    ratio DESC;



---Calculate the cumulative sum of likes for tracks ordered by the number of views, 
--using window functions.

SELECT 
    track,
    views,
    likes,
    SUM(likes) OVER (ORDER BY views) AS cumulative_likes
FROM spotify
ORDER BY views DESC;

--
--- 	QUERY OPTIMIZATION
 EXPLAIN
WITH filtered_songs AS (
  SELECT album, track, views
  FROM spotify
  WHERE album = 'album'
)
SELECT *
FROM filtered_songs;
SELECT * FROM spotify;