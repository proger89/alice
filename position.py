import ccxt

exchange = ccxt.bybit({'apiKey': "2MIMxy7xgtVkDfcjeB",'secret': "1dNWPBdbaYAtzcDKFdlY2tIbNqZkXYMLhSBx" })

open_positions = exchange.fetch_derivatives_positions(symbols=["UNFIUSDT"])

print(open_positions[0]['info']['size'])