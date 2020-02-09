<template>
  <div class="loader">
    <v-progress-circular
      :color="color"
      indeterminate
      :size="size"
    ></v-progress-circular>
  </div>
</template>

<script>
export default {
  props: {
    size: {
      type: Number,
      default: 48,
    },
    color: {
      type: String,
      default: "accent",
    },
  },
}
</script>

<style lang="scss" scoped>
.loader {
  position: absolute;
  width: 100%;
  height: 100%;
  left: 0;
  top: 0;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
