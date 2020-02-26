<template>
<div>
  <h3>選択してください</h3>
  <ul>
    <li><button v-on:click="hostChoice(1)">👊</button></li>
    <li><button v-on:click="hostChoice(2)">✌</button></li>
    <li><button v-on:click="hostChoice(3)">✋</button></li>
  </ul>
</div>
</template>

<script>
import Web3 from 'web3'

export default {
  name: 'hostChoice',
  computed: {
    id() {
      return parseInt(this.$route.params.id, 10)
    },
    me() {
      return this.$store.getters.user_account
    },
    contract() {
      return this.$store.getters.contract
    },
  },
  methods: {
    hostChoice: async function(choice) {
      const web3 = new Web3()
      const secret = Math.random().toString(32).substring(2)
      const commitHash = web3.utils.keccak256(choice.toString() + secret)
      const res = await this.contract.methods.hostChoice(this.id, commitHash).send( {from: this.me, gas: 300000 })
      console.dir(res)
      const game = {
        id: this.id,
        choice,
        secret,
        commitHash,
      }
      console.dir(game)
      this.$store.commit('games', game)
      this.$emit('load')
    },
  },
}
</script>
