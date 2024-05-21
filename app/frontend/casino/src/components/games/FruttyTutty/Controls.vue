<template>
  <div>
    <button v-if="!sessionCreated" @click="newGame">New Game</button>
    <button v-if="sessionState === 'new_game'" @click="startGame">Start</button>
    <div v-if="sessionState === 'in_progress'">
      <button @click="playGame" :disabled="disabledPlay">Play</button>
      <button @click="finishGame">Finish</button>
      <button @click="cashOutGame">Cash Out</button>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, PropType, onMounted } from 'vue'

export default defineComponent({
  props: {
    sessionCreated: {
      type: Boolean as PropType<boolean>,
      required: true,
      default: false
    },
    sessionState: {
      type: String as PropType<string>,
      required: true
    }
  },
  setup(_, { emit }) {
    const disabledPlay = ref(true)

    const newGame = () => {
      emit('newGame')
    }

    const startGame = () => {
      emit('startGame')
    }

    const playGame = () => {
      emit('playGame')

      disabledPlay.value = true

      setTimeout(() => {
        disabledPlay.value = false
      }, 3000 );
    }

    const finishGame = () => {
      emit('finishGame')
    }

    const cashOutGame = () => {
      emit('cashOutGame')
    }

    onMounted(() => {
      setTimeout(() => {
        disabledPlay.value = false
      }, 6000 );
    })

    return {
      disabledPlay,
      newGame,
      startGame,
      playGame,
      finishGame,
      cashOutGame
    }
  }
})
</script>

