<template>
	<b-container fluid >

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
							striped
							sticky-header="41.5rem"
							head-variant="light"
						>
							<!-- :variant="row.item.status ? 'success' : 'danger'" -->
							<template #cell(name)="row">
								<!-- `data.value` is the value after formatted by the Formatter -->
								<nuxt-link :to="`/patients/${row.item.id}`">
								<img :src="row.item.image" alt class="thumb-sm rounded-circle mr-2" />
								{{ row.item.name }}</nuxt-link>
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

export default {
	async asyncData({ $axios, app, store }) {
		await store.dispatch("loadData");

		// this.$store.dispatch('loadData', 'DONE');
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
		};
	},
	methods: {
		patientName(id) {
			let patient = this.$store.state.patients.find(
				(patient) => patient.id === id
			);
			return patient.name;
		},

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
		patient(appointment) {
			console.log(this.patients);
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

// searchTreatments() {
//       return this.getTreatments.filter((treat) => {
//         return (
//           treat.patientName
//             .toLowerCase()
//             .includes(this.searchQuery.toLowerCase()) ||
//           treat.description
//             .toLowerCase()
//             .includes(this.searchQuery.toLowerCase())
//         );
//       });
//     },
</script>
 