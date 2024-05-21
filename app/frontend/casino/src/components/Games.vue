<template>
  <div>
    <h1>Games</h1>
    <ul>
      <li v-for="game in games" :key="game.id">
        <router-link :to="{ name: game.name }">{{ game.name }}</router-link>
      </li>
    </ul>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted } from 'vue'
import axios from 'axios'

export default defineComponent({
  setup() {
    const games = ref<Array<{ id: number; name: string; kind: string; credits: number }>>([])

    onMounted(async () => {
      try {
        const response = await axios.get('http://localhost:3000/api/v1/games')
        games.value = response.data
      } catch (error) {
        console.error(error)
      }
    })

    return {
      games
    }
  }
})
</script>
