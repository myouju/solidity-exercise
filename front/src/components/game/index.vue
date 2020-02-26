<template>
<div>
  <button v-on:click="load">更新</button>
  <Detail v-bind="item" />
  <div v-if="isMine && isHostChoice">
    <HostChoice @load="load"/>
  </div>
  <div v-else-if="!isMine && isGuestChoice">
    <GuestChoice :deposit="deposit" @load="load" />
  </div>
  <div v-else-if="isMine && isHostReveal">
    <HostReveal @load="load" />
  </div>
  <div v-else-if="isEnd">
    <Result :isHost="isMine" :result="result" />
  </div>

  <div v-if="canRefund">
    <Refund @load="load"/>
  </div>
</div>
</template>

<script>
import Detail from './detail'
import HostChoice from './hostChoice'
import GuestChoice from './guestChoice'
import HostReveal from './reveal'
import Result from './result'
import Refund from './refund'

export default {
  name: 'game',
  components: { 
    Detail,
    HostChoice,
    GuestChoice,
    HostReveal,
    Result,
    Refund,
  },
  data: () => {
    return {
      i: { status: -1, result: -1, deposit: '0', },
      isMine: false,
    }
  },
  computed: {
    id() {
      return parseInt(this.$route.params.id, 10)
    },
    contract() {
      return this.$store.getters.contract
    },
    item() {
      return this.i
    },
    isHostChoice() {
      return this.i.status == 1
    },
    isGuestChoice() {
      return this.i.status == 2
    },
    isHostReveal() {
      return this.i.status == 3
    },
    isEnd() {
      return this.i.status == 5
    },
    expired() {
      return Date.now() > new Date(this.i.availableRefundTime * 1000)
    },
    canRefund() {
      if (!this.expired) return false

      if (this.isMine && this.item.status == 2) return true
      if (!this.isMine && this.item.status == 3) return true

      return false
    },
    deposit() {
      return this.i.deposit
    },
    result() {
      return this.i.result
    },
  },
  mounted: async function() {
    this.i = await this.contract.methods.games(this.id).call()
    this.isMine = this.i.owner === this.$store.getters.user_account
  },
  methods: {
    load: async function() {
      console.log("child call")
      this.i = await this.contract.methods.games(this.id).call()
    },
  },
}
</script>
