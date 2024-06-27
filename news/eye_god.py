import sys
import pandas as pd
import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.linear_model import LinearRegression
import feedparser
import ccxt
from sklearn.metrics import mean_squared_error
from bs4 import BeautifulSoup
import datetime

nltk.download('wordnet')
# получение новостей с помощью RSS-ленты Google News
rss_url = 'https://news.google.com/rss/search?q=Aptos'
feed = feedparser.parse(rss_url)
news_data = pd.DataFrame(columns=['date', 'title', 'description'])
for item in feed.entries:
    news_data = pd.concat([news_data, pd.DataFrame({'date': [item.published], 'title': [item.title], 'description': [item.summary]})], ignore_index=True)

# удаление HTML тегов из description
news_data['description'] = news_data['description'].apply(lambda x: BeautifulSoup(x, 'html.parser').get_text())
news_data['date'] = news_data['date'].apply(lambda x: datetime.datetime.strptime(x, '%a, %d %b %Y %H:%M:%S %Z').strftime('%Y-%m-%d'))
news_data['date'] = pd.to_datetime(news_data['date'], format='%Y-%m-%d')
# получение цен на криптовалюты с помощью ccxt API
exchange = ccxt.binance()
symbol = 'APT/USDT'
ohlcv = exchange.fetch_ohlcv(symbol, '1d')
prices_data = pd.DataFrame(ohlcv, columns=['date', 'open', 'high', 'low', 'close', 'volume'])
prices_data['date'] = pd.to_datetime(prices_data['date'], unit='ms')

merged_data = pd.DataFrame(columns=['date', 'title', 'description'])

for i in range(len(news_data)):
    date = news_data.loc[i, 'date']
    news = news_data[news_data['date'] == date]
    price = prices_data[prices_data['date'] == date]
    if len(price) > 0:
        new_row = pd.DataFrame({'date': [date],
                                'title': [news.iloc[0]['title']],
                                'description': [news.iloc[0]['description']],
                                'open': [price['open'].iloc[-1]],
                                'high': [price['high'].iloc[-1]],
                                'low': [price['low'].iloc[-1]],
                                'close': [price['close'].iloc[-1]],
                                'volume': [price['volume'].iloc[-1]]
                                })
        merged_data = pd.concat([merged_data, new_row], ignore_index=True)

# предварительная обработка текста новостей
stop_words = set(stopwords.words('english'))
lemmatizer = WordNetLemmatizer()
merged_data['text'] = merged_data['title'] + ' ' + merged_data['description']
merged_data['text'] = merged_data['text'].apply(lambda x: ' '.join([lemmatizer.lemmatize(word.lower()) for word in word_tokenize(x) if word.isalpha() and word.lower() not in stop_words]))

vectorizer = TfidfVectorizer(ngram_range=(1, 2))
X = vectorizer.fit_transform(merged_data['text'])
y = merged_data['close']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
clf = LinearRegression()
clf.fit(X_train, y_train)
y_pred = clf.predict(X_test)

# определение важности новостей для криптовалютного рынка

keywords = vectorizer.get_feature_names_out()
weights = clf.coef_
keywords_weights = {}
for i in range(len(keywords)):
    keywords_weights[keywords[i]] = weights[i]
sorted_keywords = sorted(keywords_weights.items(), key=lambda x: x[1], reverse=True)[:10]

# предсказание изменения цены криптовалюты
y_pred = clf.predict(X_test)
mse = mean_squared_error(y_test, y_pred)
print("Predicted price:", y_pred[0])


