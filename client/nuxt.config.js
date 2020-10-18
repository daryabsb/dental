export default {

    env: {
        baseUrl: 'http://127.0.0.1:8000'
    },
    // Global page headers (https://go.nuxtjs.dev/config-head)
    head: {
        title: "client",
        meta: [
            { charset: "utf-8" },
            { name: "viewport", content: "width=device-width, initial-scale=1" },
            { hid: "description", name: "description", content: "" }
        ],
        link: [{ rel: "icon", type: "image/x-icon", href: "/favicon.ico" }],
        scripts: [


            { src: "~assets/js/jquery.slimscroll.min.js", body: true }
            // { src: "https://unpkg.com/vue-cookies@1.7.4/vue-cookies.js", body: true }

        ]
    },

    // Global CSS (https://go.nuxtjs.dev/config-css)
    css: [
        "./assets/plugins/bootstrap-datepicker/bootstrap-datepicker.css",

        "./assets/plugins/datatables/dataTables.bootstrap4.min.css",
        "./assets/plugins/datatables/buttons.bootstrap4.min.css",

        "./assets/plugins/datatables/responsive.bootstrap4.min.css",

        "./assets/css/bootstrap.min.css",
        "./assets/css/icons.css",
        "./assets/css/metisMenu.min.css",
        "./assets/css/style.css"
    ],

    // Plugins to run before rendering page (https://go.nuxtjs.dev/config-plugins)
    plugins: [
        { src: "./plugins/axios.js", ssr: false }
        // { src: "~assets/js/bootstrap.bundle.min.js", ssr: false },
        // { src: "~assets/js/metisMenu.min.js", ssr: false },
        // { src: "~assets/js/waves.min.js", ssr: false }

    ],

    // Auto import components (https://go.nuxtjs.dev/config-components)
    components: true,

    // Modules for dev and build (recommended) (https://go.nuxtjs.dev/config-modules)
    buildModules: [],

    // Modules (https://go.nuxtjs.dev/config-modules)
    modules: [
        ["cookie-universal-nuxt", { alias: "cookiz", parseJSON: false }],
        // https://go.nuxtjs.dev/bootstrap
        //"bootstrap-vue/nuxt",
        // https://go.nuxtjs.dev/axios
        "@nuxtjs/axios",
        // https://go.nuxtjs.dev/pwa
        "@nuxtjs/pwa"
    ],

    // Axios module configuration (https://go.nuxtjs.dev/config-axios)
    axios: {},

    // Build Configuration (https://go.nuxtjs.dev/config-build)
    build: {},
    server: {
        port: 8080, // default: 3000
        host: "0.0.0.0" // default: localhost
    }
};