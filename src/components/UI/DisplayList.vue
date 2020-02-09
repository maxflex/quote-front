<template>
  <div :class="{ invisible: items === undefined }">
    <div v-if="items !== undefined">
      <slot name="items" :items="items" v-if="items.length > 0"></slot>
      <NoData :no-elevation="noElevation" v-else />
    </div>
    <InfiniteLoading
      spinner="waveDots"
      @infinite="infiniteHandler"
      ref="InfiniteLoading"
    >
      <div slot="no-more"></div>
      <div slot="no-results"></div>
    </InfiniteLoading>
  </div>
</template>

<script>
import EVENT_TYPE from "@/other/event-types"
import InfiniteLoading from "vue-infinite-loading"

export default {
  props: {
    apiUrl: String,

    filters: {
      type: Object,
      required: false,
      default() {
        return {}
      },
    },

    // <NoData /> elevation
    noElevation: Boolean,
  },

  components: { InfiniteLoading },

  data() {
    return {
      items: undefined,
      page: 0,
    }
  },

  methods: {
    infiniteHandler($state) {
      this.page++

      const params = {
        paginate: 30,
        page: this.page,
        ...this.filters,
      }

      this.$http.get(this.apiUrl, { params }).then(({ data }) => {
        if ("meta" in data) {
          // Response with pagination
          this.items =
            this.page === 1 ? data.data : this.items.concat(data.data)
          if (data.current_page === data.last_page) {
            $state.complete()
          } else {
            $state.loaded()
          }
        } else {
          // Response without pagination
          this.items = data
          $state.complete()
        }
      })
    },

    refresh() {
      this.page = 0
      this.$refs.InfiniteLoading.stateChanger.reset()
    },

    // Handle list CRUD events from outside
    updated({ event, item }) {
      const index = this.items.findIndex(e => e.id === item.id)

      switch (event) {
        case EVENT_TYPE.updated: {
          this.items.splice(index, 1, item)
          break
        }

        case EVENT_TYPE.created: {
          this.items.splice(0, 0, item)
          break
        }

        case EVENT_TYPE.destroyed: {
          this.items.splice(index, 1)
          break
        }
      }
    },
  },
}
</script>
