<template>
<div>
  <div v-if="game">
    <div>作成しました</div>
    <div>{{ game }}</div>
    <router-link to="/list">戻る</router-link>
  </div>
  <div v-else>
    <h2>deposit(ether)を入力してください</h2>
    <input v-model="deposit" />
    <button v-on:click="createGame">create</button>
  </div>
</div>
</template>

<script>
import Web3 from 'web3'

export default {
  name: 'createGame',
  data: () => {
    return {
      deposit: 0,
      g: null,
    }
  },
  computed: {
    game() {
      return this.g
    },
  },
  methods: {
    createGame: async function() {
      const contract = this.$store.getters.contract
      const deposit = new Web3().utils.toWei(this.deposit, "ether")
      this.g = await contract.methods.createGame().send( { from: this.$store.getters.user_account, value: deposit, gas: 300000 })
    },
  },
}
</script>
