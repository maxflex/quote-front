---
to: src/pages/<%= Name %>/Index.vue
---
<template>
  <div>
    <v-row class="mb-4">
      <v-col align="end">
        <AddBtn @click.native="$refs.Dialog.open(null)" />
      </v-col>
    </v-row>
    <DisplayList ref="DisplayList" :api-url="API_URL">
      <template v-slot:items="{ items }">
        <List :items="items" />
      </template>
    </DisplayList>
    <Dialog
      ref="Dialog"
      @updated="payload => $refs.DisplayList.updated(payload)"
    />
  </div>
</template>

<script>
import { Dialog, List, API_URL } from "@/components/<%= Name %>"

export default {
  components: { Dialog, List },

  data() {
    return {
      API_URL
    }
  }
}
</script>
