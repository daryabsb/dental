import Vue from 'vue'
import Router from 'vue-router'
import { interopDefault } from './utils'
import scrollBehavior from './router.scrollBehavior.js'

const _37138117 = () => interopDefault(import('..\\pages\\appointments\\index.vue' /* webpackChunkName: "pages/appointments/index" */))
const _7bc2c294 = () => interopDefault(import('..\\pages\\home.vue' /* webpackChunkName: "pages/home" */))
const _82292656 = () => interopDefault(import('..\\pages\\home-BAK.vue' /* webpackChunkName: "pages/home-BAK" */))
const _c0cbc2bc = () => interopDefault(import('..\\pages\\login.vue' /* webpackChunkName: "pages/login" */))
const _86e20006 = () => interopDefault(import('..\\pages\\patients\\index.vue' /* webpackChunkName: "pages/patients/index" */))
const _6338420c = () => interopDefault(import('..\\pages\\register.vue' /* webpackChunkName: "pages/register" */))
const _7b2b84b0 = () => interopDefault(import('..\\pages\\treatments\\index.vue' /* webpackChunkName: "pages/treatments/index" */))
const _87c198be = () => interopDefault(import('..\\pages\\users\\index.vue' /* webpackChunkName: "pages/users/index" */))
const _1c13f3be = () => interopDefault(import('..\\pages\\appointments\\appointments-bak.vue' /* webpackChunkName: "pages/appointments/appointments-bak" */))
const _bfbf2ed6 = () => interopDefault(import('..\\pages\\treatments\\treatment-bak.vue' /* webpackChunkName: "pages/treatments/treatment-bak" */))
const _aa3244b6 = () => interopDefault(import('..\\pages\\patients\\_id.vue' /* webpackChunkName: "pages/patients/_id" */))
const _e910ab6e = () => interopDefault(import('..\\pages\\users\\_id.vue' /* webpackChunkName: "pages/users/_id" */))
const _541b08ea = () => interopDefault(import('..\\pages\\index.vue' /* webpackChunkName: "pages/index" */))

// TODO: remove in Nuxt 3
const emptyFn = () => {}
const originalPush = Router.prototype.push
Router.prototype.push = function push (location, onComplete = emptyFn, onAbort) {
  return originalPush.call(this, location, onComplete, onAbort)
}

Vue.use(Router)

export const routerOptions = {
  mode: 'history',
  base: decodeURI('/'),
  linkActiveClass: 'nuxt-link-active',
  linkExactActiveClass: 'nuxt-link-exact-active',
  scrollBehavior,

  routes: [{
    path: "/appointments",
    component: _37138117,
    name: "appointments"
  }, {
    path: "/home",
    component: _7bc2c294,
    name: "home"
  }, {
    path: "/home-BAK",
    component: _82292656,
    name: "home-BAK"
  }, {
    path: "/login",
    component: _c0cbc2bc,
    name: "login"
  }, {
    path: "/patients",
    component: _86e20006,
    name: "patients"
  }, {
    path: "/register",
    component: _6338420c,
    name: "register"
  }, {
    path: "/treatments",
    component: _7b2b84b0,
    name: "treatments"
  }, {
    path: "/users",
    component: _87c198be,
    name: "users"
  }, {
    path: "/appointments/appointments-bak",
    component: _1c13f3be,
    name: "appointments-appointments-bak"
  }, {
    path: "/treatments/treatment-bak",
    component: _bfbf2ed6,
    name: "treatments-treatment-bak"
  }, {
    path: "/patients/:id",
    component: _aa3244b6,
    name: "patients-id"
  }, {
    path: "/users/:id",
    component: _e910ab6e,
    name: "users-id"
  }, {
    path: "/",
    component: _541b08ea,
    name: "index"
  }],

  fallback: false
}

export function createRouter () {
  return new Router(routerOptions)
}
