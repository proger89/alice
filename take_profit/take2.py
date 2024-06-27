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


def calculate_take_profit(df):
    # Рассчитываем RSI
    df['RSI'] = talib.RSI(df['close'], timeperiod=14)

    # Рассчитываем стохастический осциллятор
    df['slowk'], df['slowd'] = talib.STOCH(df['high'], df['low'], df['close'])

    # Установить уровни тейк-профита на основе выбранной стратегии
    # Здесь, в качестве примера, мы устанавливаем тейк-профит при уровне RSI ниже 30 (перепродано)
    # и стохастический осциллятор K line пересекла D line снизу вверх
    df['take_profit'] = (df['RSI'] < 30) & (df['slowk'] > df['slowd'])

    return df


price_data = fetch_data(symbol)
take_profit_data = calculate_take_profit(price_data)

take_profit_prices = take_profit_data.loc[take_profit_data['take_profit'], 'close']

if not take_profit_prices.empty:
    last_take_profit_price = take_profit_prices.iloc[-1]
    print(f'Последняя цена тейк-профита для {symbol} составила {last_take_profit_price}')
else:
    print('Нет сигналов тейк-профита в выбранных данных.')