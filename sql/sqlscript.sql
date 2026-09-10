CREATE TABLE youtube_videos AS SELECT * FROM read_csv_auto('/home/priyansh/Documents/d/youtube crypto content analysis/youtube_videos.csv')

-- sanity check 
SELECT * FROM youtube_videos

-- ensuring all videos got downloaded from youtube
SELECT channel_name, COUNT(*) AS video_count FROM youtube_videos 
GROUP BY channel_name 
ORDER BY total_videos 

