<template>
  <div class="container-fluid">
    
    <ModalSelectPatient  @selectPatient="selectPatient($event)"/>
    <modal-treatment :patientID="editPatient" />

    <!-- Page-Title -->
    <div class="row">
      <div class="col-sm-12">
        <div class="page-title-box">
          <div class="float-right">
            <ol class="breadcrumb">
              <li class="breadcrumb-item">
                <nuxt-link to="/">Home</nuxt-link>
              </li>
              <li class="breadcrumb-item">Appointments</li>
            </ol>
            <!--end breadcrumb-->
          </div>
          <!--end /div-->
          <h4 class="page-title">All Treatments</h4>
        </div>
        <!--end page-title-box-->
      </div>
      <!--end col-->
    </div>
    <!--end row-->
    <!-- end page title end breadcrumb -->
    <div class="">
     
    </div>
    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-body card-body__modal">
            <!-- @click="showModal(false)" -->
            
<button 
                                                    @click="showSelectPatientModal()"
                                                    type="button" 
                                                    class="btn btn-primary btn-outline-white px-4 mt-0 mb-3">
                                                        <i class="mdi mdi-plus-circle-outline mr-2"></i>Add New Treatment
                                                    </button>
                                                    <b-modal
                                                        variant="primary"
                                                        size="lg"
                                                        ref="p-select-patient-modal"
                                                        hide-footer
                                                        title="Select Your Patient">

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
                                                    class="btn btn-primary btn-outline-white px-4 mt-0 mb-3 float-right">
                                                        <i class="mdi mdi-plus-circle-outline mr-2"></i>Add New Treatment
                                                    </button>
                                                       
                                                      </b-modal>






                                                   
                                                    <b-modal
                                                        variant="primary"
                                                        size="lg"
                                                        ref="p-treatment-modal"
                                                        hide-footer
                                                        title="Add a new treatment">
                                                        <add-new-treatment 
                                                        @hidePatientTreatmentModal="hidePatientTreatmentModal" 
                                                        :patientID="selectedID"
                                                        ></add-new-treatment>
                                                      </b-modal>
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            <button
              type="button"
              @click="selectPatientModal"
              data-toggle="modal"
              data-animation="bounce"
              class="btn btn-primary btn-outline-white px-4 mt-0 mb-3"
            >
              <i class="mdi mdi-plus-circle-outline mr-2"></i>Add New Treatment
            </button>
            <button
              type="button"
              data-toggle="modal"
              data-animation="bounce"
              class="btn btn-primary btn-outline-white px-4 mt-0 mb-3"
            >
              <i class="mdi mdi-plus-circle-outline mr-2"></i>Add New Treatment
            </button>

            <div class="table-responsive">
              <div
                id="datatable_wrapper"
                class="dataTables_wrapper dt-bootstrap4 no-footer"
              >
                <search-comp
                  :input="true"
                  :date="true"
                  :pagination="false"
                  url="/treatments/"
                  moduleState="TREATMENTS" 
               ></search-comp>

                <div class="row">
                  <div class="col-sm-12">
                    <table
                      id="datatable"
                      class="table dataTable no-footer"
                      role="grid"
                      aria-describedby="datatable_info"
                    >
                      <thead class="thead-light">
                        <tr role="row">
                          <th
                            class="sorting_asc"
                            tabindex="0"
                            aria-controls="datatable"
                            rowspan="1"
                            colspan="1"
                            aria-sort="ascending"
                            aria-label="User Name: activate to sort column descending"
                            style="width: 201px"
                          >
                            Patient Name
                          </th>
                         
                          <th
                            class="sorting"
                            tabindex="0"
                            aria-controls="datatable"
                            rowspan="1"
                            colspan="1"
                            aria-label="Address: activate to sort column ascending"
                            style="width: 207px"


                            
                          >
                            Title
                          </th>
                          <th
                            class="sorting"
                            rowspan="1"
                            colspan="1"
                          >
                            Description
                          </th>
                          
                          <th
                            class="sorting"
                            tabindex="0"
                            aria-controls="datatable"
                            rowspan="1"
                            colspan="1"
                            aria-label="Last Visit: activate to sort column ascending"
                            style="width: 100px"
                          >
                            Date
                          </th>
                          
                          <th
                            class="text-right sorting"
                            tabindex="0"
                            aria-controls="datatable"
                            rowspan="1"
                            colspan="1"
                            aria-label="Action: activate to sort column ascending"
                            style="width: 78px"
                          >
                            Action
                          </th>
                        </tr>
                        <!--end tr-->
                      </thead>
<!-- <pre>{{users}}</pre> -->
                      <tbody>
                        <tr
                          role="row"
                          class="odd"
                          v-for="treat in treatments"
                          :key="treat.id"
                        >
                        
                          <td class="sorting_1">
                            <nuxt-link
                              :to="`/patients/${treat.patient}`"
                              class="a-link-normal"
                            >
                              <img
                                :src="patient(treat).image"
                                alt=""
                                class="thumb-sm rounded-circle mr-2"
                              />{{ patient(treat).name }}
                            </nuxt-link>
                          </td>
                          <td>#{{ treat.title }}</td>
                          <td>{{ treat.description.substring(1, 100) + '...'  }}</td>
                          <td>{{ $moment(treat.created).format("DD-MM-yyyy") }}</td>
                         
                          <td class="text-right">
                            <a
                              @click="showModal(true, user)"
                              class="mr-2"
                              ><i class="fas fa-edit text-info font-16"></i
                            ></a>
                            <a @click="confirmDelete(user.name, user.id)"
                              ><i
                                class="fas fa-trash-alt text-danger font-16"
                              ></i
                            ></a>
                          </td>
                        </tr>
                        <ModalConfirm
                          :title="'Confirm Delete'"
                          :module="$store.state.users"
                          :moduleName="'users'"
                          :name="nameDelete"
                          :id="idDelete"
                        />
                      </tbody>
                    </table>
                  </div>
                </div>
                <b-row>
                  <b-col md="6">
                    
                      Showing {{currentPage}} of {{numPages}} entries
                      </span>
                      </b-col>
                      <b-col md="6">
                         <b-pagination
                      v-model="currentPage"
                      @input="retreiveDataForPage(currentPage)"
                      :total-rows="getTreatments.count"
                      per-page="10"
                    ></b-pagination>
                  </b-col>
                </b-row>
              </div>
            </div>
          </div>
          <!--end card-body-->
        </div>
        <!--end card-->
      </div>
      <!--end col-->
    </div>
    <!--end row-->
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import { store, mutations } from "../../store/utils/conf";


export default {
  async asyncData({ $axios, app, store }) {
    
    await store.dispatch('loadData');
    
    // this.$store.dispatch('loadData', 'DONE');
  
  },
  data() {
    return {
      nameDelete: "",
      idDelete: "",
    //   editUser: [],
      editId: "",
      editPatient: "",
      editDescription: "",
      editDate: '',
      selectedID: '',
      currentPage: 1,
    };
  },
  components: {},
  methods: {

    // showModal(modalState, data = {}) {
      selectPatient(id) {
        console.log(id)
        this.editPatient = id;
        mutations.toggleTreatment();
      },
    showModal(modalState, data = {}) {
      if (!modalState) {
        this.editId = "";
        // this.editPatient = "";
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
    selectPatientModal() {
      mutations.toggleSelectPatientModal()
    },
    confirmDelete(name, id) {
      (this.nameDelete = name),
        (this.idDelete = id),
        mutations.toggleConfirmDelete();
    },
    showPatientTreatmentModal() {
      this.hideSelectPatientModal()
      this.$refs['p-treatment-modal'].show()
      // this.selectedID = '';
    },
    hidePatientTreatmentModal() {
        this.$refs['p-treatment-modal'].hide()
    },
    showSelectPatientModal() {
      this.$refs['p-select-patient-modal'].show()
    },
    hideSelectPatientModal() {
        this.$refs['p-select-patient-modal'].hide()
    },
    calculatePagesCount(pageSize, totalCount) {
  // we suppose that if we have 0 items we want 1 empty page
  return totalCount < pageSize ? 1 : Math.ceil(totalCount / pageSize);
},
    retreiveDataForPage(page) {
      this.currentPage = page;
      let data = {
        param: `?page=${page}`,
        module: 'TREATMENTS'
      } 
      this.$store.dispatch('onChangePagination', data);
    },
    patient(treat) {
    //  console.log(treat)
    //  treat.patient ? console.log(treat.patient) : console.log('not found');
      const patient = this.patients.find(p=>p.id === treat.patient);
      // console.log(this.patients)
      return patient;
    },

},
  computed: {
    treatments() {
      console.log(this.getTreatments.results);
      return this.getTreatments.results;
    },
  
    numPages() {
      let count = this.getTreatments.count;
      let pages = this.calculatePagesCount(10, count);
      return pages;
    },
    patients() {
      return this.patientsData.results;
    },
    isAppointmentModalOpen() {
      return store.isAppointmentModalOpen;
    },
    isConfirmDeleteOpen() {
      return store.isConfirmDeleteOpen;
    },
    ...mapGetters(['getTreatments', 'patientsData'])
  },
};
</script>
<style scoped>
.showModal {
  display: none;
}
</style>
