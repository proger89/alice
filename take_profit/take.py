import ccxt
import pandas as pd
import talib

exchange = ccxt.bybit({
        'rateLimit': 1200,
        'enableRateLimit': True,
        'options': {
            'defaultType': 'future',  # set default order type to futures
        },
    })
symbol = 'LPTUSDT' # выберите нужный символ

def fetch_data(symbol):
    data = exchange.fetch_ohlcv(symbol, timeframe='1h', limit=500)
    df = pd.DataFrame(data, columns=['timestamp', 'open', 'high', 'low', 'close', 'volume'])
    df['timestamp'] = pd.to_datetime(df['timestamp'], unit='ms')
    return df

def calculate_take_profit(price_df, window_size=20):
    upper_band, middle_band, lower_band = talib.BBANDS(price_df['close'], timeperiod=window_size)
    price_df['upper_band'] = upper_band
    return price_df

price_data = fetch_data(symbol)
take_profit_data = calculate_take_profit(price_data)

# смотрим последний тейк-профит
last_take_profit = take_profit_data['upper_band'].iloc[-1]
print(f'Тейк-профит для {symbol} составляет {last_take_profit}')
