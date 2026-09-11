import numpy as np 
import pandas as pd 
import matplotlib.pyplot as plt 
import duckdb 
from scipy import stats 
import statsmodels.api as sm 

# duckdb for importing tables
con = duckdb.connect('/home/priyansh/Documents/d/youtube crypto content analysis/db/main.duckdb')

# creating the pandas df 
df = con.sql("""
    SELECT * FROM question_two
""").df()

# recall ques 1: does video length correlate with views/engagement rate? 

filtered_df = df.groupby('video_length_category')[['view_count', 'engagement_rate', 'duration_seconds']].median()
print(f"Median values: {filtered_df}")

corr, p_value = stats.pearsonr(df['duration_seconds'], df['engagement_rate'])
print(f"Correlation: {corr:.4f}")
print(f"p-value: {p_value: .4f}")
