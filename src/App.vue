<template>
  <div id="app">
    <Layout />
  </div>
</template>

<script>
import Layout from "@/layouts/Layout"

export default {
  components: { Layout },

  created() {
    this.$store.dispatch("auth/getLoggedUser")
  },
}
</script>
