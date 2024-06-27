import ccxt

# Указать символ (пару) и биржу
symbol = 'RSS3USDT'  # Пример: биткоин к доллару США
exchange = ccxt.binance({
    'rateLimit': 1200,
    'enableRateLimit': True,
    'options': {
        'defaultType': 'future',  # set default order type to futures
    },
})
try:
    # Получить информацию о финансовой ставке
    funding_rate_info = exchange.fetch_funding_rate(symbol=symbol)
    #result = float(funding_rate_info['info']['fundingRate']) * 100
    print(funding_rate_info)

except ccxt.BaseError as e:
    print("Произошла ошибка при получении информации о финансовой ставке:", str(e))
