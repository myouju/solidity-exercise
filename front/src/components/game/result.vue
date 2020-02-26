<template>
<div>
結果: {{ showResult }}
</div>
</template>

<script>
export default {
  name: 'result',
  props: [ 'isHost', 'result' ],
  computed: {
    showResult() {
      if (this.result == 0) return "中断"
      if (this.result == 3) return "引き分け"

      if (this.isHost && this.result == 1) return "勝ち"
      if (!this.isHost && this.result == 2) return "勝ち"
      else return "負け"
    },
  },
}
</script>
