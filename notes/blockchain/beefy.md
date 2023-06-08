
![](beefy.md-images/2023-06-06-16-24-56.jpg)
At Beefy 'you earn what you stake', regardless if this is a liquidity pool (LP) token or a single asset. In this example, staking CAKE-BNB LP will result in more CAKE-BNB LP over time. This effectively grows your share in the liquidity pool and thus allows for more and more rewards over time [Reference](https://docs.beefy.finance/faq/infographics).

When browsing the vaults on the platform, you will see the annual percentage yield (APY), which takes the frequent compounding into consideration compared to annual percentage rate (APR) which does not. You will also see daily interest percentages and the total amount invested in a vault by all users (TVL).

After depositing tokens to a vault, the user is supplied with vault specific mooTokens which represent their share in the vault.

**Why can't someone just do this themselves?**
They could, but vaults help you save on personal time and transaction fees, maintain healthy collateral to debt ratios, self-optimize for the best possible yields, and automatically reinvest earnings. Attempting to do this manually would result in large inefficiencies. At Beefy we like to say: "Sit back and relax, the vault does all the work for you."


## Contracts

### Vault

The [Beefy Vault Contract](https://docs.beefy.finance/developer-documentation/vault-contract) is the central user-facing implementation of the Beefy protocol, which accepts and manages user deposits and mints mooTokens as a proof of receipt to facilitate withdrawals. It follows the ERC-20 standard for fungible, transferrable tokens.
Besides handling deposits and withdrawals, the primary function of the vault is to direct deposited funds to the relevant autocompounding . The vault and strategy contracts are kept separate to isolate any risks in the strategy from user deposits.[Reference](https://docs.beefy.finance/developer-documentation/vault-contract)

- [`function deposit(uint _amount) public nonReentrant`](https://docs.beefy.finance/developer-documentation/vault-contract#deposit) Executes a transfer of a specified _amount of "want" (i.e. underlying farm token) from the depositor to the vault, and then mints a proportional quantity of mooTokens to the depositor in return.

- [`function withdraw(uint256 _shares) public`](https://docs.beefy.finance/developer-documentation/vault-contract#withdraw) Executes a burn of a specified _amount of mooTokens from the depositor, and then transfers a proportional quantity of "want" (i.e. underlying farm token) to the depositor in return.

- [`function proposeStrat(address _implementation) public onlyOwner`](https://docs.beefy.finance/developer-documentation/vault-contract#proposestrat) - Writes the address of an alternate strategy to the Vault Contract's memory, in anticipation of upgrade the current strategy to the alternate using .

- [`function upgradeStrat() public onlyOwner`](https://docs.beefy.finance/developer-documentation/vault-contract#upgradestrat) - Replaces the address of the current strategy with an alternate strategy specified by .

## Fees

![](beefy.md-images/2023-06-06-16-26-03.jpg)
Fee on the Vault profits is split up
- distributed back to BIFI stakers
- allocated to Beefy's treasury,
- sent to the strategist that developed the vault
- sent to the one calling the vault's harvest function

These fees are already built into the APY of each vault and daily rate


### What is harvesting on deposit?
Many of Beefy's vaults "Harvest on Deposit". This means that when you deposit into the vault, you are also calling the harvest function of the vault's strategy. By calling the harvest function, you trigger the collection of pending farm rewards and compounding of those rewards back into the vault tokens for everyone.

### Harvesting on Ethereum
As transaction fees on Ethereum are expensive, Beefy has introduced a few rules that determine the vault's harvesting frequency.
Vault TVL is above $100k: vault will be harvested every 3 days.
Vault TVL is below $100k but above $10k: vault will be harvested every 15 days.

    Vault TVL is below $10k: community harvest.

Community harvest implies that the harvest function on the strategy contract has to be manually called, and the transaction fees for doing so will not be subsidized by Beefy. [Reference](https://docs.beefy.finance/products/vaults)
`
## Lending Vaults

Most Beefy single asset vaults utilize decentralized marketplaces for lenders and borrowers. By depositing your initial asset in the vault, Beefy deposits it into the lending marketplace and borrows against your token at safe levels of collateral.
The borrowed tokens are redeposited into the platform, and once again used as collateral to borrow more tokens. This cycle is repeated multiple times to generate as much interest as possible from the lending interest and the reward token, which is used to buy more of your originally deposited assets. This strategy is also known as a folding strategy. It is noteworthy that this "leveraged" multi lending and multi borrowing is only with the deposited vault token, so there is no liquidation risk due to token price swings.

## Risks

Beefy vaults are audited, but this does not mean that a vault is entirely risk free. Below are some of the general vault risks:

- Assets deposited into the vault have no risk of decreasing in quantity but can decrease in monetary value.
- As with any smart contract, the ultimate risk is that an investor's funds can end up stolen or unable to be withdrawn. The team does take steps to quantify the security risks of smart contracts and will only interact with ones that meet a specific set of requirements after excessive testing to make sure the underlying platform does not contain so called 'rug-pull' functions.

# Strategies

![](beefy.md-images/2023-06-06-16-13-45.jpg)
![](beefy.md-images/2023-06-06-16-15-10.jpg)

- Each vault and strategy link is hardcoded, and the code has been built to be immutable, so once they are released, they become unstoppable. No one can modify the vaults and strategies.

## Is APY/365 the right way to determine daily gains?
No, the effect of compounded interest is exponential, not linear. A daily compounded interest of 1% would yield 3678.34% a year.

## What is a Boost?
![](beefy.md-images/2023-06-06-16-29-18.jpg)
When you deposit in a Beefy vault, you receive a 'receipt' token prefixed with 'moo' in your wallet. When a Boost is available, you may stake that token in the Boost to receive the extra earnings benefit. You earn extra yield on top of your vault earnings!

## Undertanding Exponential Growth

`growth = (1 + APR)^times`  for instnace `growth = (1 + 100%)^3`
![](beefy.md-images/2023-06-06-16-30-17.jpg)

## Beefy Contracts

https://docs.beefy.finance/safu-protocol/contracts-and-timelocks

## Oracles

Beefy's contracts do not use external oracles. The problem with oracles is, in short, that its data can be inaccurate or manipulated, and unreliable oracles can lead to exploits. Because Beefy's contracts do not rely on external data in any form, such as asset prices, our vaults are not susceptible to flashloan exploits.
