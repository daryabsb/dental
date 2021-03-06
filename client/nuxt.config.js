export default {

    env: {
        // baseUrl: 'http://127.0.0.1:8000'
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


            { src: "~assets/js/jquery.slimscroll.min.js", body: true },
            // { src: "~assets/js/pdfobject.min.js", body: true },
            // { src: "~assets/js/pdf.js", body: true }
            // { src: "https://unpkg.com/vue-cookies@1.7.4/vue-cookies.js", body: true }

        ]
    },

    // Global CSS (https://go.nuxtjs.dev/config-css)
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

    // Plugins to run before rendering page (https://go.nuxtjs.dev/config-plugins)
    plugins: [
        { src: '~/plugins/vue-datepicker', mode: 'client' }, // datepicker plugin here
        { src: "./plugins/axios.js", mode: 'client' },
        { src: "~/plugins/vue-pdf.js", mode: 'client' },
        { src: "./plugins/vue-instant-pdf.js", mode: 'client' },
        { src: './plugins/vue-gallery.client.js', mode: 'client' },
        { src: './plugins/vue-carousel.js', mode: 'client' },
        { src: "~/plugins/localStorage.js", ssr: false },
        { src: './plugins/vuescroll.js', mode: 'client' },
        { src: './plugins/vue-myupload.js', mode: 'client' },
        { src: './plugins/vue-form-wizard.js', mode: 'client' },
        { src: './plugins/vue-form-generator.js', mode: 'client' },
        // { src: './plugins/vue-pdf-preview.js', mode: 'client' },
        // vue - pdf - preview.js
        // { src: "~assets/js/bootstrap.bundle.min.js", ssr: false },
        // { src: "~assets/js/metisMenu.min.js", ssr: false },
        // { src: "~assets/js/waves.min.js", ssr: false }

    ],

    // Auto import components (https://go.nuxtjs.dev/config-components)
    components: true,

    // Modules for dev and build (recommended) (https://go.nuxtjs.dev/config-modules)
    buildModules: [
        // "@nuxtjs/style-resources"
    ],

    // Modules (https://go.nuxtjs.dev/config-modules)
    modules: [
        ["cookie-universal-nuxt", { alias: "cookiz", parseJSON: false }],
        // https://go.nuxtjs.dev/bootstrap
        //"bootstrap-vue/nuxt",
        'bootstrap-vue/nuxt',
        // "@nuxtjs/style-resources",
        '@nuxtjs/auth',
        '@nuxtjs/moment',
        // https://go.nuxtjs.dev/axios
        "@nuxtjs/axios",
        // https://go.nuxtjs.dev/pwa
        "@nuxtjs/pwa"
    ],
    bootstrapVue: {
        // componentPlugins: [
        //     //   'LayoutPlugin',
        //     //   'FormPlugin',
        //     //   'FormCheckboxPlugin',
        //     //   'FormInputPlugin',
        //     //   'FormRadioPlugin',
        //     //   'ToastPlugin',
        //     'ButtonPlugin',
        //     'ModalPlugin'
        // ],
        // directivePlugins: ['VBPopoverPlugin', 'VBTooltipPlugin', 'VBScrollspyPlugin']
    },

    // Axios module configuration (https://go.nuxtjs.dev/config-axios)
    axios: {
        baseURL: 'http://localhost:8000/api'
    },

    // Build Configuration (https://go.nuxtjs.dev/config-build)
    build: {
        extend(config, ctx) {
            config.output.globalObject = 'this'
            config.module.rules.push({
                test: /\.pdf$/,
                loader: 'url-loader'
            })
        },
        extend(config, { isClient }) {
            // Extend only webpack config for client-bundle
            if (isClient) {
                config.devtool = 'source-map'
            }
        },
        transpile: ['vue-form-wizard.js'],
        // transpile: ['vue-pdf-preview.js'],

    },
    auth: {
        strategies: {
            local: {
                endpoints: {
                    login: {
                        url: "http://127.0.0.1:8000/api/user/token/",
                        method: "POST",
                        propertyName: "token",
                        altProperty: 'refresh'
                    },
                    logout: true,
                    user: {
                        url: "http://127.0.0.1:8000/api/user/me",
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
            callback: '/login',
            home: '/'
        },
    },
    router: {
        middleware: ['auth']
    },
    server: {
        // port: 8080 // default: 3000
        //host: "0.0.0.0" // default: localhost
    }
};