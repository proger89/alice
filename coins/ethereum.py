from web3 import Web3
import pandas as pd

# Инициализируем соединение с блокчейном Ethereum
w3 = Web3(Web3.HTTPProvider('https://mainnet.infura.io/v3/b9f166509a054e79a491fadc507c7902'))

# Получаем номер последнего блока
latest_block = w3.eth.block_number

# Задаем количество блоков, которые хотим проанализировать (например, последние 1000)
num_blocks_to_check = 10

# Собираем данные о транзакциях из блоков
transactions = []
for i in range(latest_block - num_blocks_to_check, latest_block + 1):
    block = w3.eth.get_block(i, full_transactions=True)
    for tx in block.transactions:
        transactions.append(tx)

# Преобразуем данные о транзакциях в DataFrame
df = pd.DataFrame(transactions)

# Выводим данные
print(df)
