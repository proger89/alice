import math
import sys
import talib


def detect_trend_manipulation(df):
    rsi = talib.RSI(df['close'], timeperiod=14)
    df['rsi'] = rsi

    if df['rsi'].iloc[-1] >= 70:
        return 2
    else:
        return 1

def increase_by_percent(value, percent):
    return value * (1 + percent / 100)

def decrease_by_percent(value, percent):
    return value * (1 - percent / 100)

def place_order(symbol, side, leverage, take_profit_price,session,real_time_price):

    orders = session.get_open_orders(
        category="linear",
        symbol=symbol,
        openOnly=0,
        limit=1,
    )
    if len(orders['result']['list']) == 0:
        # fetch account balance
        balance_info = session.get_wallet_balance(accountType='CONTRACT',coin='USDT')
        usdt_info = next((coin for coin in balance_info['result']['list'][0]['coin'] if coin['coin'] == 'USDT'), None)
        balance = float(usdt_info['equity'])
        print("Balance:",balance)
        if balance:
            position_info = session.get_positions(
                category="linear",
                symbol=symbol,
            )
            info = position_info['result']['list'][0]

            print(info)

            if int(info['leverage']) != leverage:
                if int(info['tradeMode']) == 1:
                    session.switch_margin_mode(
                        category="linear",
                        symbol=symbol,
                        tradeMode=0,
                        buyLeverage=str(leverage),
                        sellLeverage=str(leverage),
                    )
                else:
                    session.switch_margin_mode(
                        category="linear",
                        symbol=symbol,
                        tradeMode=1,
                        buyLeverage="1",
                        sellLeverage="1",
                    )

                    session.switch_margin_mode(
                        category="linear",
                        symbol=symbol,
                        tradeMode=0,
                        buyLeverage=str(leverage),
                        sellLeverage=str(leverage),
                    )
            # get current price
            ticker = session.get_tickers(category='linear',symbol=symbol)
            current_price = float(ticker['result']['list'][0]['lastPrice'])

            usd_value = (balance / 2) * leverage  # This is the total size of the position in USDT
            quantity = round(usd_value / current_price)  # Convert to LTC
            if quantity:
                order = session.place_order(
                    category="linear",
                    symbol=symbol,
                    side=side,
                    orderType="Market",
                    positionIdx=0,
                    qty=quantity,
                    takeProfit=take_profit_price,
                    triggerBy='MarkPrice',
                    timeInForce="IOC",
                    triggerDirection=1 if side == "Buy" else 2,
                )
            # place order
                return True
            else:
                return False
    return False

def rounding(num,decimal_places=2):
    return math.floor(num * 10 ** decimal_places) / 10 ** decimal_places

def get_decimal(num):
    return len(num.split(".")[1])

def check_position(session, symbol, side):
        positions = session.get_positions(category='linear', symbol=symbol)
        print(positions)
        position = next((position for position in positions['result']['list'] if position['side'] == side), None)
        if not position:
            print(f"No {side} position to close for symbol {symbol}")
            return True
        return False
def close_position(session,exchange, symbol, side):
    # First get the position
    open_positions = exchange.fetch_derivatives_positions(symbols=[symbol])
    # Calculate quantity to close
    quantity = float(open_positions[0]['info']['size'])
    if quantity:
    # Place the order
        response = session.place_order(
            category="linear",
            symbol=symbol,
            side="Buy" if side == "Sell" else "Sell",
            orderType="Market",
            qty=quantity,
            timeInForce="IOC",
        )

        return response
    return False


def cancel_order(session, symbol, order_id):
    response = session.cancel_order(
        category="linear",
        symbol=symbol,
        orderId=order_id,
    )

    print(response)