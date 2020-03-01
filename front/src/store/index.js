import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from "vuex-persistedstate"

Vue.use(Vuex)

let contract

const store = new Vuex.Store({
  plugins: [createPersistedState()],
  state: {
    user_account: null,
    games: {},
  },
  getters: {
    contract: () => contract,
    user_account: state => state.user_account,
    games: state => state.games,
  },
  mutations: {
    contract: (state, c) => {
      contract = c
    },
    user_account: (state, a) => {
      state.user_account = a
    },
    games: (state, g) => {
      console.dir(g)
      Vue.set(state.games, g.id, g)
    },
  },
})

export default store
