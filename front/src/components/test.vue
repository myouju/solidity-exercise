<template>
  <div>{{ address }}</div>
</template>

<script>
export default {
  name: "test",
  computed: {
    address() {
      return this.$store.getters.user_account
    },
  },
  mounted: async function() {
    const contract = this.$store.getters.contract
    const games = await contract.methods.getGames().call()
    //const games = await contract.methods.createGame().send( {from: this.$store.getters.user_account, gas: 300000})
    console.dir(games)
  },
}
</script>
