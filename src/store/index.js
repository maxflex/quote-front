import Vue from "vue"
import Vuex from "vuex"
import auth from "./auth"
import snackbar from "./snackbar"
import state from "./state"
import mutations from "./mutations"
import getters from "./getters"

Vue.use(Vuex)

const store = new Vuex.Store({
  modules: {
    auth,
    snackbar,
  },
  state,
  mutations,
  getters,
})

export default store
