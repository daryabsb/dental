<template>

	<b-container id="cal2">
		<b-button @click="customEventCreation">Add an Event</b-button>
		

		<b-modal v-model="showDialog">
  <b-card>
    <b-card-title>
      <b-icon>{{ selectedEvent.icon }}</b-icon>
      <span>{{ selectedEvent.title }}</span>
      <strong>{{ selectedEvent.start && selectedEvent.start.format('DD/MM/YYYY') }}</strong>
    </b-card-title>
    <b-card-text>
      <p v-html="selectedEvent.contentFull"/>
      <strong>Event details:</strong>
      <ul>
        <li>Event starts at: {{ selectedEvent.start && selectedEvent.start.formatTime() }}</li>
        <li>Event ends at: {{ selectedEvent.end && selectedEvent.end.formatTime() }}</li>
      </ul>
    </b-card-text>
  </b-card>
</b-modal>
		<vue-cal
		ref="vuecal"
		selected-date="2018-11-19"
         :time-from="9 * 60"
         :time-to="19 * 60"
         :disable-views="['years', 'year']"
         hide-weekends
         :events="events"
         :on-event-click="onEventClick"
		></vue-cal>
	</b-container>
</template>
<script>
import VueCal from 'vue-cal'
import 'vue-cal/dist/vuecal.css'

export default {
	 components: { VueCal },
	 data: () => ({
  selectedEvent: {},
  showDialog: false,
  events: [
    {
      start: '2018-11-20 14:00',
      end: '2018-11-20 18:00',
      title: 'Need to go shopping',
      icon: 'shopping_cart', // Custom attribute.
      content: 'Click to see my shopping list',
      contentFull: 'My shopping list is rather long:<br><ul><li>Avocados</li><li>Tomatoes</li><li>Potatoes</li><li>Mangoes</li></ul>', // Custom attribute.
      class: 'leisure'
    },
    {
      start: '2018-11-22 10:00',
      end: '2018-11-22 15:00',
      title: 'Golf with John',
      icon: 'golf_course', // Custom attribute.
      content: 'Do I need to tell how many holes?',
      contentFull: 'Okay.<br>It will be a 18 hole golf course.', // Custom attribute.
      class: 'sport'
    }
  ],
  prompt: '',
}),
methods: {
  onEventClick (event, e) {
    this.selectedEvent = event
    this.showDialog = true

    // Prevent navigating to narrower view (default vue-cal behavior).
    e.stopPropagation()
  }
},
customEventCreation () {
    const dateTime = '2020-11-27 13:15';

    // Check if date format is correct before creating event.
    if (/^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$/.test(dateTime)) {
      this.$refs['vuecal'].createEvent(
        // Formatted start date and time or JavaScript Date object.
        dateTime,
        // Event duration in minutes (Integer).
        120,
        // Custom event props (optional).
        { title: 'New Event', content: 'yay! 🎉', class: 'blue-event' }
      )
    } else if (dateTime) alert('Wrong date format.')
}
}
</script>
<style>
#cal2 {
	height: 50vh;
}
.vuecal__event {cursor: pointer;}

.vuecal__event-title {
  font-size: 1.2em;
  font-weight: bold;
  margin: 4px 0 8px;
}

.vuecal__event-time {
  display: inline-block;
  margin-bottom: 12px;
  padding-bottom: 12px;
  border-bottom: 1px solid rgba(0, 0, 0, 0.2);
}

.vuecal__event-content {
  font-style: italic;
}
</style>
