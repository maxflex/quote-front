import Vue from "vue"
import App from "./App.vue"
import vuetify from "./plugins/vuetify"
import router from "./router"
import store from "./store"
require("@/assets/styles/index.scss")
require("@/plugins/filters")
import axios from "axios"
import { upperFirst, camelCase } from "lodash"
import { ENTITY_TYPE } from "@/enums/entity-type"
import Cookies from "js-cookie"

// Require @/components/UI globally
// https://vuejs.org/v2/guide/components-registration.html#Automatic-Global-Registration-of-Base-Components
const requireComponent = require.context(
  "@/components/UI",
  // Whether or not to look in subfolders
  false,
)

requireComponent.keys().forEach(fileName => {
  // Get component config
  const componentConfig = requireComponent(fileName)

  const componentName = upperFirst(
    camelCase(
      // Gets the file name regardless of folder depth
      fileName
        .split("/")
        .pop()
        .replace(/\.\w+$/, ""),
    ),
  )

  Vue.component(componentName, componentConfig.default || componentConfig)
})

const http = axios.create({
  baseURL: process.env.VUE_APP_API_URL,
})

const apiToken = Cookies.get("api_token")
if (apiToken !== undefined) {
  http.defaults.headers.common = {
    Authorization: `Bearer ${apiToken}`,
  }
}

Vue.prototype.$http = http
Vue.prototype.$entityType = ENTITY_TYPE

Vue.config.productionTip = false

new Vue({
  vuetify,
  router,
  store,
  render: h => h(App),
}).$mount("#app")
