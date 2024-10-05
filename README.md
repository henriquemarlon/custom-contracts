<div align="center">
    <img src="https://github.com/Mugen-Builders/.github/assets/153661799/7ed08d4c-89f4-4bde-a635-0b332affbd5d" width="150" height="150">
</div>
<br>
<div align="center">
    <i>A collection of smart contracts for interacting with the Cartesi Rollupś.</i>
</div>
<div align="center">
This repository aims to have assets and extensions that can interact with Cartesi Rollups.
</div>
<br>
<div align="center">
    
  <a href="">[![Static Badge](https://img.shields.io/badge/cartesi--rollups-1.0.0-5bd1d7)](https://docs.cartesi.io/cartesi-rollups/)</a>
  <a href="">[![Static Badge](https://img.shields.io/badge/foundry-0.2.0-red)](https://book.getfoundry.sh/getting-started/installation)</a>
</div>

## 3. How to run:

To deploy these contracts on other networks not yet supported or on a localhost network, follow the commands below.

#### Generate the `.env` file and install the project dependencies contained in the `.gitmodules` file:

```bash
make setup
```

#### Execute the tests:
```bash
make test
```

> [!IMPORTANT]
> Before running the command below, confirm that the `.env` file contains all the necessary variables for deployment. For deploying on a local network, add the following values to the variables:

```env
RPC_URL="http://localhost:8545"
NETWORK="localhost"
PRIVATE_KEY="0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80" // You can use any private key from the local environment here.
TESTNET_BLOCKSCAN_API_KEY=""
```

#### Deploy the contracts:
```bash
make deploy
```

#### Check the new state of contracts after the voucher executions:
```bash
make new_state
```
