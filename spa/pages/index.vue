<template>
	<b-container fluid>

		<b-row class="mt-3">
			<b-col>
				<b-row>
					<b-col cols="3">
						<b-card title="All Patients">
							<b-input-group class="mb-3">
										<b-input-group-prepend is-text>
											<!-- <input type="checkbox" aria-label="Checkbox for following text input"> -->
											<i class="fas fa-search"></i>
										</b-input-group-prepend>
										<b-form-input v-model="searchQuery" aria-label="Text input with checkbox"></b-form-input>
									</b-input-group>
						</b-card>
					</b-col>
					<b-col cols="9">
						
						<b-card title="Appointments">
							
										<search-comp
										:input="true"
										:date="true"
										:pagination="false"
										url="/appointments/"
										moduleState="APPOINTMENTS"
									></search-comp>
						</b-card>
					</b-col>
				</b-row>
				
			</b-col>
		</b-row>
		<b-row>
			<b-col lg="3">
				<b-card style="height:44.3rem;">
					
					<b-table
							:items="colPatients"
							:fields="fields"
							primary-key="id"
							striped
							selectable
							sortable
							sticky-header="41.5rem"
							head-variant="light"
							draggable="true"
							@dragstart='onEventDragStart($event, item)'
							
							>
						>
							<!-- :variant="row.item.status ? 'success' : 'danger'" -->
							<!-- <template #cell(name)="row" @drag="onEventDragStart($event, items)"> -->
								
							<template 
							#cell(name)="row" 
							
							>
							<div 
       
        					draggable="true"
        					@dragstart="onEventDragStart($event, row.item)">
							<!-- <draggable v-model="colPatients" tag="tr" :move="trigEvent"> -->
								<!-- `data.value` is the value after formatted by the Formatter -->
								<nuxt-link :to="`/patients/${row.item.id}`" >
								
    

								<img :src="row.item.image" alt class="thumb-sm rounded-circle mr-2" />
								{{ row.item.name }}</nuxt-link>
								</div>
							</template>
							
							<!-- <template
								#cell(status)="row"
								cellVariant="danger"
							>{{ row.item.status ? 'Active' : 'Inactive'}}</template> -->
						</b-table>
						
				</b-card>
			</b-col>
			<b-col lg="9">
				<b-card>
					<b-row>
						<b-col md="12">
							<b-tabs content-class="mt-3" justified>
    <b-tab @click="activeView = 'day'" title="Calendar" active><p>
		<!-- :time-cell-height="60"  -->
		<!-- //2018-11-19" -->
							<vue-cal
								ref="vuecal"
								:small="true"
								:selected-date="date_today" 
								:time-from="1 * 60"
								:time-to="21 * 60"
								:timeStep="120"
								:timeCellHeight="90"
								:active-view="activeView"
								:todayButton="true"
								:snapToTime="30"
								:watchRealTime="true"
								:startWeekOnSunday="true"
								@event-duration-change="onEventDurationChange"
								:on-event-click="onEventClick"
								:editable-events="{ title: false, drag: true, resize: true, delete: true, create: true }"
								:events="appToCalendar"
								:onEventDblclick="onEventDoubleClick"
								@event-drop="onEventDrop"
								@event-drag-create="showEventCreationDialog = true"
								@cell-focus="selectedDate = $event"
								
								
							>

<!-- :stickySplitLabels="true" -->



							<!-- <template v-slot:title="{title, view}"> -->
							
							<!-- :clickToNavigate="true" -->
							<!-- :on-event-click -->
							<!-- <template v-slot:time-cell="{ hours, minutes }">
    <div :class="{ 'vuecal__time-cell-line': true, hours: !minutes }">
      <strong v-if="!minutes" style="font-size: 15px">{{ hours }}</strong>
      <span v-else style="font-size: 11px">{{ minutes }}</span>
    </div>
  </template> -->
							</vue-cal>
							<b-modal
							variant="primary"
							size="lg"
							ref="p-appointment-modal"
							hide-footer
							title="Add a new Appointment"
						>
							<add-new-appointment
								@hidePatientAppointmentModal="hidePatientAppointmentModal"
								:patientID="selectedID"
								:appointmentID="appointmentID"
								:editDate="editDate"
								:editTime="editTime"
								:edit="edit"
								
							></add-new-appointment>
								
    					</b-modal>
		
		</p></b-tab>
    <!-- <b-tab :title="secondTabTitle ? selectedEvent.title : 'No patient selected'" lazy> -->
    <b-tab @click="swichView" title="Today's Appointments" lazy>
		<b-row>
			<b-col>
				<!-- :active-view="activeView" -->
				<vue-cal
					
					
					
					
					
					:events="appToCalendar"
					:disable-views="['week', 'years', 'year', 'month']"
					:selected-date="selectedDate"
					class="vuecal--blue-green"

					
					:active-view.sync="activeView"
					ref="vuecal-day"
					:small="true"
					:time-from="1 * 60"
					:time-to="21 * 60"
					:timeStep="120"
					:timeCellHeight="90"
					:snapToTime="30"
					:watchRealTime="true"
					:startWeekOnSunday="true"
					@event-duration-change="onEventDurationChange"
					:on-event-click="onEventClick"
					:editable-events="{ title: false, drag: true, resize: true, delete: true, create: true }"
					:onEventDblclick="onEventDoubleClick"
					@event-drop="onEventDrop"
					@event-drag-create="showEventCreationDialog = true"
					@cell-focus="selectedDate = $event"
					@cell-click="selectedPatient = null"














					
					>
				</vue-cal>
			</b-col>
			<b-col v-if="selectedPatient">
				<b-card no-body class="overflow-hidden">
    <b-row no-gutters >
      <b-col md="6">
        <b-card-img :src="selectedPatient.image" alt="Image" class="larger-thumb thumb-xl rounded-circle my-3 ml-3"></b-card-img>
      </b-col>
      <b-col md="6">
        
        <b-card-body :title="selectedPatient.name">
          <b-card-text>
			  <p><strong>Phone: </strong>{{selectedPatient.phone}}</p>
            This is a wider card with supporting text as a natural lead-in to additional content.
            This content is a little bit longer.
          </b-card-text>
        </b-card-body>
      </b-col>
    </b-row>
  </b-card>
				<div class="accordion" role="tablist">
    
	 <b-card no-body class="mb-1">
      <b-card-header header-tag="header" class="p-1" role="tab">
        <b-button block v-b-toggle.accordion-2 variant="info">Treatments</b-button>
      </b-card-header>
      <b-collapse id="accordion-2" accordion="my-accordion" role="tabpanel">
        <b-card-body>
          <treatment-activity :patient="selectedPatient"></treatment-activity>
        </b-card-body>
      </b-collapse>
    </b-card>
	<b-card no-body class="mb-1">
      <b-card-header header-tag="header" class="p-1" role="tab">
        <b-button block v-b-toggle.accordion-1 variant="info">Clinical Examinations</b-button>
      </b-card-header>
      <b-collapse id="accordion-1"  accordion="my-accordion" role="tabpanel">
        <!-- visible -->
		<b-card-body>
          <clinical-alias
						:examinations="selectedPatient ? selectedPatient.examinations : '?'"
						
					></clinical-alias>
        </b-card-body>
      </b-collapse>
    </b-card>
    <b-card no-body class="mb-1">
      <b-card-header header-tag="header" class="p-1" role="tab">
        <b-button block v-b-toggle.accordion-3 variant="info">Accordion 3</b-button>
      </b-card-header>
      <b-collapse id="accordion-3" accordion="my-accordion" role="tabpanel">
        <b-card-body>
          <b-card-text><pre>{{ patientVisits(selectedPatient.id) }}</pre></b-card-text>
        </b-card-body>
      </b-collapse>
    </b-card>
  </div>
			</b-col>
		</b-row>
	</b-tab>
    <b-tab title="Very, very long title"><p>I'm the tab with the very, very long title</p></b-tab>
    <b-tab title="Disabled" disabled><p>I'm a disabled tab!</p></b-tab>
  </b-tabs>





							
						</b-col>
					</b-row>
					
							<!-- <appointments-calendar :appointments="appointments"></appointments-calendar> -->
				<!--	<b-row>
					<b-col>

						
					<b-table
							:items="appointments"
							:fields="appointmentsFields"
							striped
							sticky-header="54.5rem"
							head-variant="light"
						>
							:variant="row.item.status ? 'success' : 'danger'"
							
							<template #cell(patientName)="row">
								`data.value` is the value after formatted by the Formatter
								<nuxt-link :to="`/patients/${row.item.patient}`">
									<img :src="patient(row.item).image" alt class="thumb-sm rounded-circle mr-2" />
												{{ patient(row.item).name }}
								
								
								</nuxt-link>
							</template>
							<template #cell(date)="row">
								{{$moment(row.item.date).format("DD/MM/yyyy")}}
							</template>
							<template #cell(time)="row">
								{{$moment(row.item.date).format("hh:mm A")}}
							</template>
							<template #cell(actions)="row">
								<a @click="showModal(true,row.item)" class="mr-2">
									<i class="fas fa-edit text-info font-16"></i>
								</a>
								<a @click="confirmDelete(row.item.name,row.item.id)">
									<i class="fas fa-trash-alt text-danger font-16"></i>
								</a>
							</template>
						</b-table>
						</b-col>
		</b-row>
		 			
						<b-row>
									<b-col md="6">Showing {{currentPage}} of {{numPages}} entries</b-col>
									<b-col md="6">
										<b-pagination
											v-model="currentPage"
											@input="retreiveDataForPage(currentPage)"
											:total-rows="getAppointments.count"
											per-page="10"
										></b-pagination>
									</b-col>
								</b-row>-->
						
				</b-card>
							
</b-col>
					</b-row>
		
	</b-container>
	<!-- container -->
</template>

<script>
// import { PerfectScrollbar } from "vue2-perfect-scrollbar";
import { store, mutations } from "../store/utils/conf";
// import PdfViewer from "vue-pdf-app";
import { mapGetters, mapMutations } from "vuex";
import draggable from 'vuedraggable';
import VueCal from 'vue-cal';
// import AddNewappointment from './patients/AddNewAppointment';
import 'vue-cal/dist/vuecal.css'
import ClinicalAlias from '../components/patients/tabs/aliases/clinicalAlias.vue';

export default {
	async asyncData({ $axios, app, store }) {
		await store.dispatch("loadData");

		let appointmentsResponse = await $axios.$get('/appointments/?page_size=100')
      	let patientsResponse = await $axios.$get('/patients/?page_size=100')

      const [appResponse, patResponse] = await Promise.all([appointmentsResponse, patientsResponse])

      // console.log(catResponse);
      // console.log(tagResponse);

      return {
        appointmentsTest: appResponse.results,
        patients: patResponse.results
      }

		// this.$store.dispatch('loadData', 'DONE');
	},
	components: {
		 draggable,
		 VueCal,
	},
	data() {
		return {
			text: `
					Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry
					richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor
					brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon
					tempor, sunt aliqua put a bird on it squid single-origin coffee nulla
					assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore
					wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher
					vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic
					synth nesciunt you probably haven't heard of them accusamus labore VHS.
					`,
			examinations: [],
			selectedPatient: null,
      		
			// LEFT TABLE DATA
			fields: ["name"],
			appointmentsFields: ['patientName', 'description', 'date', 'time', 'actions'],
			nameDelete: "",
			idDelete: "",
			date_today: new Date(),
			selectedDate: '',

			// allAppointments: [],
			link: "",
			searchQuery: "",
			url: "",
			currentPage: 1,
			events: [],
			tabIndex: 0,
			secondTabTitle: false,
// 			[
//     {
//       start: '2020-11-20 14:00',
//       end: '2018-11-20 18:00',
//       title: 'Need to go shopping',
//       icon: 'shopping_cart', // Custom attribute.
//       content: 'Click to see my shopping list',
//       contentFull: 'My shopping list is rather long:<br><ul><li>Avocados</li><li>Tomatoes</li><li>Potatoes</li><li>Mangoes</li></ul>', // Custom attribute.
//       class: 'leisure'
//     },
//     {
//       start: '2020-11-22 10:00',
//       end: '2018-11-22 15:00',
//       title: 'Golf with John',
//       icon: 'golf_course', // Custom attribute.
//       content: 'Do I need to tell how many holes?',
//       contentFull: 'Okay.<br>It will be a 18 hole golf course.', // Custom attribute.
//       class: 'sport'
//     }
//   ],
		selectedID: '',
		activeView: 'day',
		appointmentID: '',
		editDate: '',
		editTime: '',
		edit: false,
		showEventCreationDialog: false,
			};
		},
	methods: {
		swichView() {
			// this.$refs["vuecal-day"].switchView('day', new Date())
			// this.$refs["p-appointment-modal"].hide();
		},
	onEventClick (event, e) {
	//   this.$emit('select-menu-item',event, e)
	this.selectedPatient = this.patientsData.results.find(p=>p.id===event.patient)
	// this.examinations = selectedPatient.examinations;
	this.selectedEvent = event
	
	// this.secondTabTitle = true;
	// this.showDialog = true
	console.log(this.selectedEvent)

    // Prevent navigating to narrower view (default vue-cal behavior).
    e.stopPropagation()
  },
  selectTabEvent() {
	  this.secondTabTitle = false;
  },
  

//   customEventCreation (event) {
// 	  console.log('create event', event)
//     const dateTime = prompt('Create event on (YYYY-MM-DD HH:mm)', '2020-12-01 13:15')
//     this.showPatientAppointmentModal()

//     // Check if date format is correct before creating event.
//     if (/^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$/.test(dateTime)) {
//       this.$refs.vuecal.createEvent(
//         // Formatted start date and time or JavaScript Date object.
//         dateTime,
//         // Event duration in minutes (Integer).
//         120,
//         // Custom event props (optional).
//         { title: 'New Event', content: 'yay! 🎉', class: 'blue-event' }
//       )
//     } else if (dateTime) alert('Wrong date format.')
// },

		onEventDragStart (e, item) {
	  console.log('e');
			
      // Passing the event's data to Vue Cal through the DataTransfer object.
      e.dataTransfer.setData('event', JSON.stringify(item))
	  e.dataTransfer.setData('cursor-grab-at', e.offsetY)
	  console.log(item);
	},
	// EVENT DROP
	onEventDrop ({ event, originalEvent, external }, deleteEvent) {
      // If the event is external, delete it from the data source on drop into Vue Cal.
	  // If the event comes from another Vue Cal instance, it will be deleted automatically in there.
	
	// this.deleteEventFunction = deleteEvent

	// event.title = event.name;
	

      if (external) {
		  let data = {
			  patient: event.id,
			  title: event.name,
			  description: '',
			  date: this.$moment(event.startDate).format('yyyy-MM-DDTHH:mm')
		  }
		  console.log('inspect date before submit: ', data)
		  this.$store.dispatch('addAppointment', data)


		
			// event.title = event.name;
		
      } else {

		  let data = {
			  id: event.id,
			  patient: event.patient,
			  title: event.title,
			  description: '',
			  date: this.$moment(event.startDate).format('yyyy-MM-DDTHH:mm'),
			  date_to: this.$moment(event.endDate).format('yyyy-MM-DDTHH:mm')
		  }
		   this.$store.dispatch('editAppointment', data)


		//   let thisEvent = this.events.find(ev=>ev.id===event.id);
		//  let findEventIndex = this.events.indexOf(thisEvent.id) 
		//   this.events.splice(findEventIndex, 1, event)
	  }
	},
	onEventDurationChange(event) {
		// console.log(event.event);
		let data = {
			  id: event.event.id,
			  patient: event.event.patient,
			  title: event.event.title,
			  description: event.event.content,
			  date: this.$moment(event.event.startDate).format('yyyy-MM-DDTHH:mm'),
			  date_to: this.$moment(event.event.endDate).format('yyyy-MM-DDTHH:mm')
		  }
		   this.$store.dispatch('editAppointment', data)
	},
	deleteEvent(event) {
		let id = event.id
		this.$store.dispatch('onDeleteAppointment', id);
	},
	scrollToCurrentTime () {
  		const calendar = document.querySelector('#vuecal .vuecal__bg')
  		const hours = this.now.getHours() + this.now.getMinutes() / 60
  		calendar.scrollTo({ top: hours * this.timeCellHeight, behavior: 'smooth' })
},
	onEventDoubleClick (event, e) {
	//   this.$emit('select-menu-item',event, e)
	//   console.log('this.events: ',this.events)
	//   console.log('e: ',e)
	//   console.log('event: ',event)
	  let ev = this.events.find(evt=>evt.id===event.id);
	//   console.log('ev: ',ev)

	this.selectedEvent = event
	if(ev.id){
	this.appointmentID = ev.id;
	this.selectedID = ev.patient
	this.editDate = this.$moment(ev.start).format('yyyy-MM-DD')
	// this.editDate = ev.start;
	this.editTime = this.$moment(ev.start).format('hh:mm')
	this.edit = true;
	}
	
    this.showPatientAppointmentModal()

    // Prevent navigating to narrower view (default vue-cal behavior).
    e.stopPropagation()
  },
	showPatientAppointmentModal() {
			// this.hideSelectPatientModal();
			this.$refs["p-appointment-modal"].show();
			// this.selectedID = '';
		},
	hidePatientAppointmentModal() {
		this.$refs["p-appointment-modal"].hide();
    },
	onEventCreate (event, deleteEventFunction) {
	
	this.selectedEvent = event
	console.log(this.selectedEvent)
	this.showPatientAppointmentModal()
    // this.showEventCreationDialog = true
    this.deleteEventFunction = deleteEventFunction

    return event
  },
// 	whenDragStart(event, item) {
// 		console.log(item);
// 	},
// 	startDrag: (evt, item) => {
// 		console.log(evt)
//     //   evt.dataTransfer.dropEffect = 'move'
//     //   evt.dataTransfer.effectAllowed = 'move'
//     //   evt.dataTransfer.setData('itemID', item.id)
// },

		openPdf(url) {
			// var page = url.substring(url.lastIndexOf('/') + 1);
			// let link = `../..${url.substring(url.indexOf("/", 10))}`;
			// console.log(link);
			this.url = url;
			mutations.togglePdfModal();
		},
		confirmDelete(name, id) {
			(this.nameDelete = name),
				(this.idDelete = id),
				mutations.toggleConfirmDelete();
		},
		calculatePagesCount(pageSize, totalCount) {
			// we suppose that if we have 0 items we want 1 empty page
			return totalCount < pageSize ? 1 : Math.ceil(totalCount / pageSize);
		},
		retreiveDataForPage(page) {
			this.currentPage = page;
			let data = {
				param: `?page=${page}`,
				module: "APPOINTMENTS",
			};
			this.$store.dispatch("onChangePagination", data);
		},
		patient(appointment) {
			// console.log(this.patients);
			let patient = this.patients.find(
				(p) => p.id === appointment.patient
			);

			return patient;
		},
		lastObject(arr) {
			return arr[arr.length - 1];
		},
		patientVisits(id) {
			let today = new Date()
			
			const pApps = this.getAllAppointments.filter((appt) =>{
				appt.patient === id
			});
			console.log(this.getAllAppointments)
			return pApps;

		},
	},
	computed: {
		searchAppointments() {
			return this.getAppointments.filter((appt) => {
				return (
					appt.patientName
						.toLowerCase()
						.includes(this.searchQuery.toLowerCase()) ||
					appt.description
						.toLowerCase()
						.includes(this.searchQuery.toLowerCase())
				);
			});
		},

		

		isConfirmDeleteOpen() {
			return store.isConfirmDeleteOpen;
		},
		numUsers() {
			return this.$store.state.users.length;
		},
		numTreatments() {
			return this.$store.state.treatments.length;
		},
		numPatients() {
			return this.$store.state.patients.length;
		},
			numPages() {
			let count = this.getAppointments.count;
			let pages = this.calculatePagesCount(10, count);
			return pages;
		},
		// patients() {
		// 	return this.patientsData.results;
		// },
		// appointments() {
		// 	return this.getAppointments.results;
		// },
		colPatients() {
			// console.log(this.patients)
			return this.patients.filter((patient) => {
				return patient.name
					.toLowerCase()
					.includes(this.searchQuery.toLowerCase());
			});
			// return picked;
		},
		appToCalendar: {
			get() {
				let calEv = [];
			// console.log(this.getAllAppointments)
			// this.getAppointments.results.forEach(app=>{
			// this.allAppointments.forEach(app=>{
			this.getAllAppointments.forEach(app=>{
				let evt = {};
				evt.id= app.id;
				evt.patient= app.patient;
				evt.title = app.title;
      			evt.start = app.start;
      			evt.end = app.end;
      			evt.content = app.description;
				// evt.class = 'sport'
				calEv.push(evt)
				});
				return calEv;
			},
			set(newValue) {
				console.log('new value', newValue)
			}
				
				// let patient = this.patientsData.results.find(p=>p.id===app.patient);
				
				// console.log(app.title, ': ', app.startDate, ' | ', app.endDate)
				// console.log(typeof app.startDate)

				// evt.startDate = new Date(app.startDate);
				// evt.endDate = new Date(app.endDate);
				
				// evt.endTimeMinutes = Math.floor(math.abc(new Date()))
				// evt.startTimeMinutes = Math.floor(Math.abs(evt.startDate.getHours() * 60) + Math.abs(evt.startDate.getMinutes()))
				// evt.endTimeMinutes = Math.floor(Math.abs(evt.endDate.getHours() * 60) + Math.abs(evt.endDate.getMinutes()))
				// var minutes = Math.floor(millis / 60000)

				// evt.start= this.$moment(app.date).format('yyyy-MM-DD HH:mm');
				// evt.end= this.$moment(app.date).add(3600, 'seconds').format('yyyy-MM-DD hh:mm');
				// evt.end= this.$moment(app.date_to).format('yyyy-MM-DD HH:mm');

				

      			
      			// evt.contentFull: 'Okay.<br>It will be a 18 hole golf course.', // Custom attribute.
				  

				//   this.events.push(evt)
				  
				  
			
			// console.log(calEv)
			
			
		},
		...mapGetters([
			"isAuthenticated",
			"loggedInUser",
			"getAllAppointments",
			// "getTreatments",
			"getAppointments",
			"patientsData",
		]),
	},
	// mounted() {
	// 	let calEvents = [];
	// 		this.getAppointments.results.forEach(app=>{
	// 			let evt = {};
	// 			let patient = this.patientsData.results.find(p=>p.id===app.patient);
	// 			evt.id= app.id;
	// 			evt.patient= app.patient;
	// 			evt.start= this.$moment(app.date).format('yyyy-MM-DD hh:mm');
	// 			// evt.end= this.$moment(app.date).add(3600, 'seconds').format('yyyy-MM-DD hh:mm');
	// 			evt.end= this.$moment(app.date_to).format('yyyy-MM-DD hh:mm');

    //   			evt.title = app.title;
    //   			evt.icon = patient.image; // Custom attribute.
    //   			evt.content = app.description;
    //   			// evt.contentFull: 'Okay.<br>It will be a 18 hole golf course.', // Custom attribute.
	// 			  evt.class = 'sport'
	// 			  this.events.push(evt)
	// 			  calEvents.push(evt)
	// 		});
			
	// 		// console.log(this.events)
	// },
	watch: {
		calEvents() {
			let calEv = [];
			this.getAppointments.results.forEach(app=>{
				let evt = {};
				let patient = this.patientsData.results.find(p=>p.id===app.patient);
				evt.id= app.id;
				evt.patient= app.patient;
				evt.start= this.$moment(app.date).format('yyyy-MM-DD hh:mm');
				// evt.end= this.$moment(app.date).add(3600, 'seconds').format('yyyy-MM-DD hh:mm');
				evt.end= this.$moment(app.date_to).format('yyyy-MM-DD hh:mm');

      			evt.title = app.title;
      			evt.icon = patient.image; // Custom attribute.
      			evt.content = app.description;
      			// evt.contentFull: 'Okay.<br>It will be a 18 hole golf course.', // Custom attribute.
				  evt.class = 'sport'
				  this.events.push(evt)
				  calEv.push(evt)
			});
			return calEv;
		}
	}
};

