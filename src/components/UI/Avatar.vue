<template>
  <v-avatar
    color="primary"
    :size="size"
    v-if="photoSrc === null && icon !== undefined"
  >
    <v-icon dark :size="size * 0.7" v-text="icon"></v-icon>
  </v-avatar>
  <NameAvatar v-else :size="size" :src="photoSrc" :username="item.realname" />
</template>

<script>
import NameAvatar from "vue-avatar"

export default {
  props: {
    item: {
      type: Object,
      required: true,
    },
    size: {
      type: Number,
      default: 56,
    },
    icon: {
      type: String,
    },
  },

  components: { NameAvatar },

  computed: {
    photoSrc() {
      return this.item.photo === null ? null : this.item.photo.url
    },
  },
}
</script>
