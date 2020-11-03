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
                         <!-- <pre>{{patient.id}}</pre> -->
                         <div class="col-lg-6">
                             <PatientTreatment :patientID="patient.id" :treatments="patient.treatments" />
                         </div>
                        <div class="col-lg-6">

                             <div class="card">
                                <div class="card-body">
                                    <!-- Nav tabs -->
                                    <ul class="nav nav-pills nav-justified" role="tablist">
                                        <li class="nav-item waves-effect waves-light">
                                            <a @click="togglePdf" class="nav-link" :class="{active: isPdfTabOpen}">PDFs</a>
                                        </li>
                                        <li class="nav-item waves-effect waves-light">
                                            <a @click="toggleImages" class="nav-link" :class="{active: isImagesTabOpen}">Images</a>
                                        </li>
                                        <li class="nav-item waves-effect waves-light">
                                            <a @click="toggleHealthCondition" class="nav-link" :class="{active: isPatientHistoryTabOpen}">Condition</a>
                                        </li>
                                    </ul>
    
                                    <!-- Tab panes -->
                                    <!-- <pre>{{pdfUrls}}</pre> -->
                                    <div class="tab-content">
                                        <div class="tab-pane p-3"  :class="{active: isPdfTabOpen}">
                                            <pdf-tab  :files="patientPDFs" />
                                        </div>
                                        <div class="tab-pane p-3" :class="{active: isImagesTabOpen}">
                                            <!-- {{imageUrls}} -->
                                             <v-gal  :images="patientImages" :index="index = null" />
                                        </div>
                                        <div class="tab-pane p-3" :class="{active: isPatientHistoryTabOpen}">
                                              <PatientHistory :patientID="patient.id" />
                                        </div>
                                    </div>    
                                </div><!--end card-body-->
                            </div>
                         </div>
                        

                        
                    </div><!--end row-->
                   

                </div>
</template>
<script>
import { store, mutations } from '../../store/utils/conf';
// import { mapState, mapActions, mapGetters } from 'vuex'
export default {
        async asyncData({ $axios, params }) {
        
        try {

        let singlePatient = $axios.$get(`http://127.0.0.1:8000/api/patients/${params.id}/`);
        let singlePatientPdfs = $axios.$get(`http://127.0.0.1:8000/api/attachments/?p=${params.id}&type=pdf`);
        let singlePatientImages = $axios.$get(`http://127.0.0.1:8000/api/attachments/?p=${params.id}&type=image`);
        const [patientResponse, patientPdfFiles, patientImageFiles] = await Promise.all([singlePatient, singlePatientPdfs, singlePatientImages]);
            // console.log(patientResponse);
            return {
                patient: patientResponse,
                patientPDFs: patientPdfFiles,
                patientImages: patientImageFiles
            }
        } catch (err) {
            console.log(err)
        }
    },
    methods: {
        togglePdf(files) {
            if(!this.isPdfTabOpen) {
            mutations.togglePdfTab(files);
            }
            if(this.isImagesTabOpen) {
            mutations.toggleImagesTab(files);
            }
             if(this.isPatientHistoryTabOpen) {
            mutations.togglePatientHistoryTab();
            }
        },
        toggleImages(files) {
            if(!this.isImagesTabOpen) {
            mutations.toggleImagesTab(files);
            }
            if(this.isPdfTabOpen) {
                 mutations.togglePdfTab(files);
            }
             if(this.isPatientHistoryTabOpen) {
            mutations.togglePatientHistoryTab();
            }
           
        },
        toggleHealthCondition() {
            if(!this.isPatientHistoryTabOpen) {
            mutations.togglePatientHistoryTab();
            }
            if(this.isPdfTabOpen) {
                 mutations.togglePdfTab();
            }
            if(this.isImagesTabOpen) {
            mutations.toggleImagesTab();
            }
           
        },
        
        onlyUnique(value, index, self) {
            return self.indexOf(value) === index;
        }
    },
    computed: {
        isPdfTabOpen() {
            return store.isPdfTabOpen;
        },
        isImagesTabOpen() {
            return store.isImagesTabOpen;
        },
        isPatientHistoryTabOpen() {
            return store.isPatientHistoryTabOpen;
        },
        
        attachments() {

            return this.$store.state.attachments
        },
        allPdfs() {
            
            let allFiles = [];
            let treats = this.patient.treatments;
            treats.forEach(treat => {
                
                treat.files.forEach(file=>{
                    // console.log(file)
                    allFiles.push(file)
                })
                    
            });
            var unique = allFiles.filter(this.onlyUnique);

            return unique;
        },
        pdfUrls() {
           let files = []; 
           let pdfs = []; 
        //    console.log(this.attachments)
           this.allPdfs.forEach(id=> {
               let file = this.attachments.find(item =>  item.id === id);
            //    let attachment = this.attachments.find(att => console.log('1as'));
            //    console.log(attachment)
            
               files.push(file)
               });
        pdfs = files.filter(file=> file.file_type === 'pdf');
        let links = pdfs.map(f=>f.file)
        console.log(links)
       
           return links;
        },
        imageUrls() {
           let files = []; 
           let images = []; 
        //    console.log(this.attachments)
           this.allPdfs.forEach(id=> {
               let file = this.attachments.find(item =>  item.id === id);
            //    let attachment = this.attachments.find(att => console.log('1as'));
            //    console.log(attachment)
            
               files.push(file)
               });
        images = files.filter(file=> file.file_type == 'image');
        let links = images.map(f=>f.file)
        console.log(links)
       
           return links;
        },
    }
}
</script>