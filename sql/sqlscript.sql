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
