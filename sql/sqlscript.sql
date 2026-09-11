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

-- analyzing for question 2 
-- keywords to search for:
-- coins: BTC/Bitcoin, ETH/Ethereum, altcoin 
-- structural: ALL CAPS 
-- news-reaction: US Fed, Japan, FOMC, breaking, urgent, alert, 
-- price-prediction: price, next move, explodes, crash, collapse, dying, over, recover, recovery 
-- coins: BTC/Bitcoin, ETH/Ethereum, altcoin/altcoins
-- educational: how to, what is, guide, explained 

CREATE TABLE question_two AS 
    SELECT channel_name, title, duration_seconds, view_count, like_count, comment_count, engagement_rate, video_length_category,
    CASE 
        WHEN 
            title ILIKE '%fomc%' OR
            title ILIKE '%us fed%' OR
            title ILIKE '%japan%' OR 
            title ILIKE '%fomc%' OR 
            title ILIKE '%breaking%' OR 
            title ILIKE '%urgent%' OR 
            title ILIKE '%alert%' OR
            title ILIKE '%eu%' OR 
            title ILIKE '%democracy%' OR 
            title ILIKE '%spacex%' OR 
            title ilike '%spy%' OR 
            title ILIKE '%spx%' OR 
            title ILIKE '%s&p500%' OR 
            title ILIKE '%dowj%' OR 
            title ILIKE '%nasdaq%' OR 
            title ILIKE '%banks%' OR 
            title ILIKE '%china%' OR 
            title ILIKE '% ai %' OR 
            title ILIKE '%artificial intelligence%'
        THEN 'news-reaction'
        WHEN 
            title ILIKE '%btc%' OR 
            title ILIKE '%bitcoin%' OR 
            title ILIKE '%eth%' OR 
            title ILIKE '%ethereum%' OR 
            title ILIKE '%altcoin%' OR 
            title ILIKE '%altcoins%' OR 
            title ILIKE '%stablecoins%'
        THEN 'coins'
        WHEN 
            title ILIKE '%crypto%' OR
            title ILIKE '%mining%' OR
            title ILIKE '%bitcoin mining%' OR 
            title ILIKE '%btc mining%' OR 
            title ILIKE '%defi%' OR 
            title ILIKE '% decentralized finance %'
        THEN 'defi-general-crypto'
        WHEN 
            title ILIKE '%regulation%' OR 
            title ILIKE '%regulatory%' OR 
            title ILIKE '%clarity%' OR 
            title ILIKE '%act%' OR 
            title ILIKE '%acts%'
        THEN 'regulation'
        WHEN 
            title ILIKE '%price%' OR 
            title ILIKE '%next move%' OR 
            title ILIKE '%explodes%' OR 
            title ILIKE '%crash%' OR 
            title ILIKE '%collapse%' OR 
            title ILIKE '%dying%' OR 
            title ILIKE '%over%' OR 
            title ILIKE '%recover%' OR 
            title ILIKE '%recovery%' OR 
            title ILIKE '%melt-up%' 
        THEN 'price-prediction'
        WHEN 
            title ILIKE '%how to%' OR 
            title ILIKE '%here''s how%' OR 
            title ILIKE '%what is%' OR 
            title ILIKE '%guide%' OR 
            title ILIKE '%explained%' OR 
            title ILIKE '%you need to see this%'
        THEN 'educational'
        ELSE 'undefined'
    END AS title_category
    FROM analyzed_video_categories

-- this gave us 173 undefined rows
-- but since we'd like to analyze most of them, updating the keyword list to: 
-- eu, democracy, melt-up, spacex, spy, spx, s&p500, dowj, nasdaq, banks, mistakes, crypto, 
-- future, past, million, millions, china, mining, bitcoin mining, btc mining, 
-- 