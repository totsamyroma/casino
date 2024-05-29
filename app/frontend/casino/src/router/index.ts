import { createRouter, createWebHistory } from 'vue-router'

import CasinoView from '../views/CasinoView.vue'
import GamesView from '../views/GamesView.vue'
import FruttyTuttyView from '../views/games/FruttyTuttyView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'casino',
      component: CasinoView
    },
    {
      path: '/games',
      name: 'games',
      component: GamesView
    },
    {
      path: '/games/Frutty-Tutty',
      name: 'Frutty-Tutty',
      component: FruttyTuttyView
    }
  ]
})

export default router
