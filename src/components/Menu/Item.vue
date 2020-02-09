<template>
  <v-divider v-if="Object.keys(item).length === 0" class="pb-1"></v-divider>
  <v-list-item v-else link :to="{ name: item.link }">
    <v-list-item-icon>
      <v-icon>{{ item.icon }}</v-icon>
    </v-list-item-icon>
    <v-list-item-content>
      <v-list-item-title>{{ item.title }}</v-list-item-title>
    </v-list-item-content>
  </v-list-item>
</template>

<script>
export default {
  props: {
    item: Object,
  },
}
</script>
