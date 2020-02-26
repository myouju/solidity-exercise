<template>
<div>
  <button v-on:click="refund">refund</button>
</div>
</template>

<script>
export default {
  name: 'refund',
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
    refund: async function() {
      const res = await this.contract.methods.refund(this.id).send( { from: this.me, gas: 300000 })
      console.dir(res)
      this.$emit('load')
    },
  },
}
</script>
