# YouTube Crypto Content Analysis

# Overview 


# Research question 
Across the top 10 crypto YouTube channels, does video length or title style predict engagement — and where does common "content strategy intuition" break down?

We will be looking at 2 angles: 
1. Length vs. Engagement: does video length correlate with views/engagement rate (likes+comments per view)? Videos will be bucketed into short (<10 min), medium (10-20 min.), long (20+ min) and compared. 
2. TIte style vs. engagement: do price-prediction titles ("BTC to $100K"), news-reaction titles, or educational titles perform differently? 

# Data Collection (Day 1)
Source: YouTube Data API v3 (free, generous quota — no manual export needed)
Scope: 10 crypto channels, last 50 videos each (~500 rows total) — fixed count instead of a time window, so channels with different posting frequencies still give you comparable sample sizes.
Fields to pull per video: channel_name, video_id, title, publish_date, duration_seconds, view_count, like_count, comment_count

# Channels this investigation focuses on 

Channels were selected based on the following criteria:
- Ranked among the top 15 English-language YouTube channels by subscriber count
  (as of September 1, 2026) with crypto as their primary content focus (may also cover
  general finance/fintech topics)
- Published at least 2 videos per week on crypto markets/coins, based on their
  most recent 50 uploads
- From this pool, the top 10 by subscriber count were selected for analysis

These channels are: [Coin Bureau](https://www.youtube.com/@CoinBureau), [Altcoin Daily](https://www.youtube.com/@AltcoinDaily), [Discover Crypto](https://www.youtube.com/@DiscoverCrypto_), [Crypto Banter](https://www.youtube.com/@CryptoBanterGroup), [Benjamin Cowen](https://www.youtube.com/@benjaminjcowen), [VirtualBacon](https://www.youtube.com/@VirtualBacon), [CryptosRUs](https://www.youtube.com/@CryptosRUs), [MoneyZG](https://www.youtube.com/@MoneyZG), [The Moon Show](https://www.youtube.com/@TheMoon), [Anthony Pompliano](https://www.youtube.com/@AnthonyPompliano)
