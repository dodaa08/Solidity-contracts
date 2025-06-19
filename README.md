# 🌈 Solidity Contracts Monorepo

![Ethereum](https://img.shields.io/badge/Ethereum-Smart%20Contracts-3C3C3D?logo=ethereum&logoColor=white)
![Solidity](https://img.shields.io/badge/Solidity-%5E0.8.x-black?logo=solidity)
![OpenZeppelin](https://img.shields.io/badge/OpenZeppelin-Security-blue)

---

## Introduction

Welcome to the **Solidity Contracts Monorepo**! This repository is a playground and showcase for all the Solidity smart contracts you will write, experiment with, and deploy. It features a variety of decentralized applications, including:

-  **ERC20 & Meme Coins**
- **NFT Marketplaces**
- **Decentralized Exchanges (DEX)**
- **Token Bridges**
- **Treasury & Lock Contracts**

Whether you're building DeFi, NFT, or cross-chain solutions, this repo is your all-in-one smart contract lab!

---

## 🗂️ Project Structure

```
solidity-contracts/      # (Empty or for future contracts)
Memcoin-marketplace/     # ERC20 MemeCoin, Marketplace, Treasury, Lock
Marketplace/             # NFT Marketplace & NFT contract
Dex/                     # Bonding Curve, DEX, LP Token
token-bridge/            # Bridge contracts, custom Token
```

---

## Subprojects & Contracts

### 1. **Memcoin-marketplace**
- **MemeCoin.sol**: Custom ERC20 meme token with mint/burn.
- **Marketplace.sol**: List, buy, and cancel ERC20 token sales with listing fees.
- **Treasury.sol**: Secure ETH/token withdrawals by owner.
- **Lock.sol**: Timelock contract for secure withdrawals after a set time.
- **Oracle.sol**: (Stub for future price feeds or data oracles)

### 2. **Marketplace**
- **Marketplace.sol**: List, buy, and cancel NFT sales (ERC721).
- **Nft.sol**: Custom ERC721 NFT contract with minting and metadata.

### 3. **Dex**
- **bondingcurve.sol**: Linear bonding curve for token pricing, lending, and borrowing.
- **DEX.sol**: Simple Uniswap-like DEX for swapping between two tokens and providing liquidity.
- **Mytoken.sol**: LP (Liquidity Provider) ERC20 token for DEX.
- **Mint.sol, Borrow.sol, Lend.sol**: (Stubs for future DeFi features)

### 4. **token-bridge**
- **BridgeEth.sol**: Mint/burn tokens for bridging between chains.
- **BridgeBase.sol**: Lock/unlock tokens for cross-chain transfers.
- **Token.sol**: Custom ERC20 token with mint/burn for bridge.

---

##  Getting Started

### Prerequisites
- [Node.js](https://nodejs.org/) (v16+ recommended)
- [Yarn](https://yarnpkg.com/) or [npm](https://www.npmjs.com/)
- [Hardhat](https://hardhat.org/) (for Solidity development)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)

### Installation
```bash
git clone https://github.com/yourusername/solidity-contracts-monorepo.git
cd solidity-contracts-monorepo
# Install dependencies for each subproject
cd Memcoin-marketplace && yarn install
cd ../Marketplace && yarn install
cd ../Dex && yarn install
cd ../token-bridge && yarn install
```

### Compile Contracts
```bash
# From each subproject directory
npx hardhat compile
```

### Run Tests
```bash
npx hardhat test
```

---

## Example Workflows

### Deploying MemeCoin
```bash
cd Memcoin-marketplace
npx hardhat run scripts/deploy.js --network <network>
```

### Listing an NFT for Sale
```solidity
// Call sellNft(price, nftContract, tokenId) on Marketplace contract
```

### Swapping Tokens on DEX
```solidity
// Call swapAForB(amount) or swapBForA(amount) on SimpleDEX contract
```

### Bridging Tokens
```solidity
// Call lock() on BridgeBase, then mintTokens() on BridgeEth
```

---

## Contributing

Pull requests, issues, and feature suggestions are welcome! Please:
- Fork the repo
- Create a new branch (`git checkout -b feature/your-feature`)
- Commit your changes
- Open a PR

---

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

> _Happy BUIDLing!_ 🚀 