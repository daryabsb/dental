<template>
	<div class="container-fluid">
		<div class="row mt-3">
			<div class="col-lg-12">
				<div class="row">
					<div class="col-lg-4">
						<div class="card py-3">
							<div class="card-body">
								<h3 class="mt-2 mb-3">All Patients</h3>
								<div class="media">

                    <b-input-group  size="lg" class="my-3">
                        <b-input-group-prepend is-text>
                          <!-- <input type="checkbox" aria-label="Checkbox for following text input"> -->
                          <i class="fas fa-search"></i>
                        </b-input-group-prepend>
                        <b-form-input v-model="searchQuery" aria-label="Text input with checkbox"></b-form-input>
                      </b-input-group> 
									<!--end media body-->
								</div>
							</div>
							<!--end card-body-->
						</div>
						<!--end card-->
					</div>
					<!-- end col-->
					<div class="col-lg-8">
						<div class="card hospital-info">
							<div class="card-body row">
                <div class="col-12">
                  <!-- <b-form-select v-model="searchQuery" :options="dateSearchOptions" size="sm" class="mt-3"></b-form-select> -->
                <h5>Appointments</h5>
                <search-comp
                :input="true"
                :date="true"
                :pagination="false"
                  url="/appointments/"
                  moduleState="APPOINTMENTS" 
               ></search-comp>
                <!-- <b-container fluid>

                  <b-row class="my-3">
      
      <b-col sm="12">
        <b-form-input size="lg" placeholder="Search Keywords" type="search" v-model="searchQuery"></b-form-input>
      </b-col>
    </b-row>
    <b-row class="my-1">
      <b-col sm="2">
        <label>Date Select</code>:</label>
      </b-col>
      <b-col sm="5">
        <b-form-select 
       
        v-model="dateSelect" 
        :options="dateSearchOptions"
         @change="searchDate" 
        ></b-form-select>
      </b-col>
      <b-col sm="5">

        <b-form-datepicker 
        :date-format-options="{
                        year: 'numeric',
                        month: '2-digit',
                        day: '2-digit',
                      }"
       
        
          
        v-model="date_today" 
        @context="searchDate"
        size="lg"
       
        v-if="dateSelect == 'custom'">
        
        </b-form-datepicker>
      </b-col>
    </b-row>
    {{date_today}}
  </b-container> -->
                
                
                
                
                
                
                </div>
							</div>
							<!--end card-body-->
						</div>
						<!--end card-->
					</div>
					<!-- end col-->
				
				</div>
				<!--end row-->
			</div>
			<!--end col-->
		</div>
		<!--end row-->

		<div class="row">
			<!-- <v-gal  :pImages="images" :pIndex="index" /> -->

			<div class="col-lg-4">
				<div class="card" style="min-height: 59rem;">
					<div class="card-body">
						<div class="row">
							<div class="form-group col-12 row">
								<!-- <pre>{{ colPatients }}</pre> -->
								<!-- <pre>{{ patients }}</pre> -->

								<b-table
									:apiUrl="`/appointments`"
									:items="colPatients"
									:fields="fields"
									striped
									sticky-header="54.5rem"
									responsive="sm"
									head-variant="light"
								>
                <!-- :variant="row.item.status ? 'success' : 'danger'" -->
                <template #cell(name)="row">
        <!-- `data.value` is the value after formatted by the Formatter -->
        <nuxt-link :to="`/patients/${row.item.id}`">{{ row.item.name }}</nuxt-link>
      </template>
									<template #cell(status)="row"
                  
                  variant="danger"
                  >
{{ row.item.status ? 'Active' : 'Inactive'}} 
									</template>

									
								</b-table>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-lg-8">
				<div class="card" style="min-height: 59rem;">
					<div class="card-body">
						<!-- <div class="row">
							<div class="col-sm-12 mb-3">
								<h4 class="header-title mt-0 mb-3">Hospital Survey</h4>
							</div>
							<div class="form-group col-12 row">
								<div class="col-6 row">
									<label for="example-search-input" class="col-4 col-form-label text-right">Search</label>

									<div class="col-8">
										<input
											class="form-control"
											type="search"
											placeholder="Search for a treatment by patient"
											v-model="searchQuery"
										/>
									</div>
								</div>

								<div class="col-6 row">
									<label for="example-search-input" class="col-4 col-form-label text-right">Filter by Date</label>
									<div class="col-4">
										<select class="form-control" @change="searchDate" v-model="dateSelect">
											<option value="none" v-if="dateSelect !== 'none'">Clear Filter</option>
											<option selected value="today">Today</option>
											<option value="tomorrow">Tomorrow</option>
											<option value="week">This Week</option>
											<option value="month">Next Month</option>
											<option value="custom">Select a date</option>
										</select>
									</div>
									<div class="col-4">
										<input
											v-model="date_today"
											class="form-control"
											type="date"
											@change="searchDate"
											v-if="dateSelect == 'custom'"
										/>
                     
									</div>
								</div>
							</div>
						</div>
            {{date_today}} -->
						<div >
							<table id="datatable" class="table">
								<thead class="thead-light">
									<tr>
										<th>Patient Name</th>
										<th>Description</th>
										<th>Date to vist</th>
										<th>Diseases</th>
										<th class="text-right">Action</th>
									</tr>
								</thead>
								<tbody>
									<!-- <perfect-scrollbar> -->
									<tr v-for="appointment in appointments" :key="appointment.id">
										<td>
											<nuxt-link :to="`/patients/${appointment.patient}`">
												<img :src="patient(appointment).image" alt class="thumb-sm rounded-circle mr-2" />
												{{ patient(appointment).name }}
											</nuxt-link>
										</td>
										<td>{{ appointment.description }}</td>

										<td>{{ $moment(appointment.date).format("DD-MM-yyyy") }}</td>
										<td>
											<span class="badge badge-soft-danger">Cancer</span>
										</td>
										<td class="text-right">
											<a href="../hospital/patient-edit.html" class="mr-2">
												<i class="fas fa-edit text-danger font-16"></i>
											</a>

											<a
												@click="
                          confirmDelete(
                            `treatment for ${treat.patientName}`,
                            treat.id
                          )
                        "
											>
												<i class="fas fa-trash-alt text-danger font-16"></i>
											</a>
										</td>
										<ModalConfirm
											:title="'Confirm Delete'"
											:module="$store.state.treatments"
											:moduleName="'treatments'"
											:name="nameDelete"
											:id="idDelete"
										/>
										<Pdf :url="url" />
									</tr>
									<!-- </perfect-scrollbar> -->
								</tbody>
							</table>
						</div>
						<hr />
					</div>

					<!--end card-body-->
				</div>
				<!--end card-->
			</div>
		</div>
	</div>
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
		appointments(){
			return this.getAppointments.results;
		},
		colPatients() {
      
      return this.patients.filter((patient) => {
				return (
					patient.name
						.toLowerCase()
						.includes(this.searchQuery.toLowerCase())
				);
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
 