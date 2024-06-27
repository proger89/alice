import ccxt
import pandas as pd
import numpy as np
import talib

exchange = ccxt.bybit({
        'rateLimit': 1200,
        'enableRateLimit': True,
        'options': {
            'defaultType': 'future',  # set default order type to futures
        },
    })
symbol = 'API3USDT' # выберите нужный символ

# Получите исторические данные
bars = exchange.fetch_ohlcv(symbol, timeframe='30m', limit=500)
df = pd.DataFrame(bars, columns=['timestamp', 'open', 'high', 'low', 'close', 'volume'])

# Рассчитайте ATR и MA
df['ATR'] = talib.ATR(df['high'].values, df['low'].values, df['close'].values, timeperiod=14)
df['MA'] = df['close'].rolling(window=14).mean()

# Создайте новый столбец для ATR_MA
df['ATR_MA'] = df['ATR'].rolling(window=14).mean()

# Конвертировать столбцы timestamp обратно в формат даты для удобства чтения
df['timestamp'] = pd.to_datetime(df['timestamp'], unit='ms')

# Определите цену входа
entry_price = df['close'].iloc[-1]

# Рассчитайте тейк-профит посредством ATR_MA
take_profit_price = entry_price + df['ATR_MA'].iloc[-1]

print(f"Entry Price: {entry_price}")
print(f"Take Profit Price: {take_profit_price}")
