<template>
  <div>
    <router-view></router-view>
  </div>
</template>

<script>
import Web3 from 'web3'
import abi from './abi.json'

export default {
  name: "app",
  mounted: async function() {
    const web3 = new Web3(process.env.VUE_APP_WEB3_HOST)

    const address = process.env.VUE_APP_SOLIDITY_ADDRESS
    console.log(address)
    const contract = new web3.eth.Contract(abi, address)
    this.$store.commit("contract", contract)
  },
}
</script>
