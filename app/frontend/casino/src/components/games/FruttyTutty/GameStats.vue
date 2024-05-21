<template>
    <p>Reward: {{ reward }}</p>
    <p>Score: {{ score }}</p>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted, watch } from 'vue'

export default defineComponent({
  props: {
    reward: {
      type: Number,
      defualt: 0
    },
    score: {
      type: Number,
      defualt: 0
    },
    delay: {
      type: Number,
      default: 6000
    }
  },
  setup(props) {
    const reward = ref(props.reward)
    const score = ref(props.score)

    const updateStats = () => {
      setTimeout(() => {
        reward.value = props.reward
        score.value = props.score
      }, props.delay) // Adjust the duration as needed
    }

    onMounted(() => {
      updateStats()
    })

    watch(() => [props.score], () => {
      updateStats()
    })

    return {
      reward,
      score
    }
  }
})
</script>

