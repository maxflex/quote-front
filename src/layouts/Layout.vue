<template>
  <v-app id="inspire">
    <v-app-bar app height="100" class="px-6">
      <v-toolbar-title class="header-logo d-flex">
        <router-link to="/">
          <img class="header-logo__img" src="/img/svg/logo.svg" />
        </router-link>
        <div class="header-logo__text caption">
          Одну цитату жиесть
        </div>
      </v-toolbar-title>
      <Menu />
      <div class="d-flex justify-end">
        <v-menu offset-y v-if="isLoggedIn">
          <template v-slot:activator="{ on }">
            <v-btn v-on="on" icon :width="avatarSize" :height="avatarSize">
              <Avatar :item="user" />
            </v-btn>
          </template>
          <v-list width="300">
            <v-list-item class="pb-2">
              <v-list-item-avatar :size="avatarSize">
                <Avatar :item="user" :size="avatarSize" />
              </v-list-item-avatar>
              <v-list-item-content>
                <v-list-item-title class="font-weight-medium">
                  {{ user.realname }}
                </v-list-item-title>
                <v-list-item-subtitle v-if="user.nickname !== null">
                  @{{ user.nickname }}
                </v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>
            <v-divider></v-divider>
            <v-list-item @click="$router.push('/profile')">
              <v-list-item-icon>
                <v-icon>
                  person
                </v-icon>
              </v-list-item-icon>
              <v-list-item-title>Профиль</v-list-item-title>
            </v-list-item>
            <v-list-item @click="$store.dispatch('auth/logout')">
              <v-list-item-icon>
                <v-icon>exit_to_app</v-icon>
              </v-list-item-icon>
              <v-list-item-title>Выйти</v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>
        <v-btn :to="{ name: 'LoginIndex' }" color="primary" v-else>
          Войти
        </v-btn>
      </div>
    </v-app-bar>

    <v-content>
      <v-container class="fill-height align-start pt-8">
        <transition name="fade">
          <router-view></router-view>
        </transition>
      </v-container>
    </v-content>

    <v-snackbar :color="snackbar.color" v-model="snackbar.show">
      <div class="full-width text-center">
        {{ snackbar.text }}
      </div>
    </v-snackbar>
  </v-app>
</template>

<script>
import Menu from "@/layouts/Menu"
import { mapGetters, mapState } from "vuex"

export default {
  data() {
    return {
      avatarSize: 56,
    }
  },

  components: { Menu },

  computed: {
    ...mapGetters("auth", ["isLoggedIn"]),
    ...mapState("auth", ["user"]),
    ...mapState({ snackbar: state => state.snackbar }),
  },
}
</script>

<style lang="scss">
.v-toolbar__content {
  justify-content: space-between;
  padding: 0 !important;
  & > * {
    flex: 1;
  }
}

.header-logo {
  // padding: 4px 16px;
  overflow: visible !important;
  &__img {
    height: 72px;
  }
  &__text {
    position: absolute;
    text-transform: uppercase;
    // left: 102px;
    left: 86px;
    top: 62px;
  }
}
</style>
