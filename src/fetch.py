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

def get_video_ids(channel_id, max_results=50):
    video_ids = []
    next_page_token = None # since youtube paginates results 

    while len(video_ids) < max_results: 
        request = youtube.search().list(
            part='id',
            channelId=channel_id,
            order='date',
            type='video',
            maxResults=min(50, max_results - len(video_ids)),
            pageToken=next_page_token
        )
        response = request.execute()
        for item in response('items'):
            video_ids.append(item['id']['videoId'])
        next_page_token = response.get('nextPageToken')
        if not next_page_token: 
            break
    return video_ids

# parser function to help convert the youtube-reported time of  ISO 8601 to seconds
# self-disclosure: took claude's help to write this bit as it wasn't something i had studied previously 
 
def parse_duration(iso_duration):

    # ensuring that only those digits are captured which are present as all videos may not be hour-long

    match = re.match(r'PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?', iso_duration)

    # extracting just the numbers from each group 

    hours = int(match.group(1)) if match.group(1) else 0 
    minutes = int(match.group(2)) if match.group(2) else 0
    seconds = int(match.group(3)) if match.group(3) else 0

    # computing everything into seconds 
    return hours * 3600 + minutes * 60 + seconds