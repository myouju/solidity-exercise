import Vue from 'vue'
import Router from 'vue-router'

import HelloWorld from '@/components/HelloWorld'
import index from '@/components/index'
import Test from '@/components/test'
import CreateGame from '@/components/create'
import ListGame from '@/components/list'
import Game from '@/components/game/index.vue'
import Withdraw from '@/components/withdraw'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: index,
    },
    {
      path: '/hello',
      component: HelloWorld,
    },
    {
      path: '/test',
      component: Test,
    },
    {
      path: '/create',
      component: CreateGame,
    },
    {
      path: '/game/:id',
      component: Game,
    },
    {
      path: '/list',
      component: ListGame,
    },
    {
      path: '/withdraw',
      component: Withdraw,
    },
  ]
})
