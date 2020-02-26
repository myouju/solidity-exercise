<template>
<div>
  <button v-on:click="reveal">reveal</button>
</div>
</template>

<script>
export default {
  computed: { // TODO use props
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
    reveal: async function() {
      const game = this.$store.getters.games[this.id]
      console.dir(game)

      const res = await this.contract.methods.decision(this.id, game.choice, game.secret, game.commitHash).send( { from: this.me, gas: 300000 })
      console.dir(res)
      this.$emit('load')
    },
  },
}
</script>
