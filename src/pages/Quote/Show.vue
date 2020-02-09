<template>
  <div>
    <Item v-if="item !== undefined" :item="item" />
  </div>
</template>

<script>
import { API_QUOTES as API_URL } from "@/api"
import ShowMixin from "@/mixins/Show"
import { Item } from "@/components/Quote"
import { mapGetters } from "vuex"

export default {
  mixins: [ShowMixin],

  components: { Item },

  data() {
    return {
      API_URL,
    }
  },

  computed: mapGetters("auth", ["isLoggedIn"]),
}
</script>
