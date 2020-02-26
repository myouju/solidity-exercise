<template>
<div>
  <button v-if="!done" v-on:click="withdraw">withdraw</button>
  <div v-else>
    <div>完了しました</div>
    <router-link to="/">戻る</router-link>
  </div>
</div>
</template>

<script>
export default {
  data: () => {
    return {
      done: false,
    }
  },
  computed: { // TODO use props
    me() {
      return this.$store.getters.user_account
    },
    contract() {
      return this.$store.getters.contract
    },
  },
  methods: {
    withdraw: async function() {
      const res = await this.contract.methods.withdraw().send( { from: this.me, })
      console.dir(res)
      this.done = true
    },
  },
}
</script>
