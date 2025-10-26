# Spotify-SQL-Analysis-Project
This repository contains a comprehensive set of SQL queries and exercises for analyzing Spotify music data. It includes easy, medium, and advanced level SQL operations, demonstrating data exploration, aggregation, window functions, and query optimization techniques.
📂 Project Structure

Table Creation
The spotify table is created with detailed columns including artist, track, album, audio features, and streaming statistics.

Data Cleaning

Checked for invalid durations (duration_min = 0) and removed them.

Ensured numeric columns (views, likes, stream) are properly formatted.

Query Exercises

Easy Level

Retrieve tracks with more than 1 billion streams.

List all albums along with their artists.

Sum of comments for tracks where licensed = TRUE.

Find tracks with album_type = 'single'.

Count total tracks by each artist.

Medium Level

Average danceability of tracks per album.

Top 5 tracks with the highest energy.

List views and likes for official videos.

Total views per album.

Tracks streamed more on Spotify than YouTube.

Advanced Level

Top 3 most-viewed tracks per artist using window functions.

Tracks where liveness is above average.

Energy range per album (MAX - MIN) using WITH clause.

Tracks with energy-to-liveness ratio > 1.2.

Cumulative sum of likes ordered by views.

Example of query optimization using EXPLAIN and CTEs.

⚡ Key Features

Demonstrates data aggregation (SUM, AVG, COUNT, MAX, MIN).

Shows window functions like DENSE_RANK and cumulative sums.

Implements conditional aggregation using CASE statements.

Includes query optimization with WITH clauses (CTEs) and EXPLAIN.
Notes

Ensure the spotify table is loaded with valid numeric data for views, likes, and streams.

Remove or clean any rows with duration_min = 0 to maintain data integrity.

Queries are tested on PostgreSQL.
