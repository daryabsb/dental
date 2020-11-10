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
                            rowspan="1"
                            colspan="1"
                          >
                            Title
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
                          v-for="treat in treatments"
                          :key="treat.id"
                        >
                        
                          <td class="sorting_1">
                            <nuxt-link
                              :to="`/treatments/${treat.id}`"
                              class="a-link-normal"
                            >
                              <img
                                src="~assets/images/users/user-10.jpg"
                                alt=""
                                class="thumb-sm rounded-circle mr-2"
                              />{{ treat.patientName }}
                            </nuxt-link>
                          </td>
                          <td>#{{ treat.title }}</td>
                          <td>{{ treat.description }}</td>
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
                <div class="row">
                  <div class="col-sm-12 col-md-5">
                    <div
                      class="dataTables_info"
                      id="datatable_info"
                      role="status"
                      aria-live="polite"
                    >
                      Showing 1 to 6 of 6 entries
                    </div>
                  </div>
                  <div class="col-sm-12 col-md-7">
                    <div
                      class="dataTables_paginate paging_simple_numbers"
                      id="datatable_paginate"
                    >
                      <ul class="pagination">
                        <li
                          class="paginate_button page-item previous disabled"
                          id="datatable_previous"
                        >
                          <a
                            href="#"
                            aria-controls="datatable"
                            data-dt-idx="0"
                            tabindex="0"
                            class="page-link"
                            >Previous</a
                          >
                        </li>
                        <li class="paginate_button page-item active">
                          <a
                            href="#"
                            aria-controls="datatable"
                            data-dt-idx="1"
                            tabindex="0"
                            class="page-link"
                            >1</a
                          >
                        </li>
                        <li
                          class="paginate_button page-item next disabled"
                          id="datatable_next"
                        >
                          <a
                            href="#"
                            aria-controls="datatable"
                            data-dt-idx="2"
                            tabindex="0"
                            class="page-link"
                            >Next</a
                          >
                        </li>
                      </ul>
                    </div>
                  </div>
                </div>
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
  },
  computed: {
    treatments() {
      return this.getTreatments;
    },
    isAppointmentModalOpen() {
      return store.isAppointmentModalOpen;
    },
    isConfirmDeleteOpen() {
      return store.isConfirmDeleteOpen;
    },
    ...mapGetters(['getTreatments'])
  },
};
</script>
<style scoped>
.showModal {
  display: none;
}
</style>
