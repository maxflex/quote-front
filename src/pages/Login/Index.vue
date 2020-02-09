<template>
  <div class="full-size d-flex align-center justify-center">
    <v-card width="400" class="elevation-5">
      <v-card-title class="justify-center">
        {{ step === 3 ? "Регистрация" : "Вход" }}
      </v-card-title>
      <v-card-text>
        <v-stepper non-linear v-model="step" class="elevation-0">
          <v-stepper-items>
            <v-stepper-content :step="1">
              <v-text-field
                outlined
                label="Email"
                class="mt-1"
                v-model="credentials.email"
                @keydown.enter="step = 2"
              />
              <div class="d-flex justify-space-between mt-10">
                <a class="subtitle-2" @click="step = 3">Создать аккаунт</a>
                <v-btn color="primary" @click="step = 2">далее</v-btn>
              </div>
            </v-stepper-content>
            <v-stepper-content :step="2">
              <v-text-field
                outlined
                label="Пароль"
                v-model="credentials.password"
                @keydown.enter="signIn()"
                type="password"
                class="mt-1"
              />
              <div class="d-flex justify-space-between mt-10">
                <a @click="step = 1" class="subtitle-2">Назад</a>
                <v-btn color="primary" @click="signIn()" :loading="loading"
                  >далее</v-btn
                >
              </div>
            </v-stepper-content>
            <v-stepper-content :step="3">
              <v-text-field
                outlined
                label="email"
                v-model="newUser.email"
                class="mt-1"
              />
              <v-text-field
                outlined
                label="nickname"
                v-model="newUser.nickname"
                prefix="@"
                class="mt-1"
              />
              <v-text-field
                outlined
                label="настоящее имя"
                v-model="newUser.realname"
                class="mt-1"
              />
              <v-text-field
                outlined
                label="пароль"
                v-model="newUser.password"
                type="password"
                class="mt-1"
              />
              <v-text-field
                outlined
                label="пароль еще раз"
                v-model="newUser.password_confirmation"
                type="password"
                class="mt-1"
              />
              <div class="d-flex justify-space-between mt-10">
                <a @click="step = 1" class="subtitle-2">Назад</a>
                <v-btn color="primary" @click="register()" :loading="loading"
                  >далее</v-btn
                >
              </div>
            </v-stepper-content>
          </v-stepper-items>
        </v-stepper>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
import { API_USERS } from "@/api"

export default {
  data() {
    return {
      step: 1,
      loading: false,
      credentials: {
        login: "",
        password: "",
      },
      newUser: {},
      error: null,
    }
  },

  methods: {
    signIn() {
      this.loading = true
      this.$store
        .dispatch("auth/signIn", this.credentials)
        .then(() => this.$router.push("/"))
        .catch(e => (this.error = e.data))
        .finally(() => {
          this.loading = false
        })
    },

    register() {
      this.loading = true
      this.$http
        .post(API_USERS, this.newUser)
        .then(r => {
          this.$store.dispatch("auth/setUser", r.data)
          this.$router.push({ name: "ProfileIndex" })
          this.$store.commit("snackbar/SHOW", {
            text: "Пользователь зарегестрирован",
          })
        })
        .catch(e => (this.error = e.data))
        .finally(() => {
          this.loading = false
        })
    },
  },
}
</script>

<style></style>
