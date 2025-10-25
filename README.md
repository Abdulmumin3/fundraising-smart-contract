🧠 Author

Olawale Adesoye
📧 — https://github.com/Abdulmumin3/
🦊 — Tested on Sepolia Testnet

# 💰 Fundraising Smart Contract (ETH ↔ USD Conversion)

A simple and secure Ethereum-based fundraising smart contract written in **Solidity 0.8.27**, featuring **Chainlink price feed integration** to convert ETH values into USD and enforce a minimum donation threshold.

---

## 📘 Overview

This project demonstrates how to build and deploy a **fundraising contract** that:

-   Accepts ETH from multiple senders.
-   Converts ETH → USD using Chainlink price oracles.
-   Stores contributions by address.
-   Allows only the contract owner to withdraw all funds.
-   Resets all records after withdrawal.
-   Supports direct ETH transfers via `receive()` and `fallback()`.

---

## 🧩 Smart Contracts

### `Fundraising.sol`

Handles donations, ownership checks, and withdrawals.

Key features:

-   `sendMoney()` — Allows anyone to contribute ETH if above the USD threshold.
-   `withdraw()` — Allows only the owner to withdraw total funds.
-   `onlyTheOwnerCanExecute` — Modifier to restrict withdrawals.
-   `receive()` and `fallback()` — Accept ETH sent directly to the contract.

### `ETHtoUSDConverter.sol`

A Solidity library that fetches live ETH/USD prices via **Chainlink** and performs the conversion.

Uses the **Sepolia ETH/USD feed**:

---

## ⚙️ How It Works

1. **Conversion Logic**

    - The library retrieves the latest ETH/USD price from Chainlink.
    - Multiplies the incoming ETH amount by the price to calculate USD value.

2. **Fundraising**

    - Only donations above `MINIMUM_AMOUNT_SENT` are accepted.
    - Sender’s contribution is tracked via a mapping.

3. **Withdrawal**
    - Only the contract owner (the deployer) can withdraw.
    - All sender records are cleared after withdrawal.

---

## 🧪 How to Test Using Remix

You can test this contract easily on **Remix IDE** with **Sepolia Testnet**.

### Step-by-Step Guide

1. **Open Remix**

    - Visit [https://remix.ethereum.org](https://remix.ethereum.org).

2. **Upload Files**

    - Create two new files in Remix:
        - `Fundraising.sol`
        - `ETHtoUSDConverter.sol`
    - Paste your contract code into each respectively.

3. **Compile**

    - Select Solidity compiler **0.8.27**.
    - Click **Compile Fundraising.sol**.

4. **Deploy**

    - Go to the **Deploy & Run** tab.
    - Set **Environment** to:
        - `Injected Provider - MetaMask` (connected to Sepolia Testnet).
    - Click **Deploy**.

5. **Get Some Sepolia ETH**

    - Use a [Sepolia Faucet](https://sepoliafaucet.com/) to get test ETH in your wallet.

6. **Send ETH to Contract**

    - Under **Deployed Contracts**, expand your `Fundraising` contract.
    - At the top, find the **Value** field (above the function buttons).
        - Enter an amount (e.g., `0.001`) to send 0.001 ETH.
    - Click **sendMoney()**.

    ⚠️ If you send less than the minimum USD value, Remix will show:

    > "Did not send enough money"

7. **Check Conversion**

    - Open the **Deployed Contracts → Fundraising** panel.
    - Call `amountSentByAddress` with your wallet address to confirm the stored value.

8. **Withdraw**
    - Only the owner (deployer) can click **withdraw()** to transfer all ETH out.

---

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
