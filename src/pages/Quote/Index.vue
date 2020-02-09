<template>
  <div>
    <v-row>
      <v-col>
        <v-menu>
          <template v-slot:activator="{ on }">
            <v-btn v-on="on" text>
              <v-icon>swap_vert</v-icon>
              {{ selectedOrder.label }}
            </v-btn>
          </template>
          <v-list>
            <v-list-item
              v-for="order in orders"
              @click="selectedOrder = order"
              :key="order.value"
            >
              {{ order.label }}
            </v-list-item>
          </v-list>
        </v-menu>
      </v-col>
    </v-row>
    <DisplayList
      ref="DisplayList"
      :api-url="API_QUOTES"
      :filters="{
        ...filters,
        order: selectedOrder.value,
      }"
    >
      <template v-slot:items="{ items }">
        <Item
          v-for="item in items"
          :key="item.id"
          :item="item"
          class="mb-6 elevation-5"
        />
      </template>
    </DisplayList>
  </div>
</template>

<script>
import Item from "@/components/Quote/Item"
import { API_QUOTES } from "@/api"

export default {
  props: {
    filters: {
      type: Object,
      default() {
        return {}
      },
    },
  },

  components: { Item },

  data() {
    const orders = [
      { value: "new", label: "новые" },
      { value: "popular", label: "популярные" },
    ]
    return {
      API_QUOTES,
      orders,
      selectedOrder: orders[0],
    }
  },

  watch: {
    selectedOrder() {
      this.$refs.DisplayList.refresh()
    },
  },
}
</script>
