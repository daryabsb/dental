<template>
 <div>                                                
                                    
                                    
                                    <b-row>
                                        <b-col md="6">
                                            <b-card title="Treatments">
                                                <treatment-activity :patient="patient"></treatment-activity>
                                            </b-card>
                                        </b-col>              
                                        <b-col md="6">
                                            <b-card title="Medical Examinations">
                                                 <b-row>
                                                    <b-col sm="4">
                                                        <img src="~assets/images/widgets/education.svg" alt="" class="img-fluid">
                                                    </b-col>
                                                    <b-col sm="8">
                                                        <p class="skill-detail">{{patient.medicals.other_diseasses}}</p>
                                                    </b-col>
                                                </b-row>
                                             
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
                                            </b-card>   
                                        </b-col>    
                                    </b-row><!--end row-->  
                                </div><!--end education detail-->
 
 
</template>

<script>
export default {
    props: ['patient'],
    
}
</script>