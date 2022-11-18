|Blockchain|Consensus               |Txps   |Turning-Complete VM|Notes  |
|----------|------------------------|-------|-------------------|-------|
|Bitcoin        |PoW-SHA256         | 7     ||
|Bitcoin Cash   | PoW-SHA256        | 60    ||
|Litecoin       | PoW-Scrypt        | 54    ||
|Ethereum       |PoS                | 15-30 |EVM|
|Tenderming     |BFT                |[4000-16000](https://www.gemini.com/cryptopedia/cosmos-ignite-crypto-consensus-tendermint-ecosystem)|[ABCI](https://docs.tendermint.com/v0.34/introduction/what-is-tendermint.html)|
|Solana         |Proof-of-History   |[710k](https://solana.com/solana-whitepaper.pdf)|LLVM, PBF|
|Near           |Proof-of-Stake     |100k   |   
|IronFish       |Proof-of-Work      |       |Private transactions|
|Cosmos         |BFT                |       |       ||different applications create their own blockchain|
|Avalance       |BFT                |       |AVM    |

Several popular alternative L1 blockchains have focused on solving blockchain scalability by scaling vertically — increasing the hardware requirements to run nodes. This improves performance but often at the cost of some degree of decentralization. Furthermore, while it creates an initial increase in throughput, future improvements are limited by Moore’s Law (the rate of improvement in computing hardware performance). Ultimately, the network’s performance is bounded by what a single, albeit powerful, computer can do. L1s that fall into this category include Solana, Binance Smart Chain, and ThunderCore.

Another approach is horizontal scaling — adding more hardware to the blockchain network, and having each node in the network perform only a subset of the overall work. This includes blockchains that have a multi-chain design, such as Cosmos, in which different applications create their own blockchain. It also includes sharding, which separates the blockchain into multiple smaller ones, all sharing the same block structure and consensus. This is how L1s like Ethereum, NEAR, and Harmony plan to improve scalability going forward.

Reference: https://medium.com/amber-group/an-introduction-to-near-a19ff7e7cd78