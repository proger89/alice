import sys
import ta
import pandas as pd
import talib
import numpy as np
from prophet import Prophet
from ta.volume import ForceIndexIndicator
import ta.momentum

def detect_flat(df):
    df = df.copy()
    # Вычисление ATR и DMI
    df['atr'] = talib.ATR(df['high'], df['low'], df['close'])
    df['plus_di'] = talib.PLUS_DI(df['high'], df['low'], df['close'])
    df['minus_di'] = talib.MINUS_DI(df['high'], df['low'], df['close'])

    # Определение боковика
    if df['atr'].tail(10).max() < 0.5 and df['atr'].tail(10).min() > 0.1 and abs(
            df['plus_di'].tail(10) - df['minus_di'].tail(10)).max() < 20:
        return True
    else:
        return False

def detect_strong_adx(df):
    df = df.copy()
    df['adx_14'] = talib.ADX(df['high'], df['low'], df['close'], timeperiod=14)
    df['force_index'] = ta.volume.ForceIndexIndicator(df['close'], df['volume']).force_index()
    adx_threshold = 40
    last_adx = df['adx_14'].iloc[-1]
    if last_adx >= adx_threshold:
        return True
    else:
        return False


def percentage_difference(old_price, new_price, unsigned=True):
    difference = new_price - old_price
    percentage = (difference / old_price) * 100
    return abs(percentage) if unsigned else percentage


def bvol24(df):
    # Вычислить BVOL 24
    upper, middle, lower = talib.BBANDS(df['close'], timeperiod=20)
    # Вычисляем волатильность как отношение ширины Bollinger Bands к средней линии
    df['volatility'] = (upper - lower) / middle
    # Устанавливаем пороги для низкой, средней и высокой волатильности
    low_vol = 0.10
    high_vol = 0.15
    # Выводим категории волатильности
    df['volatility_level'] = pd.cut(df['volatility'], bins=[0, low_vol, high_vol, np.inf],
                                    labels=['low', 'medium', 'high'])
    current = df['volatility_level'].iloc[-1]

    # Проверить, является ли значение BVOL 24 больше 1.5
    if current in ['high']:
        is_high_bvol24 = True
    else:
        is_high_bvol24 = False
    return is_high_bvol24

# Реализуйте функцию для поиска дивергенции
def find_divergence(dataframe):
    dataframe = dataframe.copy()
    rsi_period = 14  # Период RSI (замените на нужный)
    dataframe['rsi'] = talib.RSI(dataframe['close'], timeperiod=rsi_period)
    for i in range(1, len(dataframe)):
        if dataframe['close'][i] > dataframe['close'][i - 1] and dataframe['rsi'][i] < dataframe['rsi'][i - 1]:
            return 2
        elif dataframe['close'][i] < dataframe['close'][i - 1] and dataframe['rsi'][i] > dataframe['rsi'][i - 1]:
            return 1
    return 0


def predict_pivot_price(real_time_price,df,is_stoch=True):
    df = df.copy()
    df['timestamp'] = pd.to_datetime(df['timestamp'], unit='ms')
    df['rsi'] = talib.RSI(df['close'], timeperiod=14)
    df['stoch_k'], df['stoch_d'] = talib.STOCH(df['high'], df['low'], df['close'], fastk_period=14, slowk_period=3,
                                               slowd_period=3)
    df['cci'] = talib.CCI(df['high'], df['low'], df['close'], timeperiod=14)
    df['macd'], _, _ = talib.MACD(df['close'], fastperiod=12, slowperiod=21, signalperiod=9)
    # Заполнение пропущенных значений
    df = df.dropna()

    # Создание DataFrame для Prophet и добавление индикаторов в регрессоры
    df_prophet = pd.DataFrame()
    df_prophet['ds'] = df['timestamp']
    df_prophet['y'] = df['close']
    df_prophet['rsi'] = df['rsi']
    df_prophet['cci'] = df['cci']
    df_prophet['stoch_k'] = df['stoch_k']
    df_prophet['stoch_d'] = df['stoch_d']
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
    next_close = result['yhat'].iloc[-5]
    trend = 2 if next_close > real_time_price else 1
    print("Next:", next_close)
    print("Real time:", real_time_price)

    return {'trend': trend, 'price': next_close}

def calculate_trend(df):
    df = df.copy()
    df['force_index'] = ta.volume.ForceIndexIndicator(df['close'], df['volume']).force_index()
    last_force = df['force_index'].iloc[-1]
    if last_force > 0:
            return 2
    elif last_force < 0:
            return 1
    else:
        return 0

def volume_detect(df):
    df = df.copy()
    obv_values = talib.OBV(df['close'], df['volume'])
    threshold = 1000

    last_obv_value = obv_values.iloc[-1]
    previous_obv_value = obv_values.iloc[-2]
    obv_difference = abs(last_obv_value) - abs(previous_obv_value)

    if abs(obv_difference) < threshold:
        return 0
    elif last_obv_value > previous_obv_value:
        return 2
    else:
        return 1

def determine_trend(df):
    df = df.copy()
    k_period = 14
    d_period = 3
    rsi_period = 14
    macd_fast_period = 12
    macd_slow_period = 26
    macd_signal_period = 9
    df['%K'], df['%D'] = talib.STOCH(df['high'], df['low'], df['close'], fastk_period=k_period, slowk_period=d_period,
                                     slowd_period=d_period)
    df['RSI'] = talib.RSI(df['close'], timeperiod=rsi_period)
    df['MACD'], df['Signal'], _ = talib.MACD(df['close'], fastperiod=macd_fast_period,
                                             slowperiod=macd_slow_period, signalperiod=macd_signal_period)

    cci_period = 14
    df['CCI'] = talib.CCI(df['high'], df['low'], df['close'], timeperiod=cci_period)
    df['ema'] = talib.EMA(df['close'], timeperiod=12)
    if df['CCI'].iloc[-1] > 100 and df['%K'].iloc[-1] > df['%D'].iloc[-1] and df['MACD'].iloc[-1] > df['Signal'].iloc[-1] and df['RSI'].iloc[-1] > 50 and df['close'].iloc[-1] > df['ema'].iloc[-1]:
        return 2
    elif df['CCI'].iloc[-1] < -100 and df['%K'].iloc[-1] < df['%D'].iloc[-1] and df['MACD'].iloc[-1] < df['Signal'].iloc[-1] and df['RSI'].iloc[-1] < 50 and df['close'].iloc[-1] < df['ema'].iloc[-1]:
        return 1
    else:
        return 0
def get_result(df_1h, real_time_price):
    trend_stoch = determine_trend(df_1h)
    predict = predict_pivot_price(real_time_price, df_1h)
    divergence_result = find_divergence(df_1h)
    trend = predict['trend']
    price_ai = predict['price']
    flat_min = detect_flat(df_1h)
    percent_ai = percentage_difference(real_time_price, price_ai)
    volume = volume_detect(df_1h)
    print("Percent AI:", percent_ai)
    print("flat_min:", flat_min)
    print("Trend predict:", trend)
    print("trend_stoch:", trend_stoch)
    print("divergence_result:", divergence_result)
    print("price_ai:", price_ai)
    print("volume:", volume)
    if percent_ai >= 3 and flat_min == False and trend_stoch == trend and divergence_result == 0:
            return {'result': trend, 'predict_price': price_ai, 'real_time': real_time_price,
                        'percent': percent_ai, 'limit_price': 0}
    else:
            return {'result': -1, 'predict_price': 0, 'real_time': 0, 'percent': 0, 'limit_price': 0}
