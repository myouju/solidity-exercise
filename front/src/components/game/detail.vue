<template>
<dl>
  <dt>owner address</dt>
  <dd>{{ owner }}</dd>

  <dt>guest address</dt>
  <dd>{{ guest }}</dd>

  <dt>ownerの選択</dt>
  <dd>{{ hChoice }}</dd>

  <dt>guestの選択</dt>
  <dd>{{ gChoice }}</dd>

  <dt>deposit</dt>
  <dd>{{ ether }} ether</dd>

  <dt>有効時間</dt>
  <dd>{{ availableTime }}</dd>

  <dt>status</dt>
  <dd>{{ readableStatus }}</dd>
</dl>
</template>

<script>
import Web3 from 'web3'

export default {
  name: 'gameDetail',
  props: [
    '0','1','2','3','4','5','6','7','8','9',
    'owner',
    'guest',
    'secret',
    'commit',
    'hostChoice',
    'guestChoice',
    'deposit',
    'availableRefundTime',
    'status',
    'result',
  ],
  computed: {
    hChoice() {
        return this.choice(this.hostChoice)
    },
    gChoice() {
        return this.choice(this.guestChoice)
    },
    ether() {
        return new Web3().utils.fromWei(this.deposit)        
    },
    availableTime() {
        return new Date(this.availableRefundTime * 1000)
    },
    readableStatus() {
        switch(this.status) {
            case '1': return 'owner選択中'
            case '2': return 'guest選択中'
            case '3': return 'owner reveal中'
            case '5': return 'ゲーム終了'
        }
        return '不明'
    }
  },
  methods: {
    choice: (c) => {
        switch(c) {
            case '1': return '👊'
            case '2': return '✌'
            case '3': return '✋'
        }
        return '不明'
    },
  },
}
</script>
