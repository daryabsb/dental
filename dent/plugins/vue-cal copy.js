import Vue from 'vue';
import { CalendarView, CalendarViewHeader } from "vue-simple-calendar"
// The next two lines are processed by webpack. If you're using the component without webpack compilation,
// you should just create <link> elements for these. Both are optional, you can create your own theme if you prefer.
require("vue-simple-calendar/static/css/default.css")
require("vue-simple-calendar/static/css/holidays-us.css")

Vue.component(CalendarView);
Vue.component(CalendarViewHeader);