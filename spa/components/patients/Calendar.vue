<template>

    <div id="cal">
        <h1>{{message}}</h1>
        <calendar-view
            :show-date="showDate"
            class="theme-default holiday-us-traditional holiday-us-official">
            <calendar-view-header
                slot="header"
                slot-scope="t"
                :header-props="t.headerProps"
                @input="setShowDate" 
                @click-date="onDateSelect"
                />
                
        </calendar-view>
    </div>

</template>
<script>
import { CalendarView, CalendarViewHeader } from "vue-simple-calendar"
require("vue-simple-calendar/static/css/default.css")
    require("vue-simple-calendar/static/css/holidays-us.css")



export default {
    data: function() {
            return { showDate: new Date(), message: '', }
        },
        components: {
            CalendarView,
            CalendarViewHeader,
        },
        
        methods: {
            setShowDate(d) {
                this.showDate = d;
            },
            onDateSelect(date) {
                // this.showDate = date
               this.message = `You clicked: ${d.toLocaleDateString()}`;
            },
        }
    
}
</script>
<style>
 
    #cal {
        font-family: 'Avenir', Helvetica, Arial, sans-serif;
        color: #2c3e50;
        height: 67vh;
        /* width: 90vw; */
        margin-left: auto;
        margin-right: auto;
        /* display: relative;  */
        /* display: flex;
        flex-direction: column;
        flex-grow: 1; */
    }
</style>