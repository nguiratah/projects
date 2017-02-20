
import tweepy
from textblob import TextBlob as tb

consumer_key = 'TvsP5kK135NfkjX7Uetl0BPLt'
consumer_secret = '67MsmfAmiv3MeblCETU76XhQysisBSoSxioct9ivWbTZFKkTyq'

access_token = '829366773430546433-GZf0sY4PcjUklt91Dfg8mWjiN1JULrG'
access_token_secret = 'JEApdfqmP1cpVdsad1PTCrDkp8ghWGRFN3eLsRiVDCs6x'

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)

public_tweets = api.search('Trump', count=100)

for tweet in public_tweets:
	print(tweet.text)
	analysis = tb(tweet.text)
	print(analysis.sentiment)