<template>
    <div>
        
                            <div class="card">                                       
                                <div class="card-body full-height"> 
                                    <h4 class="header-title mt-0 mb-3">Treatments</h4>
                                   <button 
                                   @click="showModal()"
                                   type="button" 
                                   class="btn btn-primary btn-outline-white px-4 mt-0 mb-3">
                                        <i class="mdi mdi-plus-circle-outline mr-2"></i>Add New Treatment
                                        </button>
                                        <modal-treatment :patientID="patientID" />
                                         <!-- <test-comp :patientID="patientID" /> -->

                                    <div class="slimScrollDiv" style="position: relative; overflow: hidden; width: auto; height: 363px;"><div class="slimscroll education-activity" style="overflow: hidden; width: auto; height: 363px;">
                                      
                                        <perfect-scrollbar> 
                                            <div class="activity">
                                                <!-- <pre>{{treats}}</pre> -->
                                                <div 
                                                v-for="treat in treats" 
                                                :key="treat.id"
                                                 :class="{tactive:treat.id == selected}" 
                                                 @click="selected = (treat.id == selected ? undefined : treat.id)"
                                                 >
                                            <i class="mdi mdi-school icon-success"></i>
                                            <div 
                                            class="time-item p-3 m-2" 
                                           
                                            @click="onFilterFiles(treat)">
                                                <div class="item-info">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <h6 class="m-0 text-pink">{{treat.title}}</h6>
                                                        <span class="text-muted">{{treat.created}}</span>
                                                    </div>
                                                    <h6>{{treat.description}}
                                                        <a href="#" class="text-info">[more info]</a></h6>
                                                    
                                                    <div>
                                                        <!-- <span class="badge badge-soft-secondary">{{treat.files}}</span> -->
                                                        <span class="badge badge-soft-secondary" v-for="file in treat.files" :key="file.id">{{file.filename}}</span>
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                            </div>
                                            <i class="mdi mdi-medal icon-pink"></i>                                                                                                           
                                            <div class="time-item">
                                                <div class="item-info">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <h6 class="m-0">Apollo Hospital</h6>
                                                        <span class="text-muted">Oct-2006 to Oct-209</span>
                                                    </div>
                                                    <p class="text-muted mt-3">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.
                                                        <a href="#" class="text-info">[more info]</a>
                                                    </p>
                                                    <div>
                                                        <span class="badge badge-soft-secondary">Python</span>
                                                        <span class="badge badge-soft-secondary">Django</span>
                                                    </div>
                                                </div>                                            
                                            </div>
                                            <i class="mdi mdi-book-open-page-variant icon-purple"></i> 
                                            <div class="time-item">
                                                <div class="item-info">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <h6 class="m-0">Stanford Hospitals</h6>
                                                        <span class="text-muted">Oct-2003 to Oct-2006</span>
                                                    </div>
                                                    <p class="text-muted mt-3">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.
                                                        <a href="#" class="text-info">[more info]</a>
                                                    </p>
                                                </div>
                                            </div>                                         
                                            <i class="mdi mdi-lead-pencil icon-warning"></i>
                                            <div class="time-item">
                                                <div class="item-info">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <h6 class="m-0">Karolinska Hospital</h6>
                                                        <span class="text-muted">Oct-1996 to Oct-2003</span>
                                                    </div>
                                                    <p class="text-muted mt-3">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.
                                                        <a href="#" class="text-info">[more info]</a>
                                                    </p>                                                
                                                </div>
                                            </div> 
                                            <i class="mdi mdi-school icon-success"></i>
                                            <div class="time-item">
                                                <div class="item-info">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <h6 class="m-0">Oxford University</h6>
                                                        <span class="text-muted">Oct-2009 to Oct-2011</span>
                                                    </div>
                                                    <p class="text-muted mt-3">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.
                                                        <a href="#" class="text-info">[more info]</a>
                                                    </p>
                                                    <div>
                                                        <span class="badge badge-soft-secondary">Design</span>
                                                        <span class="badge badge-soft-secondary">HTML</span>                                                    
                                                        <span class="badge badge-soft-secondary">Css</span>
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                               
                                            
                                            </div><!--end activity--> 
 </perfect-scrollbar>
                                      
                                       
                                    </div><div class="slimScrollBar" style="background: rgb(230, 234, 245); width: 7px; position: absolute; top: 0px; opacity: 1; display: none; border-radius: 7px; z-index: 99; right: 1px; height: 316.484px;"></div><div class="slimScrollRail" style="width: 7px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; background: rgb(51, 51, 51); opacity: 0.2; z-index: 90; right: 1px;"></div></div><!--end education-activity-->
                                </div>  <!--end card-body-->                                     
                            </div><!--end card-->
                          
    </div><!--end col-->
</template>

<script>

import { PerfectScrollbar } from 'vue2-perfect-scrollbar';
import { store, mutations } from '../../store/utils/conf';

export default {
    props: ['treatments', 'patientID'],
    components: {
        PerfectScrollbar
    },
   data() {
       return {
           selected: undefined,
           allPdfs: [],
           allImages: [],
           
       }
   },
    methods: {

        //getTreatments() {}

        onFilterFiles(treat) {

            this.allPdfs = store.treatmentPdfFiles
            this.allImages = store.treatmentImageFiles

            console.log(this.$store.state.patientPdfFiles)

            if(!this.selected === treat.id) {
                
                store.treatmentPdfFiles = treat.files.filter(file=>file.file_type==='pdf');
                store.treatmentImageFiles = treat.files.filter(file=>file.file_type==='image');

            } else {
                store.treatmentPdfFiles  = this.allPdfs
                store.treatmentImageFiles = this.allImages
            }
            
        },
        
        showModal() {
            mutations.toggleTreatment();
        }
    },
    computed: {
        treats() {
            this.$store.dispatch('getPatientTreats', this.patientID)
            return this.$store.state.curTreats
        },
    },
    
    }
</script> 
<style src="vue2-perfect-scrollbar/dist/vue2-perfect-scrollbar.css"/>
<style>
.ps {
  height: 100%;
}
.full-height {
    height: 100%;
}

.tactive {
    background-color: #EAECEE;
}
</style>