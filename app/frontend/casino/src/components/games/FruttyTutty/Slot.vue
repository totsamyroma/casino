<template>
  <span>{{ currentChar }}</span>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted, watch } from 'vue'

export default defineComponent({
  props: {
    char: {
      type: String,
      required: true
    },
    animationChars: {
      type: Array as () => string[],
      required: true
    },
    delay: {
      type: Number,
      default: 2
    }
  },
  setup(props) {
    const currentChar = ref(props.char)

    const animate = () => {
      const animationChars = props.animationChars

      let index = 0
      const interval = setInterval(() => {
        if (index >= animationChars.length) {
          index = 0
        }
        currentChar.value = animationChars[index]
        index++
      }, 50) // Adjust the interval time as needed

      // Clear the interval after some time to stop the animation
      setTimeout(() => {
        clearInterval(interval)
        currentChar.value = props.char
      }, props.delay*1000) // Adjust the duration as needed
    }

    onMounted(() => {
      animate()
    })

    watch(() => [props.animationChars], () => {
      animate()
    })

    return {
      currentChar
    }
  }
})
</script>

