<template>
  <div class="container-fluid" v-if="isAuthenticated">
      <!-- Page-Title -->
      <div class="row">
        <div class="col-sm-12">
          <div class="page-title-box">
            <div class="float-right">
              <ol class="breadcrumb">
                <li class="breadcrumb-item active">Dashboard</li>
              </ol>
              <!--end breadcrumb-->
            </div>
            <!--end /div-->
            <h4 class="page-title">Dashboard</h4>
          </div>
          <!--end page-title-box-->
        </div>
        <!--end col-->
      </div>
      <!--end row-->
      <!-- end page title end breadcrumb -->
      <div class="row">
        <div class="col-lg-12">
          <div class="row">
            <div class="col-lg-4">
              <div class="card hospital-info">
                <div class="card-body">
                  <h4 class="header-title mt-0 mb-3">Users</h4>
                  <div class="media">
                    <div class="data-icon align-self-center">
                      <i class="fas fa-user rounded-circle text-success"></i>
                    </div>
                    <div class="media-body ml-3 align-self-center text-right">
                      <h3 class="mt-0">{{numUsers}}</h3>
                      <p class="text-muted mb-0 text-nowrap">Yesterday 32 App.</p>
                    </div>
                    <!--end media body-->
                  </div>
                </div>
                <!--end card-body-->
              </div>
              <!--end card-->
            </div>
            <!-- end col-->
            <div class="col-lg-4">
              <div class="card hospital-info">
                <div class="card-body">
                  <h4 class="header-title mt-0 mb-3">Patients</h4>
                  <div class="media">
                    <div class="data-icon align-self-center">
                      <i class="fas fa-bed rounded-circle text-warning"></i>
                    </div>
                    <div class="media-body ml-3 align-self-center text-right">
                      <h3 class="mt-0">{{numPatients}}</h3>
                      <p class="text-muted mb-0 text-nowrap">Yesterday 22 Add.</p>
                    </div>
                    <!--end media body-->
                  </div>
                </div>
                <!--end card-body-->
              </div>
              <!--end card-->
            </div>
            <!-- end col-->
            <div class="col-lg-4">
              <div class="card hospital-info">
                <div class="card-body">
                  <h4 class="header-title mt-0 mb-3">Operations</h4>
                  <div class="media">
                    <div class="data-icon align-self-center">
                      <i class="fas fa-briefcase-medical rounded-circle text-success"></i>
                    </div>
                    <div class="media-body ml-3 align-self-center text-right">
                      <h3 class="mt-0">{{numTreatments}}</h3>
                      <p class="text-muted mb-0 text-nowrap">Yesterday 12 Ope.</p>
                    </div>
                    <!--end media body-->
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
        <div class="col-lg-12">
          <div class="card">
            <div class="card-body">
              <div class="row">
                <div class="col-sm-3">
                  <h4 class="header-title mt-0 mb-3">Hospital Survey</h4>
                </div>
                <div class="col-sm-9">
                  <!-- <span><h4 class="header-title mt-0 mb-3">Select Date</h4></span>
                                <span>

                                    <client-only>
                                                <date-picker
                                                class="form-control"
                                                    placeholder="Select a date"
                                                    format="MM/dd/yyyy"
                                                    v-model="date_today" />
                                            </client-only>
                                </span> -->
                  <div class="form-group row">
                    <label
                      for="example-search-input"
                      class="header-title col-sm-2 col-form-label text-right"
                    >
                      Search
                    </label>
                    <div class="col-sm-5 mr-0">
                      <input
                        class="form-control"
                        type="search"
                        placeholder="Search for a treatment by patient"
                        v-model="searchQuery"
                      />
                    </div>

                    <label
                      for="example-date-input mr-0"
                      class="col-sm-2 col-form-label text-right"
                      >Date</label
                    >
                    <div class="col-sm-3">
                      <input
                        v-model="date_today"
                        class="form-control"
                        type="date"
                      />
                    </div>
                  </div>
                </div>
              </div>

              <div class="table-responsive">
                <!-- <pre>{{getTreatments}}</pre> -->
                <table id="datatable" class="table">
                  <thead class="thead-light">
                    <tr>
                      <th>Patient Name</th>
                      <th>Treatment</th>
                      <th>Last Visit</th>
                      <th>Diseases</th>
                      <th class="text-right">Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <!-- <perfect-scrollbar> -->
                    <tr v-for="treat in searchTreatments" :key="treat.id">
                      <td>
                        <nuxt-link :to="`/patients/${treat.patient}`"
                          ><img
                            src="~assets/images/users/user-10.jpg"
                            alt=""
                            class="thumb-sm rounded-circle mr-2"
                          />{{ treat.patientName }}</nuxt-link
                        >
                      </td>
                      <td>
                        <tr>
                        {{ treat.description }} [<span
                          v-for="file in treat.files"
                          :key="file.id"
                        >
                          <a class="text-success" @click="openPdf(file.file)">{{
                            file.filename
                          }}</a> </span
                        >]
                        </tr>
                        <tr>
                         <small class="text-danger">{{treat.appointment}}</small>
                        </tr>
                      </td>

                      <td>{{ $moment(treat.created).format("DD-MM-yyyy") }}</td>
                      <td>
                        <span class="badge badge-soft-danger">Cancer</span>
                      </td>
                      <td class="text-right">
                        <a href="../hospital/patient-edit.html" class="mr-2"
                          ><i class="fas fa-edit text-danger font-16"></i
                        ></a>
                        <Pdf :url="url" :page="pdfPage" />
                        <a @click="confirmDelete(`treatment for ${treat.patientName}`, treat.id)">
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
                    </tr>
                    <!-- </perfect-scrollbar> -->
                  </tbody>
                </table>
              </div>
            </div>
            <!--end card-body-->
          </div>
          <!--end card-->
        </div>
      </div>
  </div>
  <!-- container -->
  <div class="container-fluid" v-else>
    <h1>You have to login to view this page</h1>
  </div>
</template>

<script>
// import { PerfectScrollbar } from "vue2-perfect-scrollbar";
import { store, mutations } from "../store/utils/conf";
// import PdfViewer from "vue-pdf-app";
import { mapGetters } from "vuex";

export default {
  components: {
    // PerfectScrollbar,
    // PdfViewer
    // 'vue-pdf-viewer': VuePDFViewer
  },
  data() {
    return {
      nameDelete: "",
      idDelete: "",
      date_today: new Date(),
      link: "",
      searchQuery: "",
      url: "https://bitcoin.org/bitcoin.pdf",
      pdfPage: 1,
    };
  },
  methods: {
    patientName(id) {
      let patient = this.$store.state.patients.find(
        (patient) => patient.id === id
      );
      return patient.name;
    },

    openPdf(url, page = 1) {
      // var page = url.substring(url.lastIndexOf('/') + 1);
      let link = `../..${url.substring(url.indexOf("/", 10))}`;
      console.log(link);
      this.url = link;
      mutations.togglePdfModal();
    },
    confirmDelete(name, id) {
      (this.nameDelete = name),
        (this.idDelete = id),
        mutations.toggleConfirmDelete();
    },
  },
  computed: {
    searchTreatments() {
      return this.getTreatments.filter((treat) => {
        return (
          treat.patientName
            .toLowerCase()
            .includes(this.searchQuery.toLowerCase()) ||
          treat.description
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
    ...mapGetters(["isAuthenticated", "loggedInUser", "getTreatments"]),
  },
};
</script>
