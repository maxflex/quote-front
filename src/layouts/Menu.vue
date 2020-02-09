<template>
  <div class="header-menu hidden-sm-and-down">
    <v-tabs
      background-color="transparent"
      centered
      icons-and-text
      fixed-tabs
      optional
    >
      <v-tab v-for="item in menu" :key="item.link" :to="{ name: item.link }">
        {{ item.title }}
        <v-icon v-text="item.icon"></v-icon>
      </v-tab>
    </v-tabs>
  </div>
</template>

<script>
import { mapGetters } from "vuex"

export default {
  data() {
    return {}
  },

  computed: {
    ...mapGetters("auth", ["isLoggedIn"]),
    menu() {
      return [
        {
          link: "QuoteIndex",
          icon: "chat",
          title: "Цитаты",
        },
        {
          link: "AuthorIndex",
          icon: "person",
          title: "Авторы",
        },
        {
          link: "AddQuote",
          icon: "add",
          title: "Добавить",
        },
      ]
    },
  },
}
</script>

<style lang="scss">
.header-menu {
  height: 100%;
  & > div {
    height: 100%;
    & > div {
      height: 100% !important;
    }
  }

  & .v-tabs-slider-wrapper {
    height: 4px !important;
  }
}
</style>
