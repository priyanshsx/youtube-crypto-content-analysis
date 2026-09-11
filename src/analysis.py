import numpy as np 
import pandas as pd 
import matplotlib.pyplot as plt 
import duckdb 

con = duckdb.connect('home/priyansh/Documents/d/youtube crypto content analysis/db/main.duckb')

df = con.sql("""
    SELECT 
        channel_name, title, duration_seconds, view_count, comment_count, engagement_rate, video_length_category, title_category
        FROM question_two
""").df()

