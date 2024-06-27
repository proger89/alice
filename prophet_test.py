import sys

import ccxt
import pandas as pd
import talib
from prophet import Prophet
from ta.volume import ForceIndexIndicator
import ta
import ta.momentum
import numpy as np
import logging
import cmdstanpy
logging.getLogger('cmdstanpy').setLevel(logging.WARNING)


# Инициализация биржи
exchange = ccxt.bybit({
        'rateLimit': 1200,
        'enableRateLimit': True,
        'options': {
            'defaultType': 'future',  # set default order type to futures
        },
})
# Получение исторических данных
ohlcv = exchange.fetch_ohlcv('MDTUSDT', timeframe='1h', limit=1000)

# Преобразование исторических данных в DataFrame pandas
df = pd.DataFrame(ohlcv, columns=['timestamp', 'open', 'high', 'low', 'close', 'volume'])
df['timestamp'] = pd.to_datetime(df['timestamp'], unit='ms')
# rows_to_delete = df.index[-9:]
# # Удалите выбранные строки из DataFrame
# df.drop(rows_to_delete, inplace=True)
#
# print(df.tail(20))

df['rsi'] = talib.RSI(df['close'], timeperiod=14)
df['stoch_k'], df['stoch_d'] = talib.STOCH(df['high'], df['low'], df['close'], fastk_period=14, slowk_period=3, slowd_period=3)
df['cci'] = talib.CCI(df['high'], df['low'], df['close'], timeperiod=14)
df['macd'], _, _ = talib.MACD(df['close'], fastperiod=12, slowperiod=21, signalperiod=9)
df['ema_7'] = talib.EMA(df['close'], timeperiod=3)
df['ema_14'] = talib.EMA(df['close'], timeperiod=10)
df['ema_21'] = talib.EMA(df['close'], timeperiod=21)
df['sma_20'] = talib.SMA(df['close'], timeperiod=20)
# Заполнение пропущенных значений
df = df.dropna()

# Создание DataFrame для Prophet и добавление индикаторов в регрессоры
df_prophet = pd.DataFrame()
df_prophet['ds'] = df['timestamp']
df_prophet['y'] = df['close']
df_prophet['rsi'] = df['rsi']
df_prophet['cci'] = df['cci']
df_prophet['stoch_d'] = df['stoch_d']
df_prophet['stoch_k'] = df['stoch_k']
df_prophet['macd'] = df['macd']
# Обучение модели Prophet
m = Prophet()
regressors = ['macd','stoch_d']
for regressor in regressors:
    m.add_regressor(regressor)
m.fit(df_prophet)

# Прогнозирование на следующих 5 интервалов
future = m.make_future_dataframe(periods=5, freq='D')

# Ensure the future df has same regressor columns
for col in regressors:
    if col in df_prophet:
        last_val = df_prophet[col].iloc[-1]
        future[col] = last_val

forecast = m.predict(future)
result = forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']]
print(forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']].tail())

print(result['yhat'].iloc[-5])
