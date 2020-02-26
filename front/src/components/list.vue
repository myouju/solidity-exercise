<template>
<div>
<ul>
  <li v-for="(list, key) in lists" :key="key">
    <router-link :to="'/game/'+key">
      <div>id: {{ key }}</div>
      <div>掛け金: {{ ether(list.deposit) }} ether</div>
    </router-link>
  </li>
</ul>
</div>
</template>

<script>
import Web3 from 'web3'

export default {
  name: 'list',
  data: () => {
    return {
      l: [],
    }
  },
  computed: {
    lists() {
      return this.l
    },
  },
  methods: {
    ether: (wei) => {
      return new Web3().utils.fromWei(wei)
    },
  },
  mounted: async function() {
    const contract = this.$store.getters.contract
    this.l = await contract.methods.getGames().call()
  },
}
</script>