</script>
<style>
@import 'vue-cal/dist/vuecal.css';

#cal2 {
	/* height: 70vh; */
}
.vuecal__event {
	cursor: pointer;
	
	border-bottom: 1px solid rgba(0, 0, 0, 0.2);
}

.vuecal__event-title {
  font-size: .7rem;
  color: rgb(20, 137, 247);
  /* font-weight: bold; */
  margin: 0;
}

.vuecal__event-time {
  font-size: .7rem;
  display: inline-block;
  margin-bottom: .4em;
  margin-top: -4px;
  padding-bottom: 12px;
  /* border-bottom: 1px solid rgba(0, 0, 0, 0.2); */
}
.vuecal span {
  font-size: 1em;
  /* display: inline-block; */
  margin-bottom: 12px;
  margin-top: -4px;
  padding-bottom: 12px;
  /* border-bottom: 1px solid rgba(0, 0, 0, 0.2); */
}

.vuecal__event-content {
  font-style: italic;
}

.vuecal--blue-theme .vuecal__event {
	display: flex;
	background-color: #DCDCDC;
	justify-content: space-around;
	align-items: center;
}
.vuecal--blue-theme .vuecal__event .vuecal__event-title,
.vuecal--blue-theme .vuecal__event .vuecal__event-time,
.vuecal--blue-theme .vuecal__event .vuecal__event-time {
	margin-top: 0;
  padding-bottom: 0;
  font-weight: 400;
  font-size: 1rem;
}
.vuecal__view-btn .vuecal__view-btn--active {
	border-bottom: 0;
}

.larger-thumb {
	width: 8rem;
	height: 8rem;
}


</style>
 