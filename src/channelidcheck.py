import os 
import re 
import pandas as pd
from dotenv import load_dotenv
from googleapiclient.discovery import build

load_dotenv()
API_KEY = os.environ.get('YOUTUBE_API_KEY')

if not API_KEY:
    raise RuntimeError(
        'YOUTUBE_API_KEY is not set. Add it to the project-root .env file or export it before running this script.'
    )

youtube = build('youtube', 'v3', developerKey=API_KEY)

CHANNEL_IDS = [
    'UCML9PlpcOxM_H53IM0fa4XA',
    'UCc4Rz_T9Sb1w5rqqo9pL1Og',
    'UCIEvlRpHBVFthrF6pZzBEXw',
    'UCI7M65p3A-D3P4v5qW8POxQ',
    'UCcrEA_xd9Ldf1C8DIJYdyyA',
    'UCRvqjQPSeaWn-uEx-w0XOIg',
    'UCN9Nj4tjXbVTLYWN0EKly_Q',
    'UCjemQfjaXAzA-95RKoy9n_g',
    'UCbLhGKVY-bJPcawebgtNfbw',
    'UCqK_GSMbpiV8spgD3ZGloSw'
] 

for cid in CHANNEL_IDS:
    resp = youtube.channels().list(part='snippet', id=cid).execute()
    if resp['items']:
        print(cid, '->', resp['items'][0]['snippet']['title'])
    else:
        print(cid, '-> NOT FOUND, BAD ID')