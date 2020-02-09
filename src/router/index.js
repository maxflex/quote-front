import Vue from "vue"
import VueRouter from "vue-router"

Vue.use(VueRouter)

const requireModule = require.context("./routes", false, /\.js/)

const routes = requireModule
  .keys()
  .map(key => require(`./routes/` + key.slice(2)).default)
  .flat()

const router = new VueRouter({
  mode: "history",
  routes,
})

export default router
