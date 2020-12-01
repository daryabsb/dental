<template>

	<div>
    <b-row class="mb-3">
      <b-col>
        <b-button @click="customEventCreation">Add an new appointment</b-button>
       
      </b-col>
    </b-row>
    <b-row>
      <b-col>
        <div 
        class="external-event"
        v-for="(item, i) in draggables"
        :key="i"
        draggable="true"
        @dragstart="onEventDragStart($event, item)">
     <strong>{{ item.title }}</strong>
     ({{ item.duration ? `${item.duration} min` : 'no duration' }})
  <div>{{ item.content }}</div>
</div>
      </b-col>
    </b-row>
    <b-modal
							variant="primary"
							size="lg"
							ref="p-appointment-modal"
							hide-footer
							title="Add a new Appointment"
						>
		<add-new-appointment
								@hidePatientAppointmentModal="hidePatientAppointmentModal"
								
							></add-new-appointment>
              <!-- :patientID="selectedID"
                :edit="edit" -->
    </b-modal>

		<b-modal v-model="showDialog">
  <b-card>
    <b-card-title>
    
      <span>{{ selectedEvent.title }}</span>
      <strong>{{ $moment(selectedEvent.start).format('DD/MM/YYYY') && $moment(selectedEvent.start).format('DD/MM/YYYY') }}</strong>
    </b-card-title>
    <b-card-text>
      <p v-html="selectedEvent.contentFull"/>
      <strong>Event details:</strong>
      <ul>
        <li>Event starts at: {{ $moment(selectedEvent.start).format('hh:mm A') && $moment(selectedEvent.start).format('hh:mm A') }}</li>
        <li>Event ends at: {{ $moment(selectedEvent.end).format('hh:mm A') && $moment(selectedEvent.end).format('hh:mm A') }}</li>
      </ul>
    </b-card-text>
  </b-card>
</b-modal>

 <!-- <div 
        class="external-event text-pink"
        v-for="(item, i) in draggables"
        :key="i"
        draggable="true"
        @dragstart="onEventDragStart($event, item)">
     <strong>{{ item.title }}</strong>
     ({{ item.duration ? `${item.duration} min` : 'no duration' }})
  <div>{{ item.content }}</div>
</div> -->
		<vue-cal
		ref="vuecal"
		selected-date="2018-11-19"
         :time-from="12 * 60"
         :time-to="21 * 60"
         
         :editable-events="{ title: true, drag: true, resize: true, delete: true, create: true }"
         :events="events"
         :on-event-click="onEventClick"
		
		 @event-drag-create="showPatientAppointmentModal"
		 
   
		></vue-cal>
		<!-- :disable-views="['years', 'year']" -->
		<!-- @event-drop="showPatientAppointmentModal" -->
		 <!-- @event-drag-create="showEventCreationDialog = true" -->
    <!-- VUE CAL METHODS TO USE -->
     <!-- hide-weekends -->
           
	</div>
</template>
<script>
import VueCal from 'vue-cal';
// import AddNewappointment from './patients/AddNewAppointment';
import 'vue-cal/dist/vuecal.css'

export default {
  props: ['user', 'selectID', 'edit'],
	 components: { VueCal },
	 data: () => ({
  selectedEvent: {},
  showDialog: false,
  draggables: [
      {
        // The id (or however you name it), will help you find which event to delete
        // from the callback triggered on drop into Vue Cal.
        id: 1,
        title: 'Ext. Event 1',
        content: 'content 1',
        duration: 60
      },
      {
        id: 2,
        title: 'Ext. Event 2',
        content: 'content 2',
        duration: 30
      },
      {
        id: 3,
        title: 'Ext. Event 3',
        content: 'content 3'
        // No defined duration here: will default to 2 hours.
      }
    ],
  events: [
    {
      start: '2020-11-20 14:00',
      end: '2018-11-20 18:00',
      title: 'Need to go shopping',
      icon: 'shopping_cart', // Custom attribute.
      content: 'Click to see my shopping list',
      contentFull: 'My shopping list is rather long:<br><ul><li>Avocados</li><li>Tomatoes</li><li>Potatoes</li><li>Mangoes</li></ul>', // Custom attribute.
      class: 'leisure'
    },
    {
      start: '2020-11-22 10:00',
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
	//   this.$emit('select-menu-item',event, e)
	  
    this.selectedEvent = event
    this.showDialog = true

    // Prevent navigating to narrower view (default vue-cal behavior).
    e.stopPropagation()
  },

  customEventCreation (event) {
	  console.log('create event', event)
    const dateTime = prompt('Create event on (YYYY-MM-DD HH:mm)', '2020-12-01 13:15')
    this.showPatientAppointmentModal()

    // Check if date format is correct before creating event.
    if (/^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$/.test(dateTime)) {
      this.$refs.vuecal.createEvent(
        // Formatted start date and time or JavaScript Date object.
        dateTime,
        // Event duration in minutes (Integer).
        120,
        // Custom event props (optional).
        { title: 'New Event', content: 'yay! 🎉', class: 'blue-event' }
      )
    } else if (dateTime) alert('Wrong date format.')
},
showPatientAppointmentModal(status=false, id='') {
      this.edit = status;
      this.selectedID = id;
			// this.hideSelectPatientModal();
			this.$refs["p-appointment-modal"].show();
			// this.selectedID = '';
		},
		hidePatientAppointmentModal() {
			this.$refs["p-appointment-modal"].hide();
    },
    onEventDragStart (e, draggable) {
	  // Passing the event's data to Vue Cal through the DataTransfer object.
	  console.log(draggable);
      e.dataTransfer.setData('event', JSON.stringify(draggable))
      e.dataTransfer.setData('cursor-grab-at', e.offsetY)
    },
    // The 3 parameters are destructured from the passed $event in @event-drop="onEventDrop".
    // `event` is the final event as Vue Cal understands it.
    // `originalEvent` is the event that was dragged into Vue Cal, it can come from the same
    //  Vue Cal instance, another one, or an external source.
    // `external` is a boolean that lets you know if the event is not coming from any Vue Cal.
    onEventDrop ({ event, originalEvent, external }) {
      // If the event is external, delete it from the data source on drop into Vue Cal.
	  // If the event comes from another Vue Cal instance, it will be deleted automatically in there.
	  console.log('event', event)
	  console.log('original-event', originalEvent)
	  console.log('external', external)
      if (external) {
		  console.log(external);
        // const extEventToDeletePos = this.draggables.findIndex(item => item.id === originalEvent.id)
        // if (extEventToDeletePos > -1) this.draggables.splice(extEventToDeletePos, 1)
      }
	},
	onEventCreate (event, deleteEventFunction) {
	
	this.selectedEvent = event
	console.log(this.selectedEvent)
	this.showPatientAppointmentModal()
    // this.showEventCreationDialog = true
    this.deleteEventFunction = deleteEventFunction

    return event
  },
//   cancelEventCreation () {
//     this.closeCreationDialog()
//     this.deleteEventFunction()
//   },
  closeCreationDialog () {
    // this.showEventCreationDialog = false
    this.selectedEvent = {}
  },
	
},

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
