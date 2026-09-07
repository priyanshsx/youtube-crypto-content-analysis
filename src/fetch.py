import os 
import re 
import pandas as pd
from dotenv import load_dotenv
from googleapiclient.discovery import build

# extracts the API key from the .env file 

load_dotenv()
API_KEY = os.environ.get('YOUTUBE_API_KEY')

youtube = build('youtube', 'v3', developerKey=API_KEY)

# channel IDs
# anthony pompliano: UCML9PlpcOxM_H53IM0fa4XA; the moon show: UCkIcpHGyZtp9Cdyoh5pL3Jg; moneyzg: UCIEvlRpHBVFthrF6pZzBEXw;
# cryptosrus: UCIEvlRpHBVFthrF6pZzBEXw; virtualbacon:UCIEvlRpHBVFthrF6pZzBEXw; benjamin cowen: UCRvqjQPSeaWn-uEx-w0XOIg;
# cryptobanter: UCybasP-2D2b5kTLAb_kvhWQ; discover crypto: UCB8sMtMOYVY_m6jYZcnQdUA; altcoin daily: UC7KjtEJT6HvI3kBcF2I4vXg;
# coinbureau: UCqK_GSMbpiV8spgD3ZGloSw;

# adding the channel IDs

CHANNEL_IDs = [
    'UCqK_GSMbpiV8spgD3ZGloSw',
    'UC7KjtEJT6HvI3kBcF2I4vXg',
    'UCB8sMtMOYVY_m6jYZcnQdUA',
    'UCybasP-2D2b5kTLAb_kvhWQ',
    'UCRvqjQPSeaWn-uEx-w0XOIg',
    'UCIEvlRpHBVFthrF6pZzBEXw',
    'UCIEvlRpHBVFthrF6pZzBEXw',
    'UCIEvlRpHBVFthrF6pZzBEXw',
    'UCkIcpHGyZtp9Cdyoh5pL3Jg',
    'UCML9PlpcOxM_H53IM0fa4XA'
] 

VIDEOS_PER_CHANNEL = 50

# building the get videos function 

