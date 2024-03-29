export default {
    // Global page headers: https://go.nuxtjs.dev/config-head

    env: {
        baseUrl: process.env.BASE_URL || 'http://localhost:8080'
    },

    head: {
        title: 'Handren - Dental',
        meta: [
            { charset: 'utf-8' },
            { name: 'viewport', content: 'width=device-width, initial-scale=1' },
            { hid: 'description', name: 'description', content: '' }
        ],
        link: [
            // { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
            { rel: 'icon', type: 'image/png', href: '/logo-sm-3.png' }
        ],
        script: [{
            //   src: 'vue-cal/dist/drag-and-drop.js'
        }],

    },

    // Global CSS: https://go.nuxtjs.dev/config-css
    css: [
        "./assets/plugins/bootstrap-datepicker/bootstrap-datepicker.css",

        "./assets/plugins/datatables/dataTables.bootstrap4.min.css",
        "./assets/plugins/datatables/buttons.bootstrap4.min.css",
        "./assets/plugins/dropify/css/dropify.min.css",
        "./assets/plugins/datatables/responsive.bootstrap4.min.css",

        "./assets/css/bootstrap.min.css",
        "./assets/css/icons.css",
        "./assets/css/metisMenu.min.css",
        "./assets/css/viewer.css",
        "./assets/css/style.css",
        "./assets/css/vue-form-wizard.css"
    ],

    // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
    plugins: [
        // { src: "~/plugins/vue-pdf.js" },
        { src: './plugins/vue-gallery.client.js' },
        // { src: './plugins/vue-carousel.js' },
        { src: "~/plugins/localStorage.js" },
        // { src: './plugins/vuescroll.js' },
        // { src: './plugins/vue-myupload.js' },
        // { src: './plugins/vue-form-wizard.js' },
        // { src: './plugins/vue-cal.js' },
    ],

    // Auto import components: https://go.nuxtjs.dev/config-components
    components: true,

    // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
    buildModules: [],

    // Modules: https://go.nuxtjs.dev/config-modules
    modules: [
        '@nuxtjs/dotenv',

        '@nuxtjs/auth',
        // https://go.nuxtjs.dev/bootstrap
        'bootstrap-vue/nuxt',
        // https://go.nuxtjs.dev/axios
        '@nuxtjs/moment',
        // '@nuxtjs/axios',
        ['@nuxtjs/axios', {
            credentials: false,
            proxyHeaders: false,
            baseURL: process.env.API_URL
        }],
        // https://go.nuxtjs.dev/pwa
        '@nuxtjs/pwa',
    ],

    // Axios module configuration: https://go.nuxtjs.dev/config-axios
    axios: {
        // Workaround to avoid enforcing hard-coded localhost:3000: https://github.com/nuxt-community/axios-module/issues/308
        baseURL: process.env.API_URL,
    },
    auth: {
        strategies: {
            local: {
                endpoints: {
                    login: {
                        url: process.env.LOGIN_URL,
                        // url: 'http://172.16.10.8:8000/api/user/token/',
                        method: "POST",
                        propertyName: "token",
                        altProperty: 'refresh'
                    },
                    logout: true,
                    user: {
                        url: process.env.USER_URL,
                        // url: `${process.env.baseUrl}:8000/api/user/me`,
                        // url: 'http://172.16.10.8:8000/api/user/me',
                        method: "get",
                        propertyName: false
                    }
                },
                tokenType: "Token "
            }
        },
        redirect: {
            login: '/login',
            logout: '/login',
            callback: false,
            home: '/'
        },
        watchLoggedIn: true
    },

    // PWA module configuration: https://go.nuxtjs.dev/pwa
    pwa: {
        manifest: {
            lang: 'en'
        }
    },

    // Build Configuration: https://go.nuxtjs.dev/config-build
    build: {},
    server: {
        port: 8080, // default: 3000
        host: "0.0.0.0" // default: localhost
    }
}