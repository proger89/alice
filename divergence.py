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


# Укажите символ (пару) для анализа
symbol = 'JOEUSDT'

# Получите исторические данные
candles = exchange.fetch_ohlcv(symbol, timeframe='1h', limit=100)

# Создайте DataFrame из данных
df = pd.DataFrame(candles, columns=['timestamp', 'open', 'high', 'low', 'close', 'volume'])

# Вычислите RSI
rsi_period = 14  # Период RSI (замените на нужный)
df['rsi'] = talib.RSI(df['close'], timeperiod=rsi_period)

# Реализуйте функцию для поиска дивергенции
def find_divergence(dataframe):
    for i in range(1, len(dataframe)):
        if dataframe['close'][i] > dataframe['close'][i - 1] and dataframe['rsi'][i] < dataframe['rsi'][i - 1]:
            return "bullish"  # Бычья дивергенция
        elif dataframe['close'][i] < dataframe['close'][i - 1] and dataframe['rsi'][i] > dataframe['rsi'][i - 1]:
            return "bearish"  # Медвежья дивергенция
    return "No divergence"  # Если дивергенция не найдена

# Проверьте наличие дивергенции и верните результат
divergence_type = find_divergence(df)
if divergence_type != "No divergence":
    print(f"Найдена {divergence_type} дивергенция")
else:
    print("Дивергенция не найдена")
