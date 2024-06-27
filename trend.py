import ccxt
import numpy as np
import pandas as pd
import talib

def calculate_trend(exchange, symbol, timeframe):
    # Get candlestick data for the specified symbol and timeframe
    candles = exchange.fetch_ohlcv(symbol, timeframe)
    # Convert candlestick data to a Pandas dataframe
    df = pd.DataFrame(candles, columns=['timestamp', 'open', 'high', 'low', 'close', 'volume'])
    df['timestamp'] = pd.to_datetime(df['timestamp'], unit='ms')
    df['adx_14'] = talib.ADX(df['high'], df['low'], df['close'], timeperiod=14)
    upper, middle, lower = talib.BBANDS(df['close'], timeperiod=20)
    # Вычисляем волатильность как отношение ширины Bollinger Bands к средней линии
    df['volatility'] = (upper - lower) / middle
    # Устанавливаем пороги для низкой, средней и высокой волатильности
    low_vol = 0.10
    high_vol = 0.20
    # Выводим категории волатильности
    df['volatility_level'] = pd.cut(df['volatility'], bins=[0, low_vol, high_vol, np.inf],
                                    labels=['low', 'medium', 'high'])
    print(df[['timestamp','adx_14','volatility']].tail(20))

def main():
    # Create exchange object and set necessary parameters
    exchange = ccxt.bybit({
        'rateLimit': 1200,
        'enableRateLimit': True,
        'options': {
            'defaultType': 'future',  # set default order type to futures
        },
    })

    # Set the symbol and timeframe
    symbol = 'RSS3USDT'
    timeframe = '1h'

    # Calculate the current trend
    trend = calculate_trend(exchange, symbol, timeframe)

    # Print the trend result
    print(f"The current {trend}")


if __name__ == '__main__':
    main()
