from textblob import TextBlob
wiki = TextBlob("Tahar is angry that he did not find any suitable job")
print(wiki.tags)
print(wiki.words)
print(wiki.sentiment.polarity)