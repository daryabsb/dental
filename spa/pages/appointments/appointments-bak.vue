<template>
  <div class="container-fluid">
    <AddAppointment
      :editId="editId"
      :editPatient="editPatient"
      :editDescription="editDescription"
      :editDate="editDate"
    />

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
          <h4 class="page-title">All Appointments</h4>
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
            <button
              type="button"
              @click="showModal(false)"
              data-toggle="modal"
              data-animation="bounce"
              class="btn btn-primary btn-outline-white px-4 mt-0 mb-3"
            >
              <i class="mdi mdi-plus-circle-outline mr-2"></i>Add New Appointment
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
                url="/appointments/"
                moduleState="APPOINTMENTS" 
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
                            aria-label="ID: activate to sort column ascending"
                            style="width: 54px"
                          >
                            ID
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
                          v-for="appointment in appointments"
                          :key="appointment.id"
                        >
                        
                          <td class="sorting_1">
                            <nuxt-link
                              :to="`/patients/${appointment.patient}`"
                              class="a-link-normal"
                            >
                              <img
                                :src="patient(appointment).image"
                                alt=""
                                class="thumb-sm rounded-circle mr-2"
                              />{{ patient(appointment).name }}
                            </nuxt-link>
                          </td>
                          <td>#{{ appointment.id }}</td>
                          <td>{{ appointment.description }}</td>
                          <td>{{ $moment(appointment.date).format("DD-MM-yyyy") }}</td>
                         
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
                      :total-rows="getAppointments.count"
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
   

      await store.dispatch('loadAppointments');
   
   
  
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
       currentPage: 1,
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
