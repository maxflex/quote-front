<template>
  <div>
    <DisplayList ref="DisplayList" :api-url="API_AUTHORS">
      <template v-slot:items="{ items }">
        <Item
          v-for="item in items"
          :key="item.id"
          :item="item"
          class="mb-7 elevation-5"
        />
      </template>
    </DisplayList>
  </div>
</template>

<script>
import Item from "@/components/Author/Item"
import { API_AUTHORS } from "@/api"

export default {
  components: { Item },

  data() {
    return {
      API_AUTHORS,
    }
  },
}
</script>
