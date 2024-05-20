<template>
  <div>
    <h1>Frutty Tutty</h1>
    <button v-if="!sessionCreated" @click="createSession">New Game</button>
    <div v-else>
      <button v-if="sessionState === 'new_game'" @click="startGame">Start</button>
      <div v-if="sessionState === 'in_progress'">
        <div>
          <span v-for="(item, index) in sequence" :key="index">{{ item }}</span>
        </div>
        <p>Reward: {{ reward }}</p>
        <p>Score: {{ score }}</p>
        <button @click="playGame">Play</button>
        <button @click="finishGame">Finish</button>
        <button @click="cashOutGame">Cash Out</button>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted } from 'vue'
import axios from 'axios'

export default defineComponent({
  setup() {
    const playerId = localStorage.getItem('playerId')
    const gameId = ref<number | null>(null)

    const sessionId = ref<number | null>(null)
    const sessionCreated = ref(false)
    const sessionState = ref<string>('')

    const sequence = ref<string[]>(["❓", "❓", "❓","❓"])
    const reward = ref<number>(0)
    const score = ref<number>(0)

    onMounted(async () => {
      try {
        const response = await axios.get('http://localhost:3000/api/v1/games')
        const game = response.data.find((game: { name: string }) => game.name === 'Frutty-Tutty')

        if (game) {
          gameId.value = game.id
        }
      } catch (error) {
        console.error(error)
      }
    })

    const createSession = async () => {
      try {
        const response = await axios.post('http://localhost:3000/api/v1/sessions', {
          session: {
            game_id: gameId.value,
            player_id: playerId
          }
        })

        const session = response.data

        sessionId.value = session.id
        sessionState.value = session.state
        sessionCreated.value = true
      } catch (error) {
        console.error(error)
      }
    }

    const startGame = async () => {
      try {
        const response = await axios.patch(`http://localhost:3000/api/v1/games/frutty_tutty/start`, {
          game: {
            session_id: sessionId.value,
          }
        })

        const session = response.data

        sessionState.value = session.state
      } catch (error) {
        console.error(error)
      }
    }

    const playGame = async () => {
      try {
        const response = await axios.patch('http://localhost:3000/api/v1/games/frutty_tutty/play', {
          game: {
            session_id: sessionId.value,
          }
        })

        sequence.value = response.data.sequence
        score.value = response.data.score
        reward.value = response.data.reward

        console.log(response.data)
      } catch (error) {
        console.error(error)
      }
    }

    const finishGame = async () => {
      try {
        await axios.patch('http://localhost:3000/api/v1/games/frutty_tutty/finish', {
          game: {
            session_id: sessionId.value,
          }
        })

        sessionState.value = 'finished'
      } catch (error) {
        console.error(error)
      }
    }

    const cashOutGame = async () => {
      try {
        await axios.patch('http://localhost:3000/api/v1/games/frutty_tutty/cashout', {
          game: {
            session_id: sessionId.value,
          }
        })

        sessionState.value = 'cashed_out'
      } catch (error) {
        console.error(error)
      }
    }

    return {
      sessionCreated,
      sessionState,
      sequence,
      score,
      reward,
      createSession,
      startGame,
      playGame,
      finishGame,
      cashOutGame
    }
  }
})
</script>

