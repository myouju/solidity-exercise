import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

Vue.config.productionTip = true

new Vue({
  el: '#app',
  router,
  render: h => h(App),
  store,
})

