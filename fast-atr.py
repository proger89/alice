import ccxt
import talib
import pandas as pd

# Создайте объект биржи (замените 'binance' на нужное имя биржи)
exchange = ccxt.bybit({
        'rateLimit': 1200,
        'enableRateLimit': True,
        'options': {
            'defaultType': 'future',  # set default order type to futures
        },
    })

# Укажите символ (пару) и временной интервал свечей
symbol = 'UNFIUSDT'
timeframe = '1h'

# Получите исторические данные о свечах
candles = exchange.fetch_ohlcv(symbol, timeframe)
df = pd.DataFrame(candles, columns=['timestamp', 'open', 'high', 'low', 'close', 'volume'])

# Вычислите RSI и ATR
rsi_period = 14
atr_period = 14

df['RSI'] = talib.RSI(df['close'], timeperiod=rsi_period)
df['ATR'] = talib.ATR(df['high'], df['low'], df['close'], timeperiod=atr_period)

# Проверьте условие: RSI выше Fast ATR
if df['RSI'].iloc[-1] > df['ATR'].iloc[-1]:
    print("RSI выше Fast ATR")
else:
    print("RSI не выше Fast ATR")
