<template>
   <div class="col-lg-6">
        <div class="card">                                       
            <div class="card-body"> 
                        <h4 class="header-title mt-0 mb-3">Patient's Health Conditions</h4>
                        <button 
                            @click="showModal()"
                            type="button" 
                            class="btn btn-primary btn-outline-white px-4 mt-0 mb-3">
                            <i class="mdi mdi-plus-circle-outline mr-2"></i>Add New Condition
                        </button>
                
                        <!-- <ModalTreatment :patient="patient" /> -->
                        
                        <div class="row">
                            <div class="col-4">
                                <img src="~assets/images/widgets/education.svg" alt="" class="img-fluid">
                            </div>
                            <div class="col-8 align-self-center">
                                <p class="skill-detail">Contrary to popular belief, Lorem Ipsum is not simply random text. 
                                    It has roots in a piece of classical Latin literature from 45 BC, 
                                    making it over 2000 years old. Richard McClintock, a Latin professor 
                                    at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words.
                                </p>
                            </div>
                        </div>
                   
                        <div class="skills mt-4">
                            <div class="skill-box"> 
                                <h4 class="skill-title">Heart Rate</h4> 
                                <div class="progress-line"> 
                                    <span data-percent="78" style="width: 65%;">
                                        <span class="percent-tooltip">65%</span>
                                    </span> 
                                </div>
                            </div>
                            <div class="skill-box"> 
                                <h4 class="skill-title">Smoking [cig/d]-MAX=40</h4> 
                                <div class="progress-line"> 
                                    <span data-percent="90" style="width: 50%;">
                                        <span class="percent-tooltip">20</span>
                                    </span> 
                                </div>
                            </div>
                            <div class="skill-box"> 
                                <h4 class="skill-title">Weight [kg]</h4> 
                                <div class="progress-line"> 
                                    <span data-percent="80" style="width: 96%;">
                                        <span class="percent-tooltip">96</span>
                                    </span> 
                                </div>
                            </div>
                            <div class="skill-box"> 
                                <h4 class="skill-title">Teeth Health [%]</h4> 
                                <div class="progress-line"> 
                                    <span data-percent="95" style="width: 95%;">
                                        <span class="percent-tooltip">95%</span>
                                    </span> 
                                </div>
                            </div>
                        </div>
                   
            </div>  <!--end card-body-->                                     
        </div><!--end card-->
    </div><!--end col-->
</template>
<script>
import { store, mutations } from '../../store/utils/conf';
export default {
    props: ['patient'],
    
   
    methods: {

        //getTreatments() {}
        
        showModal() {
            mutations.toggleTreatment();
        }
    },
    
    
    }
</script> 