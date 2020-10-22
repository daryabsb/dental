<template>

    <div class="container-fluid">
                    <!-- Page-Title -->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="page-title-box">
                                <div class="float-right">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><nuxt-link to="/">Home</nuxt-link></li>
                                        <li class="breadcrumb-item"><nuxt-link to="/patients">Patients</nuxt-link></li>
                                        <li class="breadcrumb-item active">{{patient.name}}</li>
                                    </ol><!--end breadcrumb-->
                                </div><!--end /div-->
                                <h4 class="page-title">Patient Profile</h4>
                            </div><!--end page-title-box-->
                        </div><!--end col-->
                    </div><!--end row-->
                    <!-- end page title end breadcrumb -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">                                                            
                                <div class="card-body">   
                                    <div class="row">
                                        <div class="col-lg-6 align-self-center">
                                            <div class="media">
                                                <img src="~assets/images/users/user-8.jpg" alt="user" class="rounded-circle thumb-xl mr-3  align-self-center">
                                                <div class="media-body align-self-center">
                                                    <h4 class="mt-0">{{patient.name}}</h4>
                                                    <p class="mb-0 text-muted">Contrary to popular belief, Lorem Ipsum is not simply random text. 
                                                        It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. 
                                                        Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, 
                                                        looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, 
                                                        and going through the cites of the word in classical literature, discovered the undoubtable source.
                                                    </p>
                                                </div>
                                            </div> 
                                        </div><!--end col--> 
                                        <div class="col-lg-4 ml-auto">
                                            <p>
                                                <span class="personal-detail-title">Name</span> 
                                                <span class="personal-detail-info">{{patient.name}}</span>
                                            </p> 
                                            <p>
                                                <span class="personal-detail-title">Birth Date</span> 
                                                <span class="personal-detail-info">{{patient.dob}}</span>
                                            </p> 
                                            <p>
                                                <span class="personal-detail-title">Phone No</span> 
                                                <span class="personal-detail-info">{{patient.phone}}</span>
                                            </p> 
                                            <p>
                                                <span class="personal-detail-title">Email</span> 
                                                <span class="personal-detail-info">{{patient.email}}</span>
                                            </p> 
                                            <p>
                                                <span class="personal-detail-title">Doctor Name</span> 
                                                <span class="personal-detail-info">Dr.{{patient.doctor}} (MS Orthopaedic)</span>
                                            </p> 
                                        </div><!--end col--> 
                                    </div><!--end row-->
                                </div><!--end card-body-->                                                                     
                            </div><!--end card-->
                        </div><!--end col-->
                        
                        
                    </div><!--end row-->
                    <div class="row">
                        <PatientTreatment :patient="patient" />
                        <PatientHistory :patient="patient" />

                        
                    </div><!--end row-->

                </div>
</template>
<script>
import { mapState, mapActions, mapGetters } from 'vuex'
export default {
    
    computed: {
       patient() {
           const id = this.$route.params.id;
           let patients = this.$store.state.patients
           const patient = patients.find(p=>p.id = id)
        //    console.log(patient)
           return patient
       }
    },
}
</script>