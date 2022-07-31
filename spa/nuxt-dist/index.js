import Vue from 'vue'
import Vuex from 'vuex'
import Meta from 'vue-meta'
import ClientOnly from 'vue-client-only'
import NoSsr from 'vue-no-ssr'
import { createRouter } from './router.js'
import NuxtChild from './components/nuxt-child.js'
import NuxtError from './components/nuxt-error.vue'
import Nuxt from './components/nuxt.js'
import App from './App.js'
import { setContext, getLocation, getRouteData, normalizeError } from './utils'
import { createStore } from './store.js'

/* Plugins */

import nuxt_plugin_plugin_506a319b from 'nuxt_plugin_plugin_506a319b' // Source: .\\components\\plugin.js (mode: 'all')
import nuxt_plugin_bootstrapvue_964e9326 from 'nuxt_plugin_bootstrapvue_964e9326' // Source: .\\bootstrap-vue.js (mode: 'all')
import nuxt_plugin_workbox_de22584c from 'nuxt_plugin_workbox_de22584c' // Source: .\\workbox.js (mode: 'client')
import nuxt_plugin_meta_62eb5193 from 'nuxt_plugin_meta_62eb5193' // Source: .\\pwa\\meta.js (mode: 'all')
import nuxt_plugin_icons_2d09ae08 from 'nuxt_plugin_icons_2d09ae08' // Source: .\\pwa\\icons.js (mode: 'all')
import nuxt_plugin_axios_0402f63e from 'nuxt_plugin_axios_0402f63e' // Source: .\\axios.js (mode: 'all')
import nuxt_plugin_moment_e9f139cc from 'nuxt_plugin_moment_e9f139cc' // Source: .\\moment.js (mode: 'all')
import nuxt_plugin_vuepdf_16ca6c3c from 'nuxt_plugin_vuepdf_16ca6c3c' // Source: ..\\plugins\\vue-pdf.js (mode: 'all')
import nuxt_plugin_vuegalleryclient_3bcb2423 from 'nuxt_plugin_vuegalleryclient_3bcb2423' // Source: ..\\plugins\\vue-gallery.client.js (mode: 'client')
import nuxt_plugin_vuecarousel_3ed7d84a from 'nuxt_plugin_vuecarousel_3ed7d84a' // Source: ..\\plugins\\vue-carousel.js (mode: 'all')
import nuxt_plugin_localStorage_830ec59e from 'nuxt_plugin_localStorage_830ec59e' // Source: ..\\plugins\\localStorage.js (mode: 'all')
import nuxt_plugin_vuescroll_6ae91a0a from 'nuxt_plugin_vuescroll_6ae91a0a' // Source: ..\\plugins\\vuescroll.js (mode: 'all')
import nuxt_plugin_vuemyupload_38306fdd from 'nuxt_plugin_vuemyupload_38306fdd' // Source: ..\\plugins\\vue-myupload.js (mode: 'all')
import nuxt_plugin_vueformwizard_1f0cc650 from 'nuxt_plugin_vueformwizard_1f0cc650' // Source: ..\\plugins\\vue-form-wizard.js (mode: 'all')
import nuxt_plugin_vuecal_7bb13fd6 from 'nuxt_plugin_vuecal_7bb13fd6' // Source: ..\\plugins\\vue-cal.js (mode: 'all')
import nuxt_plugin_plugin_3464bf6d from 'nuxt_plugin_plugin_3464bf6d' // Source: .\\auth\\plugin.js (mode: 'all')

// Component: <ClientOnly>
Vue.component(ClientOnly.name, ClientOnly)

// TODO: Remove in Nuxt 3: <NoSsr>
Vue.component(NoSsr.name, {
  ...NoSsr,
  render (h, ctx) {
    if (process.client && !NoSsr._warned) {
      NoSsr._warned = true

      console.warn('<no-ssr> has been deprecated and will be removed in Nuxt 3, please use <client-only> instead')
    }
    return NoSsr.render(h, ctx)
  }
})

// Component: <NuxtChild>
Vue.component(NuxtChild.name, NuxtChild)
Vue.component('NChild', NuxtChild)

// Component NuxtLink is imported in server.js or client.js

// Component: <Nuxt>
Vue.component(Nuxt.name, Nuxt)

Object.defineProperty(Vue.prototype, '$nuxt', {
  get() {
    return this.$root.$options.$nuxt
  },
  configurable: true
})

Vue.use(Meta, {"keyName":"head","attribute":"data-n-head","ssrAttribute":"data-n-head-ssr","tagIDKeyName":"hid"})

const defaultTransition = {"name":"page","mode":"out-in","appear":true,"appearClass":"appear","appearActiveClass":"appear-active","appearToClass":"appear-to"}

const originalRegisterModule = Vuex.Store.prototype.registerModule
const baseStoreOptions = { preserveState: process.client }

function registerModule (path, rawModule, options = {}) {
  return originalRegisterModule.call(this, path, rawModule, { ...baseStoreOptions, ...options })
}

async function createApp(ssrContext, config = {}) {
  const router = await createRouter(ssrContext)

  const store = createStore(ssrContext)
  // Add this.$router into store actions/mutations
  store.$router = router

  // Create Root instance

  // here we inject the router and store to all child components,
  // making them available everywhere as `this.$router` and `this.$store`.
  const app = {
    head: {"title":"spa","meta":[{"charset":"utf-8"},{"name":"viewport","content":"width=device-width, initial-scale=1"},{"hid":"description","name":"description","content":""}],"link":[{"rel":"icon","type":"image\u002Fx-icon","href":"\u002Ffavicon.ico"}],"style":[],"script":[]},

    store,
    router,
    nuxt: {
      defaultTransition,
      transitions: [defaultTransition],
      setTransitions (transitions) {
        if (!Array.isArray(transitions)) {
          transitions = [transitions]
        }
        transitions = transitions.map((transition) => {
          if (!transition) {
            transition = defaultTransition
          } else if (typeof transition === 'string') {
            transition = Object.assign({}, defaultTransition, { name: transition })
          } else {
            transition = Object.assign({}, defaultTransition, transition)
          }
          return transition
        })
        this.$options.nuxt.transitions = transitions
        return transitions
      },

      err: null,
      dateErr: null,
      error (err) {
        err = err || null
        app.context._errored = Boolean(err)
        err = err ? normalizeError(err) : null
        let nuxt = app.nuxt // to work with @vue/composition-api, see https://github.com/nuxt/nuxt.js/issues/6517#issuecomment-573280207
        if (this) {
          nuxt = this.nuxt || this.$options.nuxt
        }
        nuxt.dateErr = Date.now()
        nuxt.err = err
        // Used in src/server.js
        if (ssrContext) {
          ssrContext.nuxt.error = err
        }
        return err
      }
    },
    ...App
  }

  // Make app available into store via this.app
  store.app = app

  const next = ssrContext ? ssrContext.next : location => app.router.push(location)
  // Resolve route
  let route
  if (ssrContext) {
    route = router.resolve(ssrContext.url).route
  } else {
    const path = getLocation(router.options.base, router.options.mode)
    route = router.resolve(path).route
  }

  // Set context to app.context
  await setContext(app, {
    store,
    route,
    next,
    error: app.nuxt.error.bind(app),
    payload: ssrContext ? ssrContext.payload : undefined,
    req: ssrContext ? ssrContext.req : undefined,
    res: ssrContext ? ssrContext.res : undefined,
    beforeRenderFns: ssrContext ? ssrContext.beforeRenderFns : undefined,
    ssrContext
  })

  function inject(key, value) {
    if (!key) {
      throw new Error('inject(key, value) has no key provided')
    }
    if (value === undefined) {
      throw new Error(`inject('${key}', value) has no value provided`)
    }

    key = '$' + key
    // Add into app
    app[key] = value
    // Add into context
    if (!app.context[key]) {
      app.context[key] = value
    }

    // Add into store
    store[key] = app[key]

    // Check if plugin not already installed
    const installKey = '__nuxt_' + key + '_installed__'
    if (Vue[installKey]) {
      return
    }
    Vue[installKey] = true
    // Call Vue.use() to install the plugin into vm
    Vue.use(() => {
      if (!Object.prototype.hasOwnProperty.call(Vue.prototype, key)) {
        Object.defineProperty(Vue.prototype, key, {
          get () {
            return this.$root.$options[key]
          }
        })
      }
    })
  }

  // Inject runtime config as $config
  inject('config', config)

  if (process.client) {
    // Replace store state before plugins execution
    if (window.__NUXT__ && window.__NUXT__.state) {
      store.replaceState(window.__NUXT__.state)
    }
  }

  // Add enablePreview(previewData = {}) in context for plugins
  if (process.static && process.client) {
    app.context.enablePreview = function (previewData = {}) {
      app.previewData = Object.assign({}, previewData)
      inject('preview', previewData)
    }
  }
  // Plugin execution

  if (typeof nuxt_plugin_plugin_506a319b === 'function') {
    await nuxt_plugin_plugin_506a319b(app.context, inject)
  }

  if (typeof nuxt_plugin_bootstrapvue_964e9326 === 'function') {
    await nuxt_plugin_bootstrapvue_964e9326(app.context, inject)
  }

  if (process.client && typeof nuxt_plugin_workbox_de22584c === 'function') {
    await nuxt_plugin_workbox_de22584c(app.context, inject)
  }

  if (typeof nuxt_plugin_meta_62eb5193 === 'function') {
    await nuxt_plugin_meta_62eb5193(app.context, inject)
  }

  if (typeof nuxt_plugin_icons_2d09ae08 === 'function') {
    await nuxt_plugin_icons_2d09ae08(app.context, inject)
  }

  if (typeof nuxt_plugin_axios_0402f63e === 'function') {
    await nuxt_plugin_axios_0402f63e(app.context, inject)
  }

  if (typeof nuxt_plugin_moment_e9f139cc === 'function') {
    await nuxt_plugin_moment_e9f139cc(app.context, inject)
  }

  if (typeof nuxt_plugin_vuepdf_16ca6c3c === 'function') {
    await nuxt_plugin_vuepdf_16ca6c3c(app.context, inject)
  }

  if (process.client && typeof nuxt_plugin_vuegalleryclient_3bcb2423 === 'function') {
    await nuxt_plugin_vuegalleryclient_3bcb2423(app.context, inject)
  }

  if (typeof nuxt_plugin_vuecarousel_3ed7d84a === 'function') {
    await nuxt_plugin_vuecarousel_3ed7d84a(app.context, inject)
  }

  if (typeof nuxt_plugin_localStorage_830ec59e === 'function') {
    await nuxt_plugin_localStorage_830ec59e(app.context, inject)
  }

  if (typeof nuxt_plugin_vuescroll_6ae91a0a === 'function') {
    await nuxt_plugin_vuescroll_6ae91a0a(app.context, inject)
  }

  if (typeof nuxt_plugin_vuemyupload_38306fdd === 'function') {
    await nuxt_plugin_vuemyupload_38306fdd(app.context, inject)
  }

  if (typeof nuxt_plugin_vueformwizard_1f0cc650 === 'function') {
    await nuxt_plugin_vueformwizard_1f0cc650(app.context, inject)
  }

  if (typeof nuxt_plugin_vuecal_7bb13fd6 === 'function') {
    await nuxt_plugin_vuecal_7bb13fd6(app.context, inject)
  }

  if (typeof nuxt_plugin_plugin_3464bf6d === 'function') {
    await nuxt_plugin_plugin_3464bf6d(app.context, inject)
  }

  // Lock enablePreview in context
  if (process.static && process.client) {
    app.context.enablePreview = function () {
      console.warn('You cannot call enablePreview() outside a plugin.')
    }
  }

  // If server-side, wait for async component to be resolved first
  if (process.server && ssrContext && ssrContext.url) {
    await new Promise((resolve, reject) => {
      router.push(ssrContext.url, resolve, (err) => {
        // https://github.com/vuejs/vue-router/blob/v3.4.3/src/util/errors.js
        if (!err._isRouter) return reject(err)
        if (err.type !== 2 /* NavigationFailureType.redirected */) return resolve()

        // navigated to a different route in router guard
        const unregister = router.afterEach(async (to, from) => {
          ssrContext.url = to.fullPath
          app.context.route = await getRouteData(to)
          app.context.params = to.params || {}
          app.context.query = to.query || {}
          unregister()
          resolve()
        })
      })
    })
  }

  return {
    store,
    app,
    router
  }
}

export { createApp, NuxtError }
