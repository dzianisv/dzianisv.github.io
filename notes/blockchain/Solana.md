## Keys:

The public key is a long string of base58 characters. Its length varies from 32 to 44 characters.

- Vlidator identity
- Vote authority
- Withdraw authority
- Stake authority


Because transaction fees on Solana are assessed per-signature, having one signer instead of two will result in half the transaction fee paid compared to setting the vote authority and validator identity to two different accounts.

The vote authority can be set when the vote account is created. If it is not provided, the default behavior is to assign it the same as the validator identity. The vote authority can be changed later with the vote-authorize-voter-checked command.

The authorized withdrawer keypair is used to withdraw funds from a vote account using the withdraw-from-vote-account command.

The authorized withdrawer must be set when the vote account is created. It must not be set to a keypair that is the same as either the validator identity keypair or the vote authority keypair.


Commission can be set upon vote account creation with the --commission option. If it is not provided, it will default to 100%, which will result in all rewards deposited in the vote account, and none passed on to any delegated stake accounts.


## Addresses

Within the Solana protocol, there are several types of addresses and specialized roles, two of which you've mentioned: the vote address and the identity address.

## Identity Address:
This is the primary address of a validator in the Solana network.
It identifies the validator on the network.
The identity address holds the balance/stake that supports the validator's weight in the network.
This address can be used to perform various operations, like staking, voting, and other instructions.
### Vote Address:
In the Solana consensus mechanism, the vote address is used by validators to submit their votes to the network. Voting is part of the PoH (Proof of History) and PoS (Proof of Stake) combined consensus mechanism that Solana uses.
Each validator has an associated vote account. This vote account is separate from the identity address to maintain a separation of concerns – it exclusively handles the voting operations.
Vote accounts track validator votes and rewards.
The primary difference between the two is their function: the identity address identifies the validator and can hold the funds associated with it, while the vote address handles the voting process and tracks the voting history and rewards.

## Configuring CLI

```sh
solana config set --url https://api.devnet.solana.com
# Config File: /Users/engineer/.config/solana/cli/config.yml
# RPC URL: https://api.devnet.solana.com
# WebSocket URL: wss://api.devnet.solana.com/ (computed)
# Keypair Path: /Users/engineer/.config/solana/id.json
# Commitment: confirmed
solana --version
# > solana-cli 1.16.5 (src:26777419; feat:2891131721, client:SolanaLabs)
solana cluster-version
# > 1.16.5
```

## Wallet

### `solana` CLI
- filesystem `solana-keygen new --no-passphrase -o ~/.config/solana/account1.json`, `solana-keygen pubkey /home/solana/my_wallet.json`
- paper: `solana-keygen new --no-passphrase --no-outfile`, `solana-keygen pubkey prompt://`
- hardware `solana-keygen pubkey usb://ledger?key=0`

Output of a key generation looks like
```
Generating a new keypair
Wrote new keypair to /Users/engineer/.config/solana/account1.json
============================================================================
pubkey: CmrbaCTtCFd4NugCHdafLThzGWd9mBT9VDi3PhNctA1C
============================================================================
Save this seed phrase to recover your new keypair:
soldier mosquito world uncover noodle bean cargo lawn treat theory duck drop
============================================================================
```

## Token transfer

```sh
solana airdrop 1 $ACCCOUNT_ADDRESS
# Requesting airdrop of 1 SOL
# Signature: 3MC8QfzhBE47bUX1eKG25mCuj6qiNDYax9eYdseHrMNfAEiegy8QwH6BC2Gxcgxc3z6G22sckaWxRDtWeq8sHmUz
# 1 SOL
solana balance $ACCOUNT_ADDRESS
solana confirm -v $SIGNATURE

solana transfer --from $ACCOUNT_1 $ACCOUNT_2 0.5 --allow-unfunded-recipient --fee-payer $ACCOUNT_1
```

ACCOUNT_1=52SbjBdfPgfnx5QeVAQJ33Za1Mognq1piCJkdoQYzhRv
ACCOUNT_2=CmrbaCTtCFd4NugCHdafLThzGWd9mBT9VDi3PhNctA1C


## Staking

```sh
# Create a Stake Account
solana create-stake-account --from <KEYPAIR> stake-account.json <AMOUNT> \
    --stake-authority <KEYPAIR> --withdraw-authority <KEYPAIR> \
    --fee-payer <KEYPAIR>

solana stake-account $ACCOUNT_3

# Set Stake and Withdraw Authorities
solana stake-authorize <STAKE_ACCOUNT_ADDRESS> \
    --stake-authority <KEYPAIR> --new-stake-authority <PUBKEY> \
    --fee-payer <KEYPAIR>

# Delegate stake
solana delegate-stake --stake-authority <KEYPAIR> <STAKE_ACCOUNT_ADDRESS> <VOTE_ACCOUNT_ADDRESS> \
    --fee-payer <KEYPAIR>

# Once delegated, you can undelegate stake with the solana deactivate-stake command:
solana deactivate-stake --stake-authority <KEYPAIR> <STAKE_ACCOUNT_ADDRESS> \
    --fee-payer <KEYPAIR>

# Transfer tokens out of a stake account with the solana withdraw-stake command
solana withdraw-stake --withdraw-authority <KEYPAIR> <STAKE_ACCOUNT_ADDRESS> <RECIPIENT_ADDRESS> <AMOUNT> \
    --fee-payer <KEYPAIR>
```