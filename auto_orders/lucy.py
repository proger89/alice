import pymysql.cursors
import db
import time
import ccxt
import traceback
def main():
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
                    user_id = user['id']
                    print(api_key, " : ", api_secret)
                    exchange = ccxt.bybit({
                        'apiKey': api_key,
                        'secret': api_secret,
                    })
                    # Получаем открытые позиции
                    open_positions = exchange.fetch_derivatives_positions()

                    if len(open_positions) == 0:
                        cursor.execute("SELECT COUNT(*) AS count FROM orders_coins WHERE status = 0 AND user_id = %s",
                                       (user_id,))
                        result = cursor.fetchone()

                        if result['count']:
                            query = ("update orders_coins set status = 1 where user_id = %s")
                            data = (user_id,)
                            print(data)
                            cursor.execute(query, data)
                            mydb.commit()
    except Exception as e:
        traceback_str = traceback.format_exc()
        print(traceback_str)
        with open("lucy_log.txt", "a") as f:
            f.write(traceback_str + "\n")
        time.sleep(20)


if __name__ == "__main__":
    main()
