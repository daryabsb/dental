<template>
	<b-container fluid>
    <b-row>
      <b-col>
        <h4>All Treatments</h4>
      </b-col>
      <b-col float-right>
        <b-breadcrumb :items="crumbs" class="float-right" size="lg"></b-breadcrumb>
      </b-col>
    </b-row>
		
<b-row>
  <b-col>
    <b-card>
      <b-button 
      @click="showSelectPatientModal()" 
      variant="outline-primary"
      class="px-4 mt-0 mb-3">
      <i class="mdi mdi-plus-circle-outline mr-2"></i>Add New Treatment</b-button>
            <!-- SELECT PATIENT MODAL -->
            <b-modal
							variant="primary"
							size="lg"
							ref="p-select-patient-modal"
							hide-footer
							title="Select Your Patient"
						>
							<b-form-select
								v-model="selectedID"
								:options="patients"
								class="my-3"
								value-field="id"
								text-field="name"
								disabled-field="notEnabled"
							></b-form-select>

							<button
								@click="showPatientTreatmentModal()"
								type="button"
								class="btn btn-primary btn-outline-white px-4 mt-0 mb-3 float-right"
							>
								<i class="mdi mdi-plus-circle-outline mr-2"></i>Add New Treatment
							</button>
						</b-modal>
           <!-- ADD TREATMENT FORM MODAL -->
           <b-modal
							variant="primary"
							size="lg"
							ref="p-treatment-modal"
							hide-footer
							title="Add a new treatment"
						>
							<add-new-treatment
								@hidePatientTreatmentModal="hidePatientTreatmentModal"
								:patientID="selectedID"
							></add-new-treatment>
						</b-modal>
				<!-- EDIT TREATMENT FORM MODAL -->
           <b-modal
							variant="primary"
							size="lg"
							ref="e-treatment-modal"
							hide-footer
							title="Edit treatment"
						>
							<edit-treatment
								@hideModal="hideModal"
								:treatId="editId"
							></edit-treatment>
						</b-modal>

            	<search-comp
									:input="true"
									:date="true"
									:pagination="false"
									url="/treatments/"
									moduleState="TREATMENTS"
								></search-comp>

            <b-row>
              <b-col>
                <b-table
                :items="treatments"
											:fields="fields"
											:current-page="currentPage"

											head-variant="light"
                >
                <template #cell(patientName)="row" >
                  
				 
				  <nuxt-link :to="`/patients/${row.item.patient}`" >
				
						<img :src="`${patient(row.item).image}`" alt class="thumb-sm rounded-circle mr-2" />
						{{ patient(row.item).name }}
					</nuxt-link>
                </template>
                <template #cell(description)="row">
                  {{ row.item.description.substring(1, 150) + '...' }}
                </template>
                <template #cell(date)="row">
                  {{ $moment(row.item.created).format("DD-MM-yyyy") }}
                </template>
                <template #cell(actions)="row">
                 
														<!-- <a @click="showModal(true, row.item)" class="mr-2">
															<i class="fas fa-edit text-info font-16"></i>
														</a> -->
														<a @click="showModal(true, row.item)" class="mr-2">
															<i class="fas fa-edit text-info font-16"></i>
														</a>
														<a @click="confirmDelete(patient(row.item).name, row.item.id)">
															<i class="fas fa-trash-alt text-danger font-16"></i>
														</a>
													
												<ModalConfirm
													:title="'Confirm Delete'"
													:module="$store.state.treatments"
													:moduleName="'treatments'"
													:name="nameDelete"
													:id="idDelete"
												/>
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
											:total-rows="getTreatments.count"
											per-page="10"
										></b-pagination>
									</b-col>
								</b-row>


    </b-card>
  </b-col>
</b-row>

	</b-container>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import { store, mutations } from "../../store/utils/conf";

export default {
	async asyncData({ $axios, app, store }) {
		// await store.dispatch("loadData");
		console.log('TREATMENT PAGE LOADED')
		let treatmentUrl = "/treatments/";
		const allTreatments = await $axios.get(treatmentUrl);
		store.commit("GET_TREATMENTS", allTreatments.data);

		// this.$store.dispatch('loadData', 'DONE');
	},
	data() {
		return {
      fields: [
        {
          key:'patientName',
          thStyle: 'width: 15rem;'
        },
        {
          key:'title',
          thStyle: 'width: 10rem;'
        },
        {
          key:'description',
          thStyle: 'width: 40rem;'
        },
        {
          key:'date',
          thStyle: 'width: 10rem;'
        },
        {
          key:'actions'
        },	
      ],
      crumbs: [{text: 'Home',to:"/"},{text: "Treatments"}],
			nameDelete: "",
			idDelete: "",
			//   editUser: [],
			editId: "",
			editPatient: "",
			editDescription: "",
			editDate: "",
			selectedID: "",
			currentPage: 1,
		};
	},
	components: {},
	methods: {
		// showModal(modalState, data = {}) {
		selectPatient(id) {
			// console.log(id);
			this.editPatient = id;
			mutations.toggleTreatment();
		},
		showModal(modalState, data = {}) {
			// console.log('clicked')
			// if (!modalState) {
			// 	this.editId = "";
			// 	// this.editPatient = "";
			// 	this.editDescription = "";
			// 	this.editDate = "";
			// 	//this.$store.conf.actions.dispatch('showAddUserModal');
			// 	store.isEditModal = false;
			// 	mutations.toggleAppointmentModal();

			// 	//this.addUserModal = !this.addUserModal;
			// } else {
				this.editId = data.id;
				this.editPatient = data.patient;
				this.editDescription = data.description;
				this.editDate = data.date;

				//this.addUserModal = !this.addUserModal;
				store.isEditModal = true;
				this.$refs["e-treatment-modal"].show()
				// this.showPatientTreatmentModal();
			// }
		},
		hideModal() {
			this.$refs["e-treatment-modal"].hide()
		},
		selectPatientModal() {
			mutations.toggleSelectPatientModal();
		},
		confirmDelete(name, id) {
			(this.nameDelete = name),
				(this.idDelete = id),
				mutations.toggleConfirmDelete();
		},
		showPatientTreatmentModal(id="") {
			this.hideSelectPatientModal();
			
			this.$refs["p-treatment-modal"].show();
			
		},
		hidePatientTreatmentModal() {
			this.$refs["p-treatment-modal"].hide();
			this.selectedID = '';

		},
		showSelectPatientModal() {
			this.$refs["p-select-patient-modal"].show();
		},
		hideSelectPatientModal() {
			this.$refs["p-select-patient-modal"].hide();
		},
		calculatePagesCount(pageSize, totalCount) {
			// we suppose that if we have 0 items we want 1 empty page
			return totalCount < pageSize ? 1 : Math.ceil(totalCount / pageSize);
		},
		retreiveDataForPage(page) {
			this.currentPage = page;
			let data = {
				param: `?page=${page}`,
				module: "TREATMENTS",
			};
			this.$store.dispatch("onChangePagination", data);
		},
		patient(treat) {
			
			//  console.log("patients",this.patientsData)
			//  console.log("id",id)
			//  treat.patient ? console.log(treat.patient) : console.log('not found');
			
			const patient = this.patientsData.results.find(p => p.id === treat.patient);
			
			
			return patient;
		},
	},
	computed: {
		treatments() {
			// console.log(this.getTreatments.results);
			return this.getTreatments.results;
		},

		numPages() {
			let count = this.getTreatments.count;
			let pages = this.calculatePagesCount(10, count);
			return pages;
		},
		patients() {
			// return this.patientsData.results;
			return this.colPatients;
		},
		isAppointmentModalOpen() {
			return store.isAppointmentModalOpen;
		},
		isConfirmDeleteOpen() {
			return store.isConfirmDeleteOpen;
		},
		...mapGetters(["getTreatments", "patientsData", "colPatients", "allPatients"]),
	},
};
</script>
<style scoped>
.showModal {
	display: none;
}
</style>
