<template>
  <div class="container-fluid">
    <AddUser
      :editId="editId"
      :editName="editName"
      :editEmail="editEmail"
      :editIsStaff="editIsStaff"
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
              <li class="breadcrumb-item">Users</li>
            </ol>
            <!--end breadcrumb-->
          </div>
          <!--end /div-->
          <h4 class="page-title">All Users</h4>
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
              <i class="mdi mdi-plus-circle-outline mr-2"></i>Add New User
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
                <div class="row">
                  <div class="col-sm-6 col-md-3">
                    <div class="dataTables_length" id="datatable_length">
                      <label
                        >Show
                        <select
                          name="datatable_length"
                          aria-controls="datatable"
                          class="custom-select custom-select-sm form-control form-control-sm"
                        >
                          <option value="10">10</option>
                          <option value="25">25</option>
                          <option value="50">50</option>
                          <option value="100">100</option>
                        </select>
                        entries</label
                      >
                    </div>
                  </div>
                  <div class="col-sm-6 col-md-8">
                    <div id="datatable_filter" class="dataTables_filter">
                      <label style="display: inline;"
                        >Search: <input
                        style="margin-right:10px;"
                          type="search"
                          class="form-control form-control-sm"
                          placeholder=""
                      />
                        </label>
                    </div>
                  </div>
                </div>
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
                            User Name
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
                            Email
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
                            Created At
                          </th>
                          <th
                            class="sorting"
                            tabindex="0"
                            aria-controls="datatable"
                            rowspan="1"
                            colspan="1"
                            aria-label="Status: activate to sort column ascending"
                            style="width: 78px"
                          >
                            Is Admin
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
                          v-for="user in users"
                          :key="user.id"
                        >
                        
                          <td class="sorting_1">
                            <nuxt-link
                              :to="`/users/${user.id}`"
                              class="a-link-normal"
                            >
                              <img
                                :src="user.image"
                                alt=""
                                class="thumb-sm rounded-circle mr-2"
                              />{{ user.name }}
                            </nuxt-link>
                          </td>
                          <td>#{{ user.id }}</td>
                          <td>{{ user.email }}</td>
                          <td>{{ $moment(user.created).format("DD-MM-yyyy") }}</td>
                          <td>
                            <span 
                            class="badge"
                            :class="{ 'badge-soft-success': user.is_staff, 'badge-soft-danger': !user.is_staff }"
                              >{{user.is_staff}}</span
                            >
                          </td>
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
      editName: "",
      editEmail: "",
      editIsStaff: false,
    };
  },
  components: {},
  methods: {
    showModal(modalState, data = {}) {
      if (!modalState) {
        this.editId = "";
        this.editName = "";
        this.editEmail = "";
        this.editIsStaff = false;
        //this.$store.conf.actions.dispatch('showAddUserModal');
        store.isEditModal = false;
        mutations.toggleUserModal();

        //this.addUserModal = !this.addUserModal;
      } else {
        this.editId = data.id;
        this.editName = data.name;
        this.editEmail = data.email;
        this.editIsStaff = data.is_staff;

        //this.addUserModal = !this.addUserModal;
        store.isEditModal = true;
        mutations.toggleUserModal();
      }
    },
    confirmDelete(name, id) {
      (this.nameDelete = name),
        (this.idDelete = id),
        mutations.toggleConfirmDelete();
    },
  },
  computed: {
    users() {
      return this.$store.state.users.results;
    },
    isUserModalOpen() {
      return store.isUserModalOpen;
    },
    isConfirmDeleteOpen() {
      return store.isConfirmDeleteOpen;
    },
  },
};
</script>
<style scoped>
.showModal {
  display: none;
}
</style>
