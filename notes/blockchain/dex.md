|Name|Underlying Blockchain|Type|Trading Fee|
|----|---------------------|----|-----------|
|[Uniswap](https://uniswap.org/whitepaper-v3.pdf)|Ethereum|Constant function market makers|
|[Curve](https://classic.curve.fi/whitepaper)|Ethereum|
|YieldSpace||

CFMMs as they are implemented today are often capital inefficient. In the constant product market maker formula used by Uniswap v1 and v2, only a fraction of the assets in the pool are available at a given price. This is inefficient, particularly when assets are expected to trade close to a particular price at all times.