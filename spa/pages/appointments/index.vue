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
      @click="showPatientAppointmentModal()" 
      variant="outline-primary"
      class="px-4 mt-0 mb-3">
      <i class="mdi mdi-plus-circle-outline mr-2"></i>Add New Appointment</b-button>
            <!-- SELECT PATIENT MODAL -->
            <!-- <b-modal
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
								@click="showPatientAppointmentModal()"
								type="button"
								class="btn btn-primary btn-outline-white px-4 mt-0 mb-3 float-right"
							>
								<i class="mdi mdi-plus-circle-outline mr-2"></i>Select
							</button>
						</b-modal> -->
             <!-- ADD APPOINTMENT FORM MODAL -->
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
                :edit="edit"
							></add-new-appointment>

						</b-modal>

          <!-- SEARCH COMPONENT -->
            <search-comp
                :input="true"
                :date="true"
                :pagination="false"
                url="/appointments/"
                moduleState="APPOINTMENTS" 
               ></search-comp>

              <b-row>
              <b-col>
                <b-table
                :items="appointments"
								:fields="fields"
								:current-page="currentPage"
								head-variant="light"
                >
                <template #cell(patientName)="row" >
                  <nuxt-link :to="`/patients/${row.item.patient}`" >
															<img :src="patient(row.item).image" alt class="thumb-sm rounded-circle mr-2" />
															{{ patient(row.item).name }}
														</nuxt-link>
                </template>
                <template #cell(description)="row">
                  {{ row.item.description.substring(1, 150) + '...' }}
                </template>
                <template #cell(date)="row">
                  {{ $moment(row.item.date).format("DD-MM-yyyy") }}
                </template>
                 <template #cell(time)="row">
                  {{ $moment(row.item.date).format("hh:mm A") }}
                </template>
                <template #cell(actions)="row">
                 
														<a @click="showPatientAppointmentModal(true, row.item)" class="mr-2">
															<i class="fas fa-edit text-info font-16"></i>
														</a>
														<a @click="confirmDelete(patient(row.item).name, row.item.id)">
															<i class="fas fa-trash-alt text-danger font-16"></i>
														</a>
													
												<ModalConfirm
													:title="'Confirm Delete'"
													:module="$store.state.appointments"
													:moduleName="'appointments'"
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
											:total-rows="getAppointments.count"
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
  async asyncData({ app, store }) {
   

      await store.dispatch('loadAppointments');
   
  },
  data() {
    return {
      fields: [
        {
          key:'patientName',
          thStyle: 'width: 15rem;'
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
          key:'time',
          thStyle: 'width: 5rem;'
        },
        {
          key:'actions'
        },	
      ],
      crumbs: [{text: 'Home',to:"/"},{text: "Appointments"}],
      nameDelete: "",
      idDelete: "",
    //   editUser: [],
      edit: false,
      editPatient: "",
      editDescription: "",
      editDate: '',
       currentPage: 1,
       selectedID: "",
    };
  },
  components: {},
  methods: {
    showModal(modalState, data = {}) {
      if (!modalState) {
        this.editId = "";
        this.editPatient = "";
        this.editDescription = "";
        this.editDate = '';
        //this.$store.conf.actions.dispatch('showAddUserModal');
        store.isEditModal = false;
        mutations.toggleAppointmentModal();

        //this.addUserModal = !this.addUserModal;
      } else {
        this.editId = data.id;
        this.editPatient = data.patient;
        this.editDescription = data.description;
        this.editDate = data.date;

        //this.addUserModal = !this.addUserModal;
        store.isEditModal = true;
        mutations.toggleAppointmentModal();
      }
    },
    confirmDelete(name, id) {
      (this.nameDelete = name),
        (this.idDelete = id),
        mutations.toggleConfirmDelete();
    },
    patient(appointment) {
      const patient = this.patients.find(p=>p.id === appointment.patient);
      return patient;
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
        module: 'APPOINTMENTS'
      } 
      this.$store.dispatch('onChangePagination', data);
    },
  },
  computed: {
    appointments() {
      return this.getAppointments.results;
    },
    isAppointmentModalOpen() {
      return store.isAppointmentModalOpen;
    },
    isConfirmDeleteOpen() {
      return store.isConfirmDeleteOpen;
    },
    patients() {
      return this.patientsData.results;
    },
    numPages() {
      let count = this.getAppointments.count;
      let pages = this.calculatePagesCount(10, count);
      return pages;
    },
    ...mapGetters(['getAppointments', 'patientsData'])
  },
};
</script>
<style scoped>
.showModal {
  display: none;
}
</style>
