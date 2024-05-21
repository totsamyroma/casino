<template>
  <div>
    <h1>Frutty Tutty</h1>
    <div v-if="sessionState === 'in_progress'">
      <div>
        <Slot
        v-for="(item, index) in sequence"
        :key="index"
        :char="item"
        :animationChars="getShuffledAnimationChars()"
        :delay='(index + 1)'
        />
      </div>
      <div>
        <GameStats
        :reward="reward"
        :score="score"
        :delay='sequence.length * 1000'
        />
      </div>
    </div>
    <Controls
    :sessionCreated="sessionCreated"
    :sessionState="sessionState"
    @newGame="createSession"
    @startGame="startGame"
    @playGame="playGame"
    @finishGame="finishGame"
    @cashOutGame="cashOutGame"
    />
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted } from 'vue'
import axios from 'axios'
import Controls from './FruttyTutty/Controls.vue'
import GameStats from './FruttyTutty/GameStats.vue'
import Slot from './FruttyTutty/Slot.vue'

export default defineComponent({
  components: {
    Controls,
    GameStats,
    Slot
  },
  setup() {
    const playerId = localStorage.getItem('playerId')
    const gameId = ref<number | null>(null)

    const sessionId = ref<number | null>(null)
    const sessionCreated = ref(false)
    const sessionState = ref<string>('')

    const sequence = ref<string[]>(['❓', '❓', '❓'])
    const reward = ref<number>(0)
    const score = ref<number>(0)

    // TODO: Ideally get a sequence of characters from the server
    const animationChars = ref<string[]>(['🍒', '🍋', '🍊', '🍉'])

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

    const shuffleArray = (array: string[]) => {
      const copy = [...array]
      for (let i = copy.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1))
        const temp = copy[i]
        copy[i] = copy[j]
        copy[j] = temp
      }
      return copy
    }

    const getShuffledAnimationChars = () => {
      return shuffleArray(animationChars.value)
    }

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
        score.value = session.score
      } catch (error) {
        console.error(error)
      }
    }

    const startGame = async () => {
      try {
        const response = await axios.patch(
          `http://localhost:3000/api/v1/games/frutty_tutty/start`,
          {
            game: {
              session_id: sessionId.value
            }
          }
        )

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
            session_id: sessionId.value
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
            session_id: sessionId.value
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
            session_id: sessionId.value
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
      animationChars,
      createSession,
      startGame,
      playGame,
      finishGame,
      cashOutGame,
      getShuffledAnimationChars
    }
  }
})
</script>

