<template>
	<b-container fluid>

		<b-row class="mt-3">
			<b-col>
				<b-row>
					<b-col cols="4">
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
					<b-col cols="8">
						
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
			<b-col lg="4">
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
							
							<template
								#cell(status)="row"
								cellVariant="danger"
							>{{ row.item.status ? 'Active' : 'Inactive'}}</template>
						</b-table>
						
				</b-card>
			</b-col>
			<b-col lg="8">
				<b-card>
					<b-row>
						<b-col>
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
						</b-col>
					</b-row>
					
							<!-- <appointments-calendar :appointments="appointments"></appointments-calendar> -->
					<b-row>
					<b-col>

						
					<b-table
							:items="appointments"
							:fields="appointmentsFields"
							striped
							sticky-header="54.5rem"
							head-variant="light"
						>
							<!-- :variant="row.item.status ? 'success' : 'danger'" -->
							
							<template #cell(patientName)="row">
								<!-- `data.value` is the value after formatted by the Formatter -->
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
								</b-row>
						
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

export default {
	async asyncData({ $axios, app, store }) {
		await store.dispatch("loadData");

		// this.$store.dispatch('loadData', 'DONE');
	},
	components: {
		 draggable,
		 VueCal,
	},
	data() {
		return {
			// LEFT TABLE DATA
			fields: ["name", "status"],
			appointmentsFields: ['patientName', 'description', 'date', 'time', 'actions'],
			nameDelete: "",
			idDelete: "",
			// date_today: new Date(),

			link: "",
			searchQuery: "",
			url: "",
			currentPage: 1,
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
		};
	},
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
		trigEvent: (e)=> console.log(e.draggedContext.element.name),
		// patientName(id) {
		// 	let patient = this.$store.state.patients.find(
		// 		(patient) => patient.id === id
		// 	);
		// 	return patient.name;
		// },
		onEventDragStart (e, item) {
	  console.log('e');
			
      // Passing the event's data to Vue Cal through the DataTransfer object.
    //   e.dataTransfer.setData('event', draggable)
	//   e.dataTransfer.setData('cursor-grab-at', e.offsetY)
	  console.log(item);
	},
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
		patients() {
			return this.patientsData.results;
		},
		appointments() {
			return this.getAppointments.results;
		},
		colPatients() {
			return this.patients.filter((patient) => {
				return patient.name
					.toLowerCase()
					.includes(this.searchQuery.toLowerCase());
			});
			// return picked;
		},
		...mapGetters([
			"isAuthenticated",
			"loggedInUser",
			// "getTreatments",
			"getAppointments",
			"patientsData",
		]),
	},
};

</script>
 