---
to: src/components/<%= Name %>/List.vue
---
<template>
  <div>
    <v-simple-table class="elevation-5" v-if="items !== undefined">
      <tbody>
        <tr v-for="item in items" :key="item.id">
          <td>
            <router-link :to="{ name: '<%= Name %>Show', params: { id: item.id } }">
              {{ item.name }}
            </router-link>
          </td>
        </tr>
      </tbody>
    </v-simple-table>
  </div>
</template>

<script>
export default {
  props: {
    items: {
      type: Array,
      required: true
    }
  }
}
</script>
