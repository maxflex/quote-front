<template>
  <div class="full-width">
    <div class="headline mb-4">
      Профиль
    </div>
    <v-card :loading="loading">
      <v-card-text>
        <v-row>
          <v-col
            class="flex-grow-0 mr-4 text-center"
            :class="{ 'col-12': $vuetify.breakpoint.xsOnly }"
          >
            <AvatarLoader :item="item" :entity-type="$entityType.user" />
          </v-col>
          <v-col>
            <v-row>
              <v-col>
                <v-text-field
                  label="Никнейм"
                  v-model="item.nickname"
                  prefix="@"
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
            <v-row>
              <v-col>
                <v-text-field label="Email" v-model="item.email"></v-text-field>
              </v-col>
            </v-row>
            <Expander text="изменить пароль">
              <v-row>
                <v-col>
                  <v-text-field
                    label="Пароль"
                    v-model="item.password"
                    type="password"
                  ></v-text-field>
                </v-col>
              </v-row>
              <v-row>
                <v-col>
                  <v-text-field
                    label="Пароль ещё раз"
                    v-model="item.password_confirmation"
                    type="password"
                  ></v-text-field>
                </v-col>
              </v-row>
            </Expander>
          </v-col>
        </v-row>
        <v-row class="mt-5">
          <v-col :align="$vuetify.breakpoint.xsOnly ? 'center' : 'end'">
            <v-btn color="primary" @click="save">
              Сохранить
            </v-btn>
          </v-col>
        </v-row>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
import { API_USERS } from "@/api"

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
      this.loading = true
      this.$http
        .get("profile")
        .then(({ data }) => (this.item = data))
        .finally(() => (this.loading = false))
    },

    save() {
      this.saving = true
      this.$http
        .put([API_USERS, this.item.id].join("/"), this.item)
        .then(() =>
          this.$store.commit("snackbar/SHOW", {
            text: "Сохранено",
          }),
        )
        .finally(() => (this.saving = false))
    },
  },
}
</script>
