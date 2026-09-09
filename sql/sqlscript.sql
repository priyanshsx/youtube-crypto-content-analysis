CREATE TABLE youtube_videos AS SELECT * FROM read_csv_auto('/home/priyansh/Documents/d/youtube crypto content analysis/youtube_videos.csv')

-- sanity check 
SELECT * FROM youtube_videos

-- building the analysis columns
CREATE TABLE videos_categories AS SELECT *, 
    (like_count + comment_count) * 1.0 / NULLIF(view_count,0) AS engagement_rate,
CASE 
    WHEN duration_seconds < 600 THEN 'short'
    WHEN duration_seconds < 1200 THEN 'medium'
    ELSE 'long'
END AS length_bucket 
FROM youtube_videos 

