CREATE TABLE youtube_videos AS SELECT * FROM read_csv_auto('/home/priyansh/Documents/d/youtube crypto content analysis/youtube_videos.csv')

-- sanity check 
SELECT * FROM youtube_videos
