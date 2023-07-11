# Blockchains and DeFi research

## L1

|Blockchain|Consensus|Txps Practical|Txps Theoretical|Execution Environment|Notes  |Transaction finality (s)|
|----------|---------|--------------|----------------|---------------------|-------|-------|
|Bitcoin|PoW-SHA256|7|-|Bitcoin Script|-|
|Bitcoin Cash|PoW-SHA256|60|-|Bitcoin Script|-|
|Litecoin|PoW-Scrypt|54|-|Bitcoin Script|-|
|Ethereum|PoS|30|-|EVM|-|~15|
|Cosmos/Tendermint|BFT|[4k-16k](https://www.gemini.com/cryptopedia/cosmos-ignite-crypto-consensus-tendermint-ecosystem)|[ABCI](https://docs.tendermint.com/v0.34/introduction/what-is-tendermint.html)|
|Solana|Proof-of-History   |[710k](https://solana.com/solana-whitepaper.pdf)|LLVM, PBF|
|Near|Proof-of-Stake     ||100k|Web Assembly||2.5|
|Avalanche|BFT, Snowball, Proof-of-Stake||[4.5k](https://support.avax.network/en/articles/5325146-what-is-transactional-throughput-tps)|AVM,EVM,Each subnet could implement their own|
|Aptos|BFT Proof-of-Stake|160k||Move||<1|
|[Sui](https://github.com/MystenLabs/sui/blob/main/doc/paper/sui.pdf)|Byzantine consistent broadcast PoS|[120k](https://docs.sui.io/learn/about-sui)||Move|||

Several popular alternative L1 blockchains have focused on solving blockchain scalability by scaling vertically — increasing the hardware requirements to run nodes. This improves performance but often at the cost of some degree of decentralization. Furthermore, while it creates an initial increase in throughput, future improvements are limited by Moore’s Law (the rate of improvement in computing hardware performance). Ultimately, the network’s performance is bounded by what a single, albeit powerful, computer can do. L1s that fall into this category include Solana, Binance Smart Chain, and ThunderCore.

Another approach is horizontal scaling — adding more hardware to the blockchain network, and having each node in the network perform only a subset of the overall work. This includes blockchains that have a multi-chain design, such as Cosmos, in which different applications create their own blockchain. It also includes sharding, which separates the blockchain into multiple smaller ones, all sharing the same block structure and consensus. This is how L1s like Ethereum, NEAR, and Harmony plan to improve scalability going forward.

## L2

|L1|L2|Bridge Mechanism|Txps|Transaction cost|
|-|-|-|-|-|
|Ethereum|Polygon|PoS Sidechain|[7k](https://polygon.technology/solutions/polygon-pos), [but](https://coinchapter.com/matics-7200-transactions-per-second-claim-a-joke-heres-why/)|[0.002MATIC * 0.7378$/MATIC ~ 0.0014$](https://polygonscan.com/tx/0xd30e90ce737f479f8bd21c8ed0869113d118828553164259ec295a160de37825)
|Ethereum|Optimism|Optimistic Rollup|[2k](https://pixelplex.io/blog/polygon-vs-arbitrum-vs-optimism-comparison/)|[0.06$](https://optimistic.etherscan.io/tx/0xc83fdeff1e4f9e62495b06eabc7a0ea6ad0abb643c63c69b7279d17eb1ea4100)
|Ethereum|Arbirtrum|Optimistic Rollup|[319k](https://thedefiant.io/arbitrum-transactions-quadruple-after-upgrade)|[0.04$](https://arbiscan.io/tx/0x8f6cc7ff4c0b3fc1965e3a987f189ba5420148b04fae97ffd027f59d2189600a)
|Ethereum|StarkNet|zk-Rollup||
|Ethereum|zkSync|zk-Rollup|
|Ethereum|[Scroll](https://scroll.io/)|zk-Rollup||[0.002$](https://scrollscan.co/tx/0xc4c5d9d6d1434ed7502bc4e83542175bef4ce8778301408a63dd3145d7f35809)
|Ethereum|[Base](base.org)|Optimistic Rollup||Testnet


Arbitrum and Optimism combined represent almost 80% of the entire layer-2 ecosystem, according to L2beat.[4]

In October, it was reported StarkNet was processing more transactions per week than the Bitcoin (BTC) network.[4]


### PoS Sidechain (Polygon PoS)
It’s important to differentiate Polygon from other Layer 2 solutions like Arbitrum and Optimism since Polygon is technically a sidechain. The difference is that Layer 2 solutions are fully secured by the Ethereum platform, while side chains use their own consensus algorithms. So, sidechains are independent, EVM-compatible solutions that run in parallel with the mainnet[5]

On Polygon, token withdrawals take from several hours to a week depending on the chain bridge being used. For example, using the PoS bridge, the withdrawal will take roughly three hours; using the Plasma bridge, this could increase to seven days. [5]

Polygon PoS Bridge is secured by a set of external verifiers. In a general PoS system, security is generally guaranteed by the assets of the verifier bond and penalty mechanism.

In addition, the Bridge contract retains admin authority and is controlled by a multi-signature wallet via a proxy. This multi-signature wallet started with a 2/3 multi-signature and is now upgraded to a 5/8 scheme. Among the 8 signatories, 4 are Polygon co-founders, and the other 4 are key members from other Polygon DeFi projects.

Through our examination of the contract code, the owner of the contract can upgrade and replace the contract at any time (without a delay period), which means that the owner can withdraw all user assets in the contract at any time, which is certainly a potential security risk. Therefore, the assets transferred to the Polygon chain through the Pos Bridge are not trustless at this stage.

Nevertheless, they have their drawbacks as well, such as lower security. Being separate blockchains, they do not have the security of Layer 1. If they are hacked, though, the damage will be contained within this chain while the main chain will not be affected. At the same time, if the main chain is compromised, sidechains can still operate. [5]


### Polygon Plasma
Polygon Plasma Bridge
The exit mechanism of Polygon Plasma Bridge is based on the Plasma exit mechanism. A challenge period of 7 days is required when withdrawing funds like Optimistic Rollup because of the use of fraud proofs.

However, an important shortcoming of the Plasma solution compared to the Rollup solution is data unavailability, that is, the Plasma operator only generates a hash value of the transaction data and stores it on Layer 1, and Layer 1 does not have the available data to verify whether the operator is malicious and recover all transactions on Layer 2 [3]



### optimistic rollup

In the Optimistic Rollup solution, a third-party Sequencer is responsible for the interaction between Layer 2 and Layer 1. The sequencer will count the corresponding assets in users’ Layer 2 accounts when users deposit assets on Layer 1 and periodically generate new state roots for transactions it receives on Layer 2 and publish it on Ethereum. When users withdraw funds, they prove that they have sufficient funds at the current state by showing a Merkle proof referencing the state roots published by the sequencer to complete the withdrawal. Optimistic Rollup introduces the concept of verifier and challenge period to prevent the sequencer from submitting invalid state transition. A challenge period of 7 days is required when any new state roots are released by the sequencer. During the challenge period, the verifier can publish a fraud proof whenever finds that one of the state transitions is invalid. If the proof is successful, the state transition will be canceled and the sequencer’s deposit will be awarded to the verifier. [3]

At the same time, the sequencer is required to submit all the transaction data on Layer 2 to the calldata on Layer 1 to avoid the situation where the sequencer is malicious or offline, so that even if the sequencer disappears, a new sequencer may retrieve all the Layer 2-related data and continue from where their predecessor left off [3].
### zkSync rollup

In the ZK Sync Bridge, the Rollup solution will compress the transactions on Layer 2 and submit them to the calldata on Layer 1. This first ensures the data availability of Layer 2 network data on Layer 1.[3]

In addition, anyone can trigger an emergency exit mode when the entire zkSync system is unavailable, such as when Layer 2 cannot receive the user’s signature and Layer 2 no longer submits transaction data to Layer 1.[3]


# DeFi

## Landing & Borrowing

- Compound
- Celsium (FAILED recently)

## DeX

- UniSwap
- dyDx
- PancakeSwap
- Curve

## Decentralized Custody

## Real Estate

- Tangible USDR https://www.tangible.store/realusd

## Inflation Protected Tokens


- Ampleforth
Rebases the entire supply of AMPL tokens for all holders each day
Targeting 2019 USD + Inflation so currently targeting around ~$1.15
- Spot.cash
Stable store of value token built on top of Ampleforth so that it is inflation resistant for a long term store
- Frax Finance - Frax Price Index product
Users deposit collateral to mint FPI tokens
Frax protocol then acts as a sort of hedge fund and invests the collateral into different strategies across defi to try to earn yield equal to or greater than CPI
If they fail to match CPI interest rates, the protocol sells its governance token FPIS to users to make up the difference
Holders of FPIS earn any profit above CPI that the collateral yields which is the draw to holding this token on top of being able to participate in governance
- Nuon
Maker clone but daily CPI inflation is applied to the underlying vaults/positions and forces users to deposit more collateral if CPI makes their position unhealthy
Charges 0% interest on loans


# Staking

[Staking Rewards Dashboard](https://www.stakingrewards.com/?sort=totalValueLocked_DESC)


References:

- [1] https://aptos.dev/assets/files/Aptos-Whitepaper-47099b4b907b432f81fc0effd34f3b6a.pdf
- [2] https://educationecosystem.com/blog/technical-differences-between-ethereum-aptos-and-solana-blockchainhttps://medium.com/amber-group/an-introduction-to-near-a19ff7e7cd78
- [3] https://hackernoon.com/polygon-vs-optimistic-and-zk-rollups-an-in-depth-comparison-dn2035c6
- [4] https://cointelegraph.com/news/optimism-and-arbitrum-flip-ethereum-in-combined-transaction-volume
- [5] https://pixelplex.io/blog/polygon-vs-arbitrum-vs-optimism-comparison/
