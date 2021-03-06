## Project Overview :page_facing_up:
[![Build Integration](https://github.com/PlasmNetwork/ZKRollups/actions/workflows/evm.yml/badge.svg)](https://github.com/PlasmNetwork/ZKRollups/actions/workflows/evm.yml)[![Fast Integration](https://github.com/PlasmNetwork/ZKRollups/actions/workflows/test.yml/badge.svg)](https://github.com/PlasmNetwork/ZKRollups/actions/workflows/test.yml)  
We believe that ZK Rollup is the killer layer2 solution in the coming months and some of the top projects will use this technology to make DApps scalable.

ZK Rollup is valuable for Polkadot Parachain as described below.
1. Bringing vertical off-chain scalability without sacrificing on-chain data availability, security and privacy (×3-10 scalability).
1. Handling smart contracts on layer2.
1. Sharding plus Rollups will be the future. Polkadot has the sharding ish architecture but it doesn't have Rollups yet.
1. Some of the great Ethereum projects have already started using Rollups. If we could build Rollups on Substeate/Polkadot, we would help them build applications on Polkdot Parachain like Plasm Network.

## Milestone1
Our milestone1 is to deploy [matter-labs](https://github.com/matter-labs/zksync) solidity contracts and test them on a substrate-based chain.

| Number | Deliverable | Specification |
| ------------- | ------------- | ------------- |
| 1. | Deploy ZK Rollup Contract on Substrate | Deploy [matter-labs](https://github.com/matter-labs/zksync) solidity contracts on substrate evm |  
| 2. | Integration Test on Substrate | Test for all contracts and sidechain network actors |  
| 3. | Documentation | Document which describes how to test ZK Rollup on substrate |

### Integration Test on Substrate

- Premise

| Software | Version |
| ------------- | ------------- |  
| docker-compose | 1.27.4 |  
| docker | 19.03.13 |  
| git | 2.24.1 |  
| yarn | 1.21.1 |  
| git | 14.15.4 |

And there is private key file `$HOME/.ssh/id_rsa`.

- Test  

Execute following command in this project root directory.
```
$ sh scripts/integration.sh
```
This script executes the following sequence.

1. Build Zk Rollup contracts  
https://github.com/PlasmNetwork/ZKRollups/blob/master/scripts/integration.sh#L3
2. Build operator and prover containers  
https://github.com/PlasmNetwork/ZKRollups/blob/master/scripts/build.sh#L30
3. Run substrate-based chain, operator, and prover, database containers  
https://github.com/PlasmNetwork/ZKRollups/blob/master/scripts/integration.sh#L28
4. Run integration test container  
https://github.com/PlasmNetwork/ZKRollups/blob/master/scripts/integration.sh#L29

The integration container executes following tests.  
https://github.com/PlasmNetwork/ZKRollups/blob/master/test/Dockerfile#L24

- yarn setup

The `$ yarn setup` command executes `test/src/setup-contract.ts` and `test/src/setup-wallet.ts`.  
The `test/src/setup-contract.ts` deploys all Zk Rollup contracts to the substrate-based chain(substrate) and the `test/src/setup-wallet.ts` funds some token to the tester wallet.

- yarn integration

This `$ yarn integration` executes [`zksync integration test`](https://github.com/ArtreeTechnologies/zksync/blob/master/core/tests/ts-tests/tests/main.test.ts).  
The `zksync integration test` tests depositing ETH, changing public key, transfering ETH, and collecting transaction fee, exiting ETH.

