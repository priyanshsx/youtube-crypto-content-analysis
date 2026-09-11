# YouTube Crypto Content Analysis

## Overview 

This project analyzes YouTube performance metrics from top cryptocurrency channels to uncover how video duration and title semantics impact viewership and engagement. The end-to-end pipeline utilizes SQL(DuckDB) for data engineering, Python (Pandas/Scipy) for statistical analysis, and Tableau for interactive data visualization. 

You can check out the public Tableau dashboard [here](https://public.tableau.com/views/YouTubeCryptoContentAnalysisTop50YouTubers/YoutubeCryptoContentAnalysisTop10?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link). 

## Research question 
Across the top 10 crypto YouTube channels, does video length or title style predict engagement — and where does common "content strategy intuition" break down?

We look at 2 angles: 
1. Length vs. Engagement: does video length correlate with views/engagement rate (likes+comments per view)? Videos are bucketed into short (<10 min), medium (10-20 min.), long (20+ min) and compared. 
2. Tite style vs. engagement: do price-prediction titles ("BTC to $100K"), news-reaction titles, or educational titles perform differently? 

## Data Engineering Pipeline

Extracted raw channel data and removed inactive outliers (videos with zero views, likes, or comments), resulting in a clean 473-row master dataset.

Engineered a video_length_category column to intelligently bucket content into short (<10 min), medium (10-20 min), and long (>20 min) formats.

Created a title_category column using layered CASE WHEN and ILIKE SQL statements to classify text into distinct thematic styles (e.g., News-Reaction, DeFi, Educational).


## Channels this investigation focuses on 

Channels were selected based on the following criteria:
- Ranked among the top 15 English-language YouTube channels by subscriber count
  (as of September 1, 2026) with crypto as their primary content focus (may also cover
  general finance/fintech topics)
- Published at least 2 videos per week on crypto markets/coins, based on their
  most recent 50 uploads
- From this pool, the top 10 by subscriber count were selected for analysis

These channels are: [Coin Bureau](https://www.youtube.com/@CoinBureau), [Altcoin Daily](https://www.youtube.com/@AltcoinDaily), [Discover Crypto](https://www.youtube.com/@DiscoverCrypto_), [Crypto Banter](https://www.youtube.com/@CryptoBanterGroup), [Benjamin Cowen](https://www.youtube.com/@benjaminjcowen), [VirtualBacon](https://www.youtube.com/@VirtualBacon), [CryptosRUs](https://www.youtube.com/@CryptosRUs), [MoneyZG](https://www.youtube.com/@MoneyZG), [The Moon Show](https://www.youtube.com/@TheMoon), [Anthony Pompliano](https://www.youtube.com/@AnthonyPompliano)

## Key Analytical Findings 

The Duration "Goldilocks Zone": Video length and engagement share a definitive non-linear relationship (Pearson r = 0.1201, p = 0.0089). Medium-length videos hit the sweet spot, maximizing both median views (20.6k) and median engagement rates (4.6%).

The Reach Winner: Broad "DeFi/General Crypto" titles dominate algorithm reach, pulling in a massive 33.1k median views compared to other categories.

The Engagement Winner: "News-Reaction" titles drive the highest active audience participation, capturing a 4.4% median engagement rate.

The Educational Lag: Traditional "How-to" or "Explained" content severely underperforms in the crypto niche, capturing only 2k median views and a 2.5% engagement rate.

## Strategic Recommendations 

Optimize Duration: Target the 10-to-20-minute window for core uploads. Avoid extending past 20 minutes to prevent audience drop-off and diminishing returns.

Top-of-Funnel Reach: Cast a wide net using broad DeFi and general crypto topics to attract new, unique viewers to the channel.

Community Activation: Pivot to urgent, macro-news reaction videos to convert those passive viewers into highly engaged, commenting community members.

Reevaluate Tutorials: Shift away from standard evergreen educational formats, as the current audience strongly prefers timely market updates and speculation.

## How to reproduce 

1. Clone the repo git clone youtube-crypto-content-analysis cd youtube-crypto-content-analysis

2. Install dependencies pip install duckdb pandas numpy matplotlib scipy statsmodels google-api-python-client

3. Pull raw data (or use the CSV already in youtube crypto content and analysis/raw_data/) python3 src/fetch.py

4. Load into DuckDB and build the regime classification table python3 src/analysis.py

5. Run the statistical analysis and generate the chart python3 src/analysis.py

## Project Folder Structure 

project-folder/
├── raw_data/              # extracted youtube videos using channel id 
├── db/                    # main.duckdb — the working database
├── sql/                   # saved .sql scripts (table creation, regime classification)
├── src/                   # python scripts (data pull, transformation, analysis)
├── figures/               
├── README.md