import ccxt
import talib
import pandas as pd

# Инициализация биржи
exchange = ccxt.bybit({
        'rateLimit': 1200,
        'enableRateLimit': True,
        'options': {
            'defaultType': 'future',  # set default order type to futures
        },
    })

# Получение данных о цене
symbol = 'AKROUSDT'
timeframe = '5m'
ohlcv = exchange.fetch_ohlcv(symbol, timeframe)

# Преобразование в pandas DataFrame
df = pd.DataFrame(ohlcv, columns=['timestamp', 'open', 'high', 'low', 'close', 'volume'])

# Установка индекса времени
df['timestamp'] = pd.to_datetime(df['timestamp'], unit='ms')
df.set_index('timestamp', inplace=True)

# Вычисление ATR и DMI
df['atr'] = talib.ATR(df['high'], df['low'], df['close'])
df['plus_di'] = talib.PLUS_DI(df['high'], df['low'], df['close'])
df['minus_di'] = talib.MINUS_DI(df['high'], df['low'], df['close'])

# Определение боковика
if df['atr'].tail(10).max() < 0.5 and df['atr'].tail(10).min() > 0.1 and abs(df['plus_di'].tail(10) - df['minus_di'].tail(10)).max() < 20:
    print("Текущая ситуация на рынке - боковик")
else:
    print("Текущая ситуация на рынке - тренд")
