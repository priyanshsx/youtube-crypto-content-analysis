CREATE TABLE youtube_videos AS SELECT * FROM read_csv_auto('/home/priyansh/Documents/d/youtube crypto content analysis/youtube_videos.csv')

-- sanity check 
SELECT * FROM youtube_videos

-- ensuring all videos got downloaded from youtube
SELECT channel_name, COUNT(*) AS video_count FROM youtube_videos 
GROUP BY channel_name 
ORDER BY total_videos 

-- classifying videos into the following categories for further analysis: 
-- short (<10 min; 600s), medium (10-20 min; 1200s), long (20+ min) 

CREATE TABLE videos_categories AS 
SELECT channel_name, video_id, title, duration_seconds, view_count, like_count, comment_count,
    (1.0 * (like_count + comment_count)) / view_count AS engagement_rate,
CASE 
    WHEN duration_seconds < 600 THEN 'short'
    WHEN duration_seconds < 1200 THEN 'medium'
    ELSE 'long'
END AS video_length_category
FROM youtube_videos 

-- checking for videos with 0 views 

SELECT COUNT(*) FROM videos_categories WHERE view_count = 0

-- checking for NULLs in general  

SELECT COUNT(*) FROM videos_categories 
WHERE view_count = 0 OR comment_count = 0 OR like_count = 0

-- checking for the exact null entries

SELECT channel_name, title, view_count, like_count, comment_count, video_length_category 
FROM videos_categories 
WHERE 
    view_count = 0 OR 
    comment_count = 0 OR 
    like_count = 0 

-- creating a new table that filters out the 27 null rows from the current videos_categories table 

CREATE TABLE analyzed_videos_categories AS 
SELECT channel_name, video_id, title, duration_seconds, view_count, like_count, comment_count, engagement_rate, video_length_category
FROM videos_categories
WHERE 
    view_count > 0 AND
    comment_count > 0 AND 
    like_count > 0  

-- sanity check 

SELECT * FROM analyzed_videos_categories 

-- we get 473 rows 