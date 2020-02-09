<template>
  <div class="full-width">
    <div class="headline mb-4">Добавить цитату</div>
    <v-card>
      <v-card-text>
        <v-row>
          <v-col>
            <v-select
              v-model="item.author_id"
              :items="authors"
              item-text="nickname"
              item-value="id"
              label="Автор"
              outlined
              hide-details
            >
              <template v-slot:selection="{ item }">
                <v-list-item-avatar :size="32" class="my-0">
                  <Avatar :item="item" :size="32" />
                </v-list-item-avatar>
                <v-list-item-content>
                  <v-list-item-title>
                    {{ item.nickname }}
                  </v-list-item-title>
                </v-list-item-content>
              </template>
              <template v-slot:item="{ item }">
                <v-list-item-avatar :size="40">
                  <Avatar :item="item" :size="40" />
                </v-list-item-avatar>
                <v-list-item-content>
                  <v-list-item-title>
                    {{ item.nickname }}
                  </v-list-item-title>
                  <v-list-item-subtitle>
                    {{ item.realname }}
                  </v-list-item-subtitle>
                </v-list-item-content>
              </template>
            </v-select>
            <div v-if="isLoggedIn" class="text-right caption mt-1">
              <router-link :to="{ name: 'AddAuthor' }">
                добавить автора
              </router-link>
            </div>
          </v-col>
        </v-row>
        <v-row>
          <v-col>
            <v-textarea
              auto-grow
              label="Цитата"
              outlined
              v-model="item.text"
            ></v-textarea>
          </v-col>
        </v-row>
        <v-row>
          <v-col align="end">
            <v-btn color="primary" @click="save" :loading="saving">
              Добавить
            </v-btn>
          </v-col>
        </v-row>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
import { API_AUTHORS, API_QUOTES } from "@/api"
import { mapGetters } from "vuex"

export default {
  data() {
    return {
      authors: [],
      item: {},
      saving: false,
    }
  },

  created() {
    this.loadAuthors()
  },

  methods: {
    loadAuthors() {
      this.$http.get(API_AUTHORS).then(r => {
        this.authors = r.data.data
      })
    },

    save() {
      this.saving = true
      this.$http.post(API_QUOTES, this.item).then(r => {
        this.$router.push({ name: "QuoteShow", params: { id: r.data.id } })
        this.$store.commit("snackbar/SHOW", { text: "Цитата добавлена" })
        // this.$store.commit("snackbar/SHOW", {
        //   text: this.isLoggedIn
        //     ? "Цитата добавлена"
        //     : "Цитата станет доступна после модерации",
        // })
      })
    },
  },

  computed: {
    ...mapGetters("auth", ["isLoggedIn"]),
  },
}
</script>
