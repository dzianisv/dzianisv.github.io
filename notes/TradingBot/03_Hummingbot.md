With Hummingbot, you have two config options to define how the bot will handle the gas price:

`ethgasstation_gas_enabled = False`

In this situation, Hummingbot will use a fixed gas price for the ethereum transactions it creates, which will be determined by the value set on manual_gas_price.

`ethgasstation_gas_enabled = True`


When `concurrent_orders_submission` is set as True, the bot will create both orders at the same time.

If you set market_1 as the AMM, this will reduce the risk of only one side of the operation being executed if the blockchain transaction fails.

Before starting, take a look at the liquidity level of the market you will be running Hummingbot and estimate the ideal slippage buffer based on the order_size you are using.

If your order_size is usually bigger than the size of the orders being offered on the order book, you might want to increase the market_#_slippage_buffer.

## Profitability

### COB

When you are arbitraging between two COB exchanges, calculating the min_profitability is pretty straightforward:

Check what is the trade fee on both exchanges (trading costs) and add your profit margin.

