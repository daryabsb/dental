<template>
 <div>                                                
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="card">                                       
                                                <div class="card-body"> 
                                                    <h4 class="header-title mt-0 mb-3">Education</h4>
                                                    <button 
                                                    @click="showPatientTreatmentModal()"
                                                    type="button" 
                                                    class="btn btn-primary btn-outline-white px-4 mt-0 mb-3">
                                                        <i class="mdi mdi-plus-circle-outline mr-2"></i>Add New Treatment
                                                    </button>
                                                    <b-modal
                                                        variant="primary"
                                                        size="lg"
                                                        ref="p-treatment-modal"
                                                        hide-footer
                                                        title="Add a new treatment"
    >
              	                                        <add-new-treatment @hidePatientTreatmentModal="hidePatientTreatmentModal" :patientID="patient.id"></add-new-treatment>
	                                                </b-modal>
                                                        <!-- <modal-treatment  :patientID="patient.id" /> -->

                                                    <div class="slimscroll education-activity">
                                                        <div class="activity">
                                                            <!-- <pre>{{ patient.treatments }}</pre> -->
                                                            <template>
                                                                <div v-for="treat in patient.treatments" :key="treat.id">
                                                                  <i class="mdi mdi-ambulance icon-success"></i>
                                                            <div class="time-item">
                                                                <div class="item-info">
                                                                    <div class="d-flex justify-content-between align-items-center">
                                                                        <h6 class="m-0">{{treat.title}}</h6>
                                                                        <span class="text-muted">{{$moment(treat.created).format('DD/MM/yyy')}}</span>
                                                                    </div>
                                                                    <p class="text-muted mt-3">{{treat.description}}
                                                                        <a href="#" class="text-info">[more info]</a>
                                                                    </p>
                                                                    <div>
                                                                        <!-- <span class="badge badge-soft-secondary">Design</span>
                                                                        <span class="badge badge-soft-secondary">HTML</span>                                                    
                                                                        <span class="badge badge-soft-secondary">Css</span> -->
                                                                        
                                                                    </div>
                                                                </div>
                                                            </div>  
                                                                </div>
                                                            </template>
                                                                                                                                                                                                                                                                    
                                                        </div><!--end activity-->
                                                    </div><!--end education-activity-->
                                                </div>  <!--end card-body-->                                     
                                            </div><!--end card-->
                                        </div><!--end col-->

                                        <div class="col-lg-6">
                                            <div class="card">                                       
                                                <div class="card-body"> 
                                                    <h4 class="header-title mt-0 mb-3">Medical Examinations</h4>
                                                    <div class="row">
                                                        <div class="col-4">
                                                            <img src="~assets/images/widgets/education.svg" alt="" class="img-fluid">
                                                        </div>
                                                        <div class="col-8 align-self-center">
                                                            <p class="skill-detail">{{patient.medicals.other_diseasses}}
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <div class="skills mt-4">
                                                        <div class="skill-box"> 
                                                            <h4 class="skill-title">Physical Restrictions </h4> 
                                                            <div class="progress-line"> 
                                                                <span 
                                                                data-percent="95" 
                                                                :style="`width: ${patient.medicals.physical_restrictions}%;`">
                                                                    <span class="percent-tooltip">{{patient.medicals.physical_restrictions}}%</span>
                                                                </span> 
                                                            </div>
                                                        </div>
                                                        <div class="skill-box"> 
                                                            <h4 class="skill-title">Heart Problem</h4> 
                                                            <div class="progress-line"> 
                                                                <span 
                                                                data-percent="34" 
                                                                :style="`width: ${patient.medicals.heart_problem}%;`">
                                                                    <span class="percent-tooltip">{{patient.medicals.heart_problem}}%</span>
                                                                </span> 
                                                            </div>
                                                        </div>
                                                        <div class="skill-box"> 
                                                            <h4 class="skill-title">Diabetes</h4> 
                                                            <div class="progress-line"> 
                                                                <span 
                                                                data-percent="34" 
                                                                :style="`width: ${patient.medicals.diabetes}%;`">
                                                                    <span class="percent-tooltip">{{patient.medicals.diabetes}}%</span>
                                                                </span> 
                                                            </div>
                                                        </div>
                                                        <div class="skill-box"> 
                                                            <h4 class="skill-title">Sinus Infections</h4> 
                                                            <div class="progress-line"> 
                                                                <span 
                                                                data-percent="34" 
                                                                :style="`width: ${patient.medicals.sinus_infections}%;`">
                                                                    <span class="percent-tooltip">{{patient.medicals.sinus_infections}}%</span>
                                                                </span> 
                                                            </div>
                                                        </div>
                                                        <div class="skill-box"> 
                                                            <h4 class="skill-title">Kidney Illness</h4> 
                                                            <div class="progress-line"> 
                                                                <span 
                                                                data-percent="34" 
                                                                :style="`width: ${patient.medicals.kidney_illness}%;`">
                                                                    <span class="percent-tooltip">{{patient.medicals.kidney_illness}}%</span>
                                                                </span> 
                                                            </div>
                                                        </div>
                                                        <div class="skill-box"> 
                                                            <h4 class="skill-title">Emotional Difficulties</h4> 
                                                            <div class="progress-line"> 
                                                                <span 
                                                                data-percent="34" 
                                                                :style="`width: ${patient.medicals.emotional_difficulties}%;`">
                                                                    <span class="percent-tooltip">{{patient.medicals.emotional_difficulties}}%</span>
                                                                </span> 
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>  <!--end card-body-->                                     
                                            </div><!--end card-->
                                        </div><!--end col-->
                        
                                    </div><!--end row-->  
                                </div><!--end education detail-->
 
 
</template>

<script>
export default {
    props: ['patient'],
    methods: {
        showPatientTreatmentModal() {
            this.$refs['p-treatment-modal'].show()
        },
        hidePatientTreatmentModal() {
            this.$refs['p-treatment-modal'].hide()
        },
        }
}
</script>