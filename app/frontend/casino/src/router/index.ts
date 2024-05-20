import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

import CasinoView from '../views/CasinoView.vue'
import GamesView from '../views/GamesView.vue'
import FruttyTuttyView from '../views/games/FruttyTuttyView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/AboutView.vue')
    },
    {
      path: '/casino',
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
