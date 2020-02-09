<template>
  <div class="full-width">
    <div class="headline mb-4">
      {{ editMode ? "Редактировать автора" : "Добавить автора" }}
    </div>
    <v-card :loading="loading">
      <v-card-text>
        <v-row>
          <v-col
            class="text-center flex-grow-0 mr-4"
            :class="{ 'col-12': $vuetify.breakpoint.xsOnly }"
          >
            <AvatarLoader :item="item" :entity-type="$entityType.author" />
          </v-col>
          <v-col>
            <v-row>
              <v-col>
                <v-text-field
                  label="Никнейм"
                  v-model="item.nickname"
                  hint="Например: Кама Пуля"
                ></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-col>
                <v-text-field
                  label="Настоящее имя"
                  v-model="item.realname"
                ></v-text-field>
              </v-col>
            </v-row>
          </v-col>
        </v-row>
        <v-row class="mt-5">
          <v-col :align="$vuetify.breakpoint.xsOnly ? 'center' : 'end'">
            <v-btn color="primary" @click="save">
              {{ editMode ? "Сохранить" : "Добавить" }}
            </v-btn>
          </v-col>
        </v-row>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
import { API_AUTHORS } from "@/api"

export default {
  data() {
    return {
      saving: false,
      loading: false,
      item: {
        photo: null,
      },
    }
  },

  created() {
    this.loadData()
  },

  methods: {
    loadData() {
      const itemId = this.$route.params.id
      if (itemId !== undefined) {
        this.loading = true
        this.$http
          .get([API_AUTHORS, itemId].join("/"))
          .then(({ data }) => (this.item = data))
          .finally(() => (this.loading = false))
      }
    },

    save() {
      this.saving = true
      if (this.editMode) {
        this.$http
          .put([API_AUTHORS, this.item.id].join("/"), this.item)
          .then(() =>
            this.$store.commit("snackbar/SHOW", {
              text: "Сохранено",
            }),
          )
          .finally(() => (this.saving = false))
      } else {
        this.$http.post(API_AUTHORS, this.item).then(r => {
          this.$router.push({ name: "AuthorShow", params: { id: r.data.id } })
        })
      }
    },
  },

  computed: {
    editMode() {
      return this.loading || "id" in this.item
    },
  },
}
</script>
