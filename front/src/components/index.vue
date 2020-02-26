<template>
<div>
  <div v-if="userAddress">
    <h2>じゃんけん</h2>
    <div>user address: {{ userAddress }}</div>
    <ul>
      <li v-for="(link, key) in links" :key="key">
        <router-link :to="link.to">{{ link.name }}</router-link>
      </li>
    </ul>
  </div>
  <div v-else>
    <h2>login</h2>
    <div>アドレスを入力してください</div>
    <input v-model="addr" placeholder="input address">
    <button v-on:click="register">ok</button>
  </div>
</div>
</template>

<script>
export default {
  name: "index",
  data: () => {
    return {
      addr: "",
    }
  },
  methods: {
    register: function() {
      this.$store.commit("user_account", this.addr)
    },
  },
  computed: {
    userAddress() {
      return this.$store.getters.user_account
    },
    links() {
      return [
        { to: '/list', name: 'ゲーム一覧', },
        { to: '/create', name: 'ゲーム作成', },
        { to: '/withdraw', name: '勝利金引き出し',},
      ]
    },
  },
}
</script>
