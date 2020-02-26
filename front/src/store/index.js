import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from "vuex-persistedstate"

Vue.use(Vuex)

const store = new Vuex.Store({
  plugins: [createPersistedState()],
  state: {
    contract: null,
    user_account: null,
    games: [],
  },
  getters: {
    contract: state => state.contract,
    user_account: state => state.user_account,
    games: state => state.games,
  },
  mutations: {
    contract: (state, c) => {
      state.contract = c
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
