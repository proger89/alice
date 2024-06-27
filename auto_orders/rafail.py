import sys
import time
from pybit.unified_trading import HTTP
import pymysql.cursors
import db
from ccxt.bybit import bybit  # Changed to sync version of ccxt
import pandas as pd
import library
import library_orders
import traceback
import datetime


def close_position(my_trend, exchange, session, coin):
        side = "Buy" if my_trend == 2 else "Sell"
        library_orders.close_position(session, exchange, coin, side)

def main():
    # Establish MySQL connection
    while True:
        try:
            mydb = pymysql.connect(host=db.db_host,
                                   user=db.db_user,
                                   password=db.db_password,
                                   database=db.db_database,
                                   cursorclass=pymysql.cursors.DictCursor)

            with mydb:
                with mydb.cursor() as cursor:
                    cursor.execute("SELECT api_key, api_secret, id FROM users WHERE status = 1 AND trade_source = 'bybit'")
                    users = cursor.fetchall()

                    for user in users:
                        api_key = user['api_key']
                        api_secret = user['api_secret']
                        print(api_key, " : ", api_secret)

                        exchange = bybit({
                            'rateLimit': 1200,
                            'enableRateLimit': True,
                            'apiKey': api_key,
                            'secret': api_secret,
                            'options': {
                                'defaultType': 'future',  # set default order type to futures
                            },
                        })
                        time.sleep(1)
                        session = HTTP(testnet=False, api_key=api_key, api_secret=api_secret)
                        cursor.execute("SELECT id, coin,type_order as trend, price FROM orders_coins WHERE status = 0 GROUP BY coin")
                        group_orders = cursor.fetchall()

                        for order in group_orders:
                            coin = order['coin']
                            my_trend = order['trend']
                            my_price = float(order['price'])
                            ohlcv_ai = exchange.fetch_ohlcv(coin, '1h',limit=1000)
                            df = pd.DataFrame(ohlcv_ai, columns=['timestamp', 'open', 'high', 'low', 'close', 'volume'])
                            is_not_correct_price = False
                            ticker = exchange.fetch_ticker(coin)
                            real_time_price = float(ticker['close'])
                            predict = library.predict_pivot_price(real_time_price, df)
                            result_trend = predict['trend']
                            result_price = predict['price']
                            # percent = library.percentage_difference(real_time_price,result_price)
                            if my_trend != result_trend:
                                is_not_correct_price = True

                            trend_stoch = library.determine_trend(df)
                            # if trend_stoch != 0:
                            #     if my_trend != trend_stoch:
                            #         is_not_correct_price = True

                            # divergence_result = library.find_divergence(df)
                            # if divergence_result:
                            #     if divergence_result != my_trend:
                            #         is_not_correct_price = True

                            time_str = datetime.datetime.now().strftime('%Y-%m-%d %H:%M')

                            trace = "Time:"+ str(time_str) +" Coin:" + str(coin)  + " My trend:" + str(my_trend) + " result_trend:" + str(result_trend) + " result_price:" + str(result_price)  + " my_price:" + str(my_price)  + " trend_stoch:" + str(trend_stoch)  + "\n"
                            print(trace)
                            if is_not_correct_price:
                                try:
                                    with open("rafail_log.txt", "a") as f:
                                        f.write(trace)
                                    close_position(my_trend,exchange, session, coin)
                                except Exception as e:
                                    with open("rafail_log.txt", "a") as f:
                                        f.write(str(e) + "\n")
                                    continue
        except Exception as e:
            traceback_str = traceback.format_exc()
            print(traceback_str)
            with open("rafail_log.txt", "a") as f:
                f.write(traceback_str + "\n")
            time.sleep(20)


if __name__ == "__main__":
    main()
