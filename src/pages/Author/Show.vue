<template>
  <div>
    <Item v-if="item !== undefined" :item="item" no-elevation />
    <div class="text-right">
      <v-btn
        v-if="isLoggedIn"
        :to="{ name: 'AuthorEdit', params: { id: $route.params.id } }"
        color="accent"
        text
      >
        редактировать
      </v-btn>
    </div>
    <v-divider class="my-5"></v-divider>
    <PageQuoteIndex :filters="{ author_id: $route.params.id }" />
  </div>
</template>

<script>
import { API_AUTHORS as API_URL } from "@/api"
import ShowMixin from "@/mixins/Show"
import { Item } from "@/components/Author"
import PageQuoteIndex from "@/pages/Quote/Index"
import { mapGetters } from "vuex"

export default {
  mixins: [ShowMixin],

  components: { Item, PageQuoteIndex },

  data() {
    return {
      API_URL,
    }
  },

  computed: mapGetters("auth", ["isLoggedIn"]),
}
</script>
