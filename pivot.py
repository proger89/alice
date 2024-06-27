import sys
from sklearn.pipeline import Pipeline
from ta.volume import ForceIndexIndicator
from sklearn.metrics import mean_squared_error
import pandas as pd
import talib
import time
from sklearn.decomposition import TruncatedSVD
from sklearn.linear_model import Lasso
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler
import pandas_ta
import ta
from ccxt.bybit import bybit  # Changed to sync version of ccxt
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
import seaborn as sns
from sklearn.model_selection import GridSearchCV
import ta.trend as trend2
from sklearn.model_selection import RandomizedSearchCV
from sklearn.metrics import mean_squared_error
import numpy as np

def VWMA(df, period):
    return df['close'].mul(df['volume']).rolling(window=period).sum() / df['volume'].rolling(window=period).sum()



def weighted_moving_average(data, period, weights=None):
    if weights is None:
        weights = np.arange(1, period + 1)
    return data.rolling(period).apply(lambda x: np.dot(x, weights) / weights.sum(), raw=True)

def hull_moving_average(data, period):
    sqrt_period = np.sqrt(period)
    weights = np.arange(1, period + 1)

    wma1 = weighted_moving_average(data, period, weights)
    wma2 = weighted_moving_average(data, period // 2, weights[:period // 2]*2)
    wma_diff = 2 * wma2 - wma1

    hma = weighted_moving_average(wma_diff, int(sqrt_period), weights[:int(sqrt_period)]).apply(np.sqrt)
    return hma
def calculate_demark(df):
    '''Вычисляем уровни поддержки и сопротивления DeMark'''

    # Конец периода
    x = (df['high'] + df['low'] + df['close']) / 3

    # Определяем X/2
    x2 = x / 2

    # Высчитываем уровни сопротивления и поддержки
    df['demark_resistance'] = x2 - df['low']
    df['demark_support'] = x2 - df['high']

    return df

def predict_pivot_price(df_15m,real_time_price):
    df = df_15m.copy()
    df['timestamp'] = pd.to_datetime(df['timestamp'], unit='ms')

    df['macd'] = trend2.MACD(df['close']).macd()
    df['macd_momentum'] = df['macd'].diff()

    df['rsi'] = talib.RSI(df['close'], timeperiod=14) / talib.RSI(df['close'], timeperiod=14).mean()

    force_index = ForceIndexIndicator(df['close'], df['volume'], window=14)
    df['force_index'] = force_index.force_index()

    df['vwma'] = VWMA(df, 10)  # здесь 14 - это период VWMA
    df['HMA'] = hull_moving_average(df['close'], 9)  # здесь 14 - это период HMA

    df['cci'] = talib.CCI(df['high'], df['low'], df['close'], timeperiod=14)
    # Drop the NaN values
    df = df.dropna()

    X_cols = ['rsi','force_index','vwma', 'HMA','cci','macd','macd_momentum']

    X = df[X_cols]
    y = df['close'].iloc[1:]

    # Drop rows with NaN target values
    X = X.dropna()
    y = y.dropna()

    # corr_matrix = X.corr()
    #
    # # Create a heatmap of the correlation matrix
    # sns.set(font_scale=1.2)
    # plt.figure(figsize=(15, 10))
    # sns.heatmap(corr_matrix, annot=True, cmap='coolwarm')
    # plt.title('Correlation Heatmap of Features', fontsize=20)
    # plt.show()

    pca = PCA(n_components=2)
    principalComponents = pca.fit_transform(X)
    principalDf = pd.DataFrame(data=principalComponents)
    principalDf = principalDf.head(len(y))  # Make sure X and y have the same length

    X_train, X_test, y_train, y_test = train_test_split(principalDf, y, test_size=0.2, random_state=42)

    # Apply Lasso regularization
    model = Lasso(alpha=0.2)
    model.fit(X_train, y_train)

    # Predict the next close value
    next_close = model.predict(X_test.iloc[-1:])[0]
    trend = 2 if next_close > real_time_price else 1

    mse = mean_squared_error(y_test.iloc[-1:], [next_close])
    # Calculate MSE in percentage
    mse_perc = mse / y_test.mean() * 100
    formatted_mse = format(mse_perc, '.8f')
    print("MSE:",formatted_mse)


    return {'trend': trend, 'price': next_close}

exchange = bybit({
        'rateLimit': 1200,
        'enableRateLimit': True,
        'options': {
            'defaultType': 'future',  # set default order type to futures
        },
})


pair = "SHIB1000USDT"
limit = 1500

ohlcv = exchange.fetch_ohlcv(pair, '30m', limit=limit)
ticker = exchange.fetch_ticker(pair)
real_time_price = float(ticker['close'])
df_15m = pd.DataFrame(ohlcv, columns=['timestamp', 'open', 'high', 'low', 'close', 'volume'])

print(len(df_15m))

print(predict_pivot_price(df_15m,real_time_price))