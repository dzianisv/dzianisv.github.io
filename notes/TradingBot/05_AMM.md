## Constant Product Market Maker (CPMM)
The first type of CFMM to emerge was the constant product market maker (CPMM), which was popularized by the first AMM-based DEX, Bancor. CPMMs are based on the function x*y=k, which establishes a range of prices for two tokens according to the available quantities (liquidity) of each token. When the supply of token X increases, the token supply of Y must decrease, and vice-versa, to maintain the constant product K. When plotted, the result is a hyperbola where liquidity is always available but at increasingly higher prices, which approach infinity at both ends. [5]

![](2023-02-16-18-49-54.jpg)

## Constant Sum Market Maker (CSMM)
The second type is a constant sum market maker (CSMM), which is ideal for zero-price-impact trades but does not provide infinite liquidity. CSMMs follow the formula x+y=k, which creates a straight line when plotted. This design unfortunately allows arbitrageurs to drain one of the reserves if the off-chain reference price between the tokens is not 1:1. Such a situation would destroy one side of the liquidity pool, leaving all of the liquidity residing in just one of the assets and therefore leaving no more liquidity for traders. Because of this, CSMM is a model rarely used by AMMs. [5]

![](2023-02-16-18-51-00.jpg)


## Constant Mean Market Maker (CMMM)
The third type is a constant mean market maker (CMMM), which enables the creation of AMMs that can have more than two tokens and be weighted outside of the standard 50/50 distribution. In this model, the weighted geometric mean of each reserve remains constant. For a liquidity pool with three assets, the equation would be the following: (x*y*z)^(⅓)=k. This allows for variable exposure to different assets in the pool and enables swaps between any of the pool’s assets.
