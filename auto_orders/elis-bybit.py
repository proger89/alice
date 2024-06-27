import sys
import time
import datetime
from pybit.unified_trading import HTTP
import mysql.connector
import pandas as pd
import library
from ccxt.bybit import bybit  # Changed to sync version of ccxt
import library_orders
import db
from bs4 import BeautifulSoup
from nltk.sentiment.vader import SentimentIntensityAnalyzer
import requests
import nltk
import traceback

# cryptocurrency_leverage = {"BTC":, "CVX", "ETH", "BNB", "XMR", "IMX", "ETC", "TRB", "LIT", "SCRT", "BSW", "LUNA2",
#                             "TLM", "MDT", "HNT", "AMB", "1000FLOKI", "REEF", "JASMY", "SHIB1000", "AKRO", "APE",
#                             "10000LADYS", "ASTR", "GMX", "CORE", "ILV", "BICO", "GLMR", "CTK", "RSS3", "BAT", "FITFI",
#                             "HFT", "LEVER", "WLD", "ORDI", "ARKM", "SUN", "COTI", "PENDLE", "YGG", "ALPHA", "CKB",
#                             "PAXG", "TRU", "ARPA", "TWT", "FLOW", "LRC", "CHR", "SUSHI", "KSM", "TOMO", "FET", "RPL",
#                             "ICX", "SKL", "MINA", "BOBA", "KAVA", "XEM", "QNT", "NEO", "KLAY", "HOOK", "IDEX",
#                             "DODO", "UNFI", "SWEAT", "ADA", "GAL", "MAV", "HIGH",
#                             "CRO", 'BSV', "COMP", "UNI", "FLR", "FXS", "WOO", "AGLD", "DYDX", "BAKE",
#                             "DAR", "XRP", "SOL", "DOT",
#                             "STMX", "XVG", "FIL", "BCH", "IOTA", "1000LUNC",
#                             "RNDR", "AXS", "CRV", "GALA", "SNX", "CFX", "MANA",
#                             "1000PEPE", "GRT", "EGLD", "MKR", "APE", "STX", "LDO", "INJ", "ARB", "NKN", "GPT",
#                             "FTM", "LINK", "DASH", "AVAX", "CHZ", "ICP", "ATOM", "ALGO", "MAGIC", "MATIC",
#                             "MASK", "ZIL",
#                             "LTC", "EOS", "VET", "TRX", "1INCH", "KNC", "JOE", "CTSI", "XLM", "LQTY", "LINA", "APT",
#                             "ID", "BEL", "OP", "RLC",
#                             "YFI", "ENS", "SXP", "ENJ", "SUI", "OMG", "IOTX", "IOST",
#                             "STG", "ONE", "ONT", "C98", "AGIX", "BLZ",
#                             "T", "RDNT", "BAL", "RAD", "DGB", "QTUM", "MTL", "UMA",
#                             "SFP", "LPT", "CELR", "REN", "EDU", "ZEC", "HOT", "ZEN", "RUNE", "HBAR",
#                             "AAVE", "WAVES", "SAND", "XTZ", "THETA", "NEAR", "API3", "ACH", "DUSK", "AR", "OCEAN",
#                             "ANT", "SSV", "ROSE", "BAND", "RSR", "ZRX", "RVN", "CELO", "AUDIO"}

def select_coins(exchange):
    cryptocurrency_array = ["BTC", "CVX", "ETH", "BNB", "XMR", "IMX", "XNO", "UNFI", "TRB", "ETC", "LIT", "SCRT", "BSW", "LUNA2",
                            "TLM", "MDT", "HNT", "AMB", "1000FLOKI", "REEF", "JASMY", "SHIB1000", "AKRO", "APE",
                            "10000LADYS", "ASTR", "GMX", "CORE", "ILV", "BICO", "GLMR", "CTK", "RSS3", "BAT", "FITFI",
                            "HFT", "LEVER", "WLD", "ORDI", "ARKM", "SUN", "COTI", "PENDLE", "YGG", "ALPHA", "CKB",
                            "PAXG", "TRU", "ARPA", "TWT", "FLOW", "LRC", "CHR", "SUSHI", "KSM", "TOMO", "FET", "RPL",
                            "ICX", "SKL", "MINA", "BOBA", "KAVA", "XEM", "QNT", "NEO", "KLAY", "HOOK", "IDEX",
                            "DODO", "SWEAT", "ADA", "GAL", "MAV", "HIGH",
                            "CRO", 'BSV', "COMP", "UNI", "FLR", "FXS", "WOO", "AGLD", "DYDX", "BAKE",
                            "DAR", "XRP", "SOL", "DOT",
                            "STMX", "XVG", "FIL", "BCH", "IOTA", "1000LUNC",
                            "RNDR", "AXS", "CRV", "GALA", "SNX", "CFX", "MANA",
                            "1000PEPE", "GRT", "EGLD", "MKR", "APE", "STX", "LDO", "INJ", "ARB", "NKN", "GPT",
                            "FTM", "LINK", "DASH", "AVAX", "CHZ", "ICP", "ATOM", "ALGO", "MAGIC", "MATIC",
                            "MASK", "ZIL",
                            "LTC", "EOS", "VET", "TRX", "1INCH", "KNC", "JOE", "CTSI", "XLM", "LQTY", "LINA", "APT",
                            "ID", "BEL", "OP", "RLC",
                            "YFI", "ENS", "SXP", "ENJ", "SUI", "OMG", "IOTX", "IOST",
                            "STG", "ONE", "ONT", "C98", "AGIX", "BLZ",
                            "T", "RDNT", "BAL", "RAD", "DGB", "QTUM", "MTL", "UMA",
                            "SFP", "LPT", "CELR", "REN", "EDU", "ZEC", "HOT", "ZEN", "RUNE", "HBAR",
                            "AAVE", "WAVES", "SAND", "XTZ", "THETA", "NEAR", "API3", "ACH", "DUSK", "AR", "OCEAN",
                            "ANT", "SSV", "ROSE", "BAND", "RSR", "ZRX", "RVN", "CELO", "AUDIO"]

    bvol_coins = []
    for coin in cryptocurrency_array:
        pair = coin + "USDT"
        ohlcv = exchange.fetch_ohlcv(pair, '1h')
        df = pd.DataFrame(ohlcv, columns=['timestamp', 'open', 'high', 'low', 'close', 'volume'])
        if library.detect_strong_adx(df) and library.bvol24(df):
            print('COIN:', coin)
            bvol_coins.append(coin)
    return bvol_coins


# nltk.download('vader_lexicon')
def predict_price(exchange, bvol_coins):
    if len(bvol_coins):
        # print(bvol_coins)
        # sys.exit(0)
        predict_price = 0
        trend = 0
        result_coin = ""
        real_time_price = 0
        limit_price = 0
        for coin in bvol_coins:
            # try:
            pair = coin + "USDT"
            ohlcv_1h = exchange.fetch_ohlcv(pair, '1h', limit=1000)
            df_1h = pd.DataFrame(ohlcv_1h, columns=['timestamp', 'open', 'high', 'low', 'close', 'volume'])

            ohlcv_4h = exchange.fetch_ohlcv(pair, '4h', limit=1000)
            df_4h = pd.DataFrame(ohlcv_4h, columns=['timestamp', 'open', 'high', 'low', 'close', 'volume'])
            ticker = exchange.fetch_ticker(pair)
            real_time_price = float(ticker['close'])
            result = library.get_result(df_1h, real_time_price)
            trend = result['result']
            predict_price = result['predict_price']
            limit_price = result['limit_price']
            print(coin, ": ", trend)
            if trend in [1, 2]:
                result_coin = pair
                break
        # except Exception as e:
        #     continue
        decimal_point = library_orders.get_decimal(str(real_time_price))
        return {"price": library_orders.rounding(predict_price, decimal_point), "trend": trend, 'coin': result_coin,
                "real_time_price": real_time_price, "limit_price": library_orders.rounding(limit_price, decimal_point)}
    return None


def sentiment_analisys():
    sia = SentimentIntensityAnalyzer()

    # Fetch the RSS feed
    rss_url = "https://news.google.com/rss/search?q=Aptos"
    response = requests.get(rss_url)
    soup = BeautifulSoup(response.content, features="xml")

    # Find all article titles in the RSS feed
    titles = [item.title.text for item in soup.findAll('item')]

    # Concatenate all titles together
    all_titles_text = ' '.join(titles)

    # Compute the sentiment score for the combined text
    overall_sentiment_score = sia.polarity_scores(all_titles_text)

    # Decide whether the overall sentiment is positive, negative, or neutral
    if overall_sentiment_score['compound'] >= 0.05:
        overall_sentiment = 'Positive'
    elif overall_sentiment_score['compound'] <= -0.05:
        overall_sentiment = 'Negative'
    else:
        overall_sentiment = 'Neutral'

    return overall_sentiment


def main():
    exchange = bybit({
        'rateLimit': 1200,
        'enableRateLimit': True,
        'options': {
            'defaultType': 'future',  # set default order type to futures
        },
    })

    #bvol_coins = select_coins(exchange)
    bvol_coins = ['UNFI']
    result = predict_price(exchange,bvol_coins)
    print("RESULT", result)
    # #
    sys.exit(0)
    # Establish MySQL connection
    while True:
        try:
                mydb = mysql.connector.connect(
                    host=db.db_host,
                    user=db.db_user,
                    password=db.db_password,
                    database=db.db_database
                )

                cursor = mydb.cursor()
                bvol_coins = select_coins(exchange)
                if bvol_coins is not None:
                #bvol_coins = ['AKRO']
                    try:
                        result = predict_price(exchange, bvol_coins)
                        if result is not None:
                            print("RESULT", result)
                            take_profit = result['price']
                            trend = result['trend']
                            coin = result['coin']
                            real_time_price = result['real_time_price']

                            direction = ""
                            if trend == 2:
                                direction = "Buy"

                            if trend == 1:
                                direction = "Sell"

                            if direction:
                                cursor.execute(
                                    "SELECT api_key, api_secret, id FROM users WHERE status = 1 AND trade_source = 'bybit'")
                                users = cursor.fetchall()
                                for user in users:
                                    api_key = user[0]
                                    api_secret = user[1]
                                    user_id = user[2]
                                    print(api_key, " : ", api_secret)

                                    cursor.execute("SELECT count(id) as count FROM orders_coins where status = 0 and user_id = %s",
                                                   [user_id])
                                    count_order = cursor.fetchone()
                                    if count_order[0] == 0:
                                        session = HTTP(testnet=False, api_key=api_key,
                                                       api_secret=api_secret)
                                        try:
                                            result_order = library_orders.place_order(coin, direction, 10, take_profit, session,real_time_price)
                                            if result_order:
                                                query = ("INSERT INTO orders_coins "
                                                         "(coin, price, type_order,user_id) "
                                                         "VALUES (%s, %s, %s, %s)")
                                                data = (coin, real_time_price, trend, user_id)
                                                print(data)
                                                cursor.execute(query, data)
                                                mydb.commit()
                                        except Exception as e:
                                            time_str = datetime.datetime.now().strftime('%Y-%m-%d %H:%M')
                                            with open("logs.txt", "a") as f:
                                                f.write("Time:" + str(time_str) +" User ID: " + str(user_id) + ":" + str(e) + "\n")
                        # close_position(session, "LTCUSDT", "Sell")
                    except Exception as e:
                        traceback_str = traceback.format_exc()
                        print(traceback_str)
                        with open("logs.txt", "a") as f:
                            f.write(traceback_str + "\n")
                        time.sleep(20)
                        continue
        except Exception as e:
            traceback_str = traceback.format_exc()
            print(traceback_str)
            with open("logs.txt", "a") as f:
                f.write(traceback_str + "\n")
            time.sleep(20)
            continue

if __name__ == "__main__":
    main()
