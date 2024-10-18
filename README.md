# DiamondNFT: A Modular and Upgradeable NFT Platform

## Introduction

DiamondNFT is an advanced Ethereum-based non-fungible token (NFT) platform that leverages the Diamond pattern, enabling flexible and upgradeable smart contracts. It combines the functionality of the ERC721 standard with a presale mechanism and a Merkle tree-based token distribution system.

## Key Features

- **Modular Design**: Utilizes the Diamond pattern to create a modular and extensible smart contract architecture.
- **ERC721 Compliance**: Fully adheres to the ERC721 standard for non-fungible tokens.
- **Presale Functionality**: Incorporates a presale mechanism with configurable pricing and purchase limits.
- **Merkle Distribution**: Implements an efficient and gas-optimized token distribution system based on Merkle trees.
- **Foundry Integration**: Includes Foundry tests for robust contract verification and deployment.

## Project Structure

```
DiamondNFT/
├── src/
│   ├── Diamond.sol
│   ├── facets/
│   │   ├── ERC721Facet.sol
│   │   ├── MerkleFacet.sol
│   │   └── PresaleFacet.sol
├── test/
│   └── DiamondNFT.t.sol
├── script/
│   └── DeployDiamondNFT.s.sol
├── lib/
├── merkle/
│   ├── generateMerkleTree.ts
├── foundry.toml
└── README.md
```

## Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation.html)
- [Node.js](https://nodejs.org/) (for Merkle tree generation)
- [Yarn](https://yarnpkg.com/) or [npm](https://www.npmjs.com/)

## Setup

1. Clone the repository:

   ```
   git clone hhttps://github.com/peternnadi1999/Diamond_NFT.git
   cd DiamondNFT
   ```

2. Install Foundry dependencies:

   ```
   forge install
   ```

3. Install Node.js dependencies:

   ```
   yarn install
   ```

   or

   ```
   npm install
   ```

4. Generate the Merkle tree:
   ```
   ts-node merkle/generateMerkleTree.ts
   ```

## Compilation

Compile the smart contracts using Foundry:

```
forge build
```

## Testing

Run the Foundry tests:

```
forge test
```

## Deployment

1. Set up your environment variables:

   ```
   cp .env.example .env
   ```

   Edit `.env` and add your private key and RPC URL.

2. Run the deployment script:
   ```
   forge script script/DeployDiamondNFT.s.sol:DeployDiamondNFT --rpc-url $RPC_URL --broadcast --verify -vvvv
   ```

## Usage

### Presale

Users can participate in the presale by calling the `buyPresale` function in the PresaleFacet. The presale price is set to 1 ETH for 30 NFTs, with a minimum purchase of 0.01 ETH.

### Merkle Distribution

Whitelisted users can claim their NFTs by providing a valid Merkle proof to the `claim` function in the MerkleFacet.

### ERC721 Functionality

Standard ERC721 functions are available through the ERC721Facet, allowing for token transfers, approvals, and balance checks.

## Upgradeability

The Diamond pattern allows for easy upgradeability. New facets can be added or existing ones can be replaced by updating the Diamond contract.

## Security Considerations

- Ensure that only authorized addresses can set the Merkle root and presale parameters.
- Carefully manage the whitelist for Merkle distribution.
- Consider implementing a multisig wallet for critical contract operations.

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your proposed changes.

## License

This project is licensed under the MIT License.

## Disclaimer

This project is provided as-is and should be thoroughly audited before any production use. The authors are not responsible for any losses incurred through the use of this software.

