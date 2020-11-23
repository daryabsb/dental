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
                    <h3 class="mt-0">{{ numUsers }}</h3>
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
                    <h3 class="mt-0">{{ numPatients }}</h3>
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
                    <i
                      class="fas fa-briefcase-medical rounded-circle text-success"
                    ></i>
                  </div>
                  <div class="media-body ml-3 align-self-center text-right">
                    <h3 class="mt-0">{{ numTreatments }}</h3>
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
    <!-- <test-tabs></test-tabs> -->
    <!-- <client-only> -->
    <!-- <pdf-viewer pdf="http://www.africau.edu/images/default/sample.pdf"></pdf-viewer> -->
  <!-- </client-only> -->
 </div>
     
    
  <!-- <test-form></test-form> -->
  
  <!-- <test-wizard></test-wizard> -->
  
</div>
    

    <div class="row">
      <!-- <v-gal  :pImages="images" :pIndex="index" /> -->

      <div class="col-lg-4">

        <div class="card">
          <div class="card-body">
            <div class="row">
              <div class="col-sm-12 mb-3">
                <h4 class="header-title mt-0 mb-3">Hospital Survey</h4>
              </div>
              <div class="form-group col-12 row">

<!-- <pre>{{ colPatients }}</pre> -->
<!-- <pre>{{ patients }}</pre> -->


        <b-table :apiUrl="`/appointments`" :items="items" :fields="fields" striped responsive="sm">
      <template #cell(show_details)="row">
        <b-button size="sm" @click="row.toggleDetails" class="mr-2">
          {{ row.detailsShowing ? 'Hide' : 'Show'}} Details
        </b-button>

        <!-- As `row.showDetails` is one-way, we call the toggleDetails function on @change -->
        <!-- <b-form-checkbox v-model="row.detailsShowing" @change="row.toggleDetails">
          Details via check
        </b-form-checkbox> -->
      </template>

      <template #row-details="row">
        <b-card>
          <b-row class="mb-2">
            <b-col sm="3" class="text-sm-right"><b>Appointments:</b></b-col>
            <b-col>{{ row.item.appointments.description }}</b-col>
          </b-row>

          <b-row class="mb-2">
            <b-col sm="3" class="text-sm-right"><b>Treatments:</b></b-col>
            <b-col>{{ row.item.treatments.title }}</b-col>
          </b-row>

          <!-- <b-button size="sm" @click="row.toggleDetails">Hide Details</b-button> -->
        </b-card>
      </template>
    </b-table>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      
      
      
      <div class="col-lg-8">
        <div class="card">
          <div class="card-body">
            <div class="row">
              <div class="col-sm-12 mb-3">
                <h4 class="header-title mt-0 mb-3">Hospital Survey</h4>
              </div>
              <div class="form-group col-12 row">
                <div class="col-6 row">
                  <label
                    for="example-search-input"
                    class="col-4 col-form-label text-right"
                    >Search</label
                  >

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
                  <label
                    for="example-search-input"
                    class="col-4 col-form-label text-right"
                    >Filter by Date</label
                  >
                  <div class="col-4">
                    <select class="form-control"  @change="searchDate" v-model="dateSelect">
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
           <div class="table-responsive">
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
                  <tr
                    v-for="appointment in searchAppointments"
                    :key="appointment.id"
                  >
                    <td>
                      <nuxt-link :to="`/patients/${appointment.patient}`"
                        ><img
                          :src="patient(appointment).image"
                          alt=""
                          class="thumb-sm rounded-circle mr-2"
                        />{{ patient(appointment).name }}</nuxt-link
                      >
                    </td>
                    <td>
                      {{ appointment.description }}
                    </td>

                    <td>
                      {{ $moment(appointment.date).format("DD-MM-yyyy") }}
                    </td>
                    <td>
                      <span class="badge badge-soft-danger">Cancer</span>
                    </td>
                    <td class="text-right">
                      <a href="../hospital/patient-edit.html" class="mr-2"
                        ><i class="fas fa-edit text-danger font-16"></i
                      ></a>

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
    
    await store.dispatch('loadData');
    
    // this.$store.dispatch('loadData', 'DONE');
  
  },
  data() {
    return {

      // LEFT TABLE DATA 
      fields: ['name', 'show_details'],
        items: this.colPatients, 
        // [
        //   { isActive: true, age: 40, name: 'Dickerson Macdonald' },
        //   { isActive: false, age: 21, name: 'Larsen Shaw' },
        //   {
        //     isActive: false,
        //     age: 89,
        //     first_name: 'Geneva',
        //     last_name: 'Wilson',
        //     _showDetails: true
        //   },
        //   { isActive: true, age: 38, first_name: 'Jami', last_name: 'Carney' }
        // ],
        

      
      
      nameDelete: "",
      idDelete: "",
      // date_today: new Date(),
      date_today: '',
      link: "",
      searchQuery: "",
      url: "",
      
      
      dateSelect: "",
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
     searchDate() {

      let query = {}

        if (query.dq !== '') {
          query.dq = this.dateSelect;
        } else {
          query.dq = ''
        }
        
        if (query.dq === 'custom' && this.date_today != '') {
          query.date = this.$moment(this.date_today).format("yyyy-MM-DD")
        } else {
          query.date = ''
        }

         this.$store.dispatch('filterAppointments', query)
         this.date_today = '';
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
      const patient = this.patients.find(p=>p.id === appointment.patient);
      return patient;
    },
    lastObject(arr) {
      return arr[arr.length - 1]
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
    colPatients() {
      const picked = [];
      this.patients.forEach(patient=>{
        patient = (({ id, name, appointments, treatments }) => ({ id, name, appointments, treatments }))(patient);
       patient.treatments = this.lastObject(patient.treatments)
       patient.appointments = this.lastObject(patient.appointments);
      //  patient.showDetails = true;
       picked.push(patient);

      });
      // console.log(picked);
      // const object = this.patient;
      // const picked = (
      //   ({ id, name, appointments, treatments }) => ({ id, name, appointments, treatments }))(object);
      // console.log(picked)
    return picked;
    },
    ...mapGetters([
      "isAuthenticated",
      "loggedInUser",
      "getTreatments",
      "getAppointments",
      'patients',
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
 