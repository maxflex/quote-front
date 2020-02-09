<template>
  <v-card class="quote">
    <v-card-text class="pb-0">
      <v-row>
        <v-col class="flex-grow-0">
          <router-link
            :to="{ name: 'AuthorShow', params: { id: item.author.id } }"
          >
            <Avatar :item="item.author" :size="100" />
          </router-link>
        </v-col>
        <v-col>
          <div class="headline black--text">
            <v-icon class="grey--text quote__bracket quote__bracket_opening">
              format_quote
            </v-icon>
            <span>
              {{ item.text }}
            </span>
            <v-icon class="grey--text quote__bracket quote__bracket_closing">
              format_quote
            </v-icon>
          </div>
          <div class="body-2 font-italic mt-2 grey--text">
            – {{ item.author.nickname }}
          </div>
        </v-col>
      </v-row>
    </v-card-text>
    <v-card-actions>
      <v-spacer></v-spacer>
      <div
        @click="like()"
        class="pointer d-flex align-center body-1 quote__like"
      >
        <v-icon
          color="accent"
          v-text="item.is_liked ? 'favorite' : 'favorite_border'"
        >
        </v-icon>
        <v-number
          class="accent--text font-weight-medium"
          v-model="item.likes_count"
        ></v-number>
      </div>
    </v-card-actions>
    <!-- <div class="quote__controls">
    </div> -->
  </v-card>
</template>

<script>
import { VNumber } from "@maxflex/v-number"
import { API_QUOTES } from "@/api"

export default {
  props: {
    item: {
      type: Object,
      requried: true,
    },
  },

  components: { VNumber },

  methods: {
    like() {
      this.$http.get([API_QUOTES, "like", this.item.id].join("/"))
      if (this.item.is_liked) {
        this.item.likes_count--
      } else {
        this.item.likes_count++
      }
      this.item.is_liked = !this.item.is_liked
    },
  },
}
</script>

<style lang="scss">
.quote {
  &__bracket {
    width: 10px;
    font-size: 18px !important;
    &_opening {
      top: 7px;
    }
    &_closing {
      top: -7px;
    }
  }
  &__controls {
    position: absolute;
    right: 16px;
    bottom: 16px;
  }

  &__like {
    & .v-icon {
      font-size: 30px;
      margin-right: 6px;
    }
  }
}
</style>
