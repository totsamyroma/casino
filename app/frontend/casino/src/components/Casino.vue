<template>
  <div>
    <h1>Enter Your Name</h1>
    <form @submit.prevent="submitName">
      <input v-model="name" placeholder="Enter your name" required />
      <button type="submit">Submit</button>
    </form>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router'

export default defineComponent({
  setup() {
    const name = ref('')
    const router = useRouter()

    const submitName = async () => {
      try {
        const response = await axios.post('http://localhost:3000/api/v1/players', {
          player: { nick: name.value }
        })
        const playerId = response.data.id
        localStorage.setItem('playerId', playerId)
        router.push('/games')
      } catch (error) {
        console.error(error)
      }
    }

    return {
      name,
      submitName
    }
  }
})
</script>
