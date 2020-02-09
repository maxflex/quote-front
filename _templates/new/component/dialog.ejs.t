---
to: src/components/<%= Name %>/Dialog.vue
---
<template>
  <v-dialog
    v-model="dialog"
    fullscreen
    hide-overlay
    transition="dialog-bottom-transition"
  >
    <v-card tile>
      <v-toolbar dark color="primary">
        <v-toolbar-title>
          <span v-if="editMode">
            <%= h.changeCase.title(title) %>
          </span>
          <span v-else>
            Новый <%= h.changeCase.lower(title) %>
          </span>
        </v-toolbar-title>
        <v-spacer></v-spacer>
        <v-toolbar-items>
          <v-btn :loading="saving" @click="storeOrUpdate" dark text>
            Сохранить
          </v-btn>
        </v-toolbar-items>
        <div>
          <v-btn @click="dialog = false" icon>
            <v-icon>close</v-icon>
          </v-btn>
        </div>
      </v-toolbar>
      <v-card-text class="mt-5" v-if="item !== null">
        <div class="input-rows">
          <v-row>
            <v-col cols="12">
              <v-text-field v-model="item.name" label="Название" />
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12"></v-col>
          </v-row>
        </div>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
import DialogMixin from "@/mixins/Dialog"
import { API_URL, MODEL_DEFAULTS } from "./"

export default {
  mixins: [DialogMixin],

  data() {
    return {
      API_URL,
      MODEL_DEFAULTS
    }
  }
}
</script>
