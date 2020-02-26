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

export default {
  name: 'guestChoice',
  props: ['deposit'],
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
      const res = await this.contract.methods.guestChoice(this.id, choice).send( {from: this.me, value: this.deposit, gas: 300000 })
      console.dir(res)
      this.$emit('load')
    },
  },
}
</script>
