<template>
  <v-card
    :class="noElevation ? 'no-pointer-events elevation-0' : 'elevation-5'"
    @click="$router.push({ name: 'AuthorShow', params: { id: item.id } })"
  >
    <v-card-text>
      <v-row>
        <v-col class="flex-grow-0">
          <Avatar :item="item" :size="100" />
        </v-col>
        <v-col>
          <div class="headline black--text">
            {{ item.nickname }}
          </div>
          <div class="subheader">
            {{ item.realname }}
          </div>
          <div class="d-flex mt-5">
            <div class="mr-4">
              <v-icon class="mr-1">chat</v-icon>
              <span>{{ item.quotes_count }}</span>
            </div>
            <div>
              <v-icon class="mr-1">favorite</v-icon>
              <span>{{ item.likes_count }}</span>
            </div>
          </div>
        </v-col>
      </v-row>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  props: {
    item: {
      type: Object,
      requried: true,
    },

    noElevation: Boolean,
  },

  methods: {},
}
</script>
