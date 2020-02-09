<template>
  <v-toolbar dark color="primary">
    <v-toolbar-title>
      <span v-if="titleSub !== undefined" class="grey--text text--lighten-1">
        {{ titleSub }} /
      </span>
      {{ editMode ? titleEdit : titleNew }}
    </v-toolbar-title>
    <v-spacer></v-spacer>
    <v-toolbar-items>
      <v-btn
        v-if="editMode"
        :loading="destroying"
        @click="$emit('destroy')"
        dark
        text
      >
        Удалить
      </v-btn>
      <v-btn :loading="saving" @click="$emit('save')" dark text>
        Сохранить
      </v-btn>
    </v-toolbar-items>
    <div>
      <v-btn @click="$emit('close')" icon>
        <v-icon>close</v-icon>
      </v-btn>
    </div>
  </v-toolbar>
</template>

<script>
export default {
  props: {
    editMode: {
      type: Boolean,
      required: true,
    },
    titleNew: {
      type: String,
      required: true,
    },
    titleEdit: {
      type: String,
      required: true,
    },
    titleSub: {
      type: String,
    },
    saving: {
      type: Boolean,
      required: true,
    },
    destroying: {
      type: Boolean,
      required: true,
    },
  },
}
</script>
