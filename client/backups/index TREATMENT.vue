<template>
  <div class="container-fluid">
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
        <!-- <v-gal  :pImages="images" :pIndex="index" /> -->
       
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
                        
                        {{ treat.description }} [<span
                          v-for="file in treat.files"
                          :key="file.id"
                        >
                          <a class="text-success" @click="openPdf(file.file)">{{
                            file.filename
                          }}</a> </span
                        >
                    
                      </td>

                      <td>{{ $moment(treat.created).format("DD-MM-yyyy") }}</td>
                      <td>
                        <span class="badge badge-soft-danger">Cancer</span>
                      </td>
                      <td class="text-right">
                        <a href="../hospital/patient-edit.html" class="mr-2"
                          ><i class="fas fa-edit text-danger font-16"></i
                        ></a>
                        
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
                        <Pdf :url="url" />
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
</template>

<script>

// import { PerfectScrollbar } from "vue2-perfect-scrollbar";
import { store, mutations } from "../store/utils/conf";
// import PdfViewer from "vue-pdf-app";
import { mapGetters, mapMutations } from "vuex";

export default {
  async asyncData({$axios, app, store}) {

    let patientUrl = "/patients/";
    let treatmentUrl = "/treatments/";
    let usersUrl = "/users/";
    let appointmentUrl = "/appointments/";
    let attachmentsUrl = "/attachments/";
        // console.log(url);

        try {
            const allPatients = await $axios.get(patientUrl);
            const allTreatments = await $axios.get(treatmentUrl);
            const allUsers = await $axios.get(usersUrl);
            const allAppointments = await $axios.get(appointmentUrl);
            const allAttachments = await $axios.get(attachmentsUrl);

            store.commit("GET_PATIENTS", allPatients.data);
            store.commit("GET_USERS", allUsers.data);
            store.commit("GET_TREATMENTS", allTreatments.data);
            store.commit("GET_APPOINTMENTS", allAppointments.data);
            store.commit("GET_ATTACHMENTS", allAttachments.data);
            //   console.log(allPatients.data)
           
        } catch (err) {
            console.log(err);
        }
  // this.$store.dispatch('loadData', 'DONE');

  },
  data() {
    return {
      images: [
          'https://dummyimage.com/800/ffffff/000000',
          'https://dummyimage.com/1600/ffffff/000000',
          'https://dummyimage.com/1280/000000/ffffff',
          'https://dummyimage.com/400/000000/ffffff',
        ],
        index: null,
      nameDelete: "",
      idDelete: "",
      date_today: new Date(),
      link: "",
      searchQuery: "",
      url: "https://bitcoin.org/bitcoin.pdf",
      images: [
          'https://dummyimage.com/800/ffffff/000000',
          'https://dummyimage.com/1600/ffffff/000000',
          'https://dummyimage.com/1280/000000/ffffff',
          'https://dummyimage.com/400/000000/ffffff',
        ],
        index: null
      // pdfPage: 1,
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
    ...mapGetters(["isAuthenticated", "loggedInUser", "getTreatments", "getAppointments"]),
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
 