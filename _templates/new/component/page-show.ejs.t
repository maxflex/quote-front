---
to: src/pages/<%= Name %>/Show.vue
---
<template>
  <div v-if="item !== undefined">
    <v-card>
      <v-card-text>
        <div>
          <%= h.changeCase.title(title) %>
        </div>
        <div class="headline black--text">
          {{ item.name }}
        </div>
      </v-card-text>
      <v-btn
        color="black"
        icon
        class="btn-more"
        @click="$refs.Dialog.open(item.id)"
      >
        <v-icon>more_horiz</v-icon>
      </v-btn>
    </v-card>

    <v-tabs
      class="mt-5 mb-3"
      background-color="transparent"
      color="secondary"
      v-model="tab"
      centered
      icons-and-text
    >
      <v-tabs-slider></v-tabs-slider>
      <v-tab v-for="(tab, index) in tabs" :key="index">
        {{ tab.title }}
        <v-icon>{{ tab.icon }}</v-icon>
      </v-tab>
    </v-tabs>

    <v-card>
      <v-card-text>
        here
      </v-card-text>
    </v-card>

    <Dialog ref="Dialog" @updated="updated" />
  </div>
</template>

<script>
import { API_URL, Dialog } from "@/components/<%= Name %>"
import ShowMixin from "@/mixins/Show"

export default {
  mixins: [ ShowMixin ],

  components: { Dialog },

  data() {
    return {
      API_URL,
      item: undefined,
      tabs: [
        {
          title: "Клиенты",
          icon: "people"
        },
      ],
      tab: undefined
    }
  },
}
</script>
