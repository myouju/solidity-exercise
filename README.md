# ether じゃんけん
## requirement
- Ganache
- Truffle
- jq (nice to have)

## run
1. Run Ganache
  1.1. create new workspace
  1.2. load truffle-config.js
2. compile contracts
  2.1. `truffle compile`
3. migrate contracts
  3.1. `truffle migrate`
4. `$ cd front`
5. edit contract address and abi
  5.1. edit address `$ vi .env`
  5.2. edit abi `$ cat ../build/contracts/GameManager.json|jq .abi > src/abi.json`
6. `$ npm install`
7. run `$ npm run serve`
8. open http://127.0.0.1:8000
