<template>
   
<div class="my-modal" v-if="isAppointmentModalOpen">   
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title mt-0" >Add a New Appointment</h5>
                <button type="button" @click="closeModal()" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                
                <div class="col-12 align-self-center">
                <div class="auth-page">
                    <div class="card auth-card shadow-lg">
                        <div class="card-body">
                            <div class="px-3">
                                    <div class="form-group">
                                        <label for="username">Email</label>
                                       
                                            
                                            <select v-model="appointment.patient" name="patient" class="form-control">
                                                <option :value="p.id" v-for="p in patients" :key="p.id">{{p.name}}</option>    
                                            </select>                                                                                                              
                                                                      
                                    </div><!--end form-group--> 

                                    <div class="form-group">
                                        <label for="username">Description</label>
                                       
                                                                                                                                                        
                                            <input  
                                            v-model="appointment.description" 
                                            type="text" 
                                            class="form-control"  
                                            placeholder="Enter Appointment Description">
                                                                     
                                    </div><!--end form-group--> 

                                    

        
                                    <div class="form-group">
                                       
                                                <label for="date">Date</label>
                                                <input v-model="appointment.date" type="datetime-local" class="form-control" id="datetimepicker1">
                                                
                                                                              
                                    </div><!--end form-group--> 
        
                                    <div class="form-group mb-0 row">
                                        <div class="col-6 mt-2">

                                            <button 
                                                class="btn btn-primary btn-round btn-block waves-effect waves-light"  
                                                @click="addNewAppointment()"
                                                v-if="!isEditModalToHide"
                                            >Save
                                            </button>
                                            <button 
                                                class="btn btn-primary btn-round btn-block waves-effect waves-light"  
                                                @click="addNewAppointment()"
                                                v-else
                                            >Update
                                            </button>

                                        </div><!--end col--> 
                                        <div class="col-6 mt-2">
                                            <button class="btn btn-primary btn-round btn-block waves-effect waves-light" 
                                            @click="closeModal()">Cancel</button>
                                        </div><!--end col--> 
                                    </div> <!--end form-group-->                           
                               
                            </div><!--end /div-->
                
                        </div><!--end card-body-->
                    </div>
                </div></div>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>


    
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import { store, mutations } from '../../store/utils/conf'
export default {
    props: ['editId', 'editPatient', 'editDescription', 'editDate'],

    data(){
        return {
            id: '',
            patient: '',
            description: '',
            date:  false,

        }
    },
    
    methods: {
        
        addNewAppointment () {

            /* CREATE PAYLOAD FROM FORM  */
            if (!this.editId) {
                // console.log(this.appointment)
   
                let formData = new FormData();
                // formData.append('id', this.appointment.id);
                formData.append('patient', this.appointment.patient);
                formData.append('description', this.appointment.description);
                // formData.append('password2', this.password2);
                formData.append('date', this.appointment.date);
                {
        }

                console.log(Array.from(formData))

            /* DISPATCH ACTION @STORE */
            this.$store.dispatch('addAppointment', formData);
          
            } else {
                let data = {  
                    "id": this.appointment.id,
                    "patient": this.appointment.patient,
                    "description": this.appointment.description,
                    "date": this.appointment.date  
                }

                this.$store.dispatch('editAppointment', data);
               
            }
            
            // CLOSE FORM
            // this.closeModal();
            store.isEditModal = false;
            mutations.toggleAppointmentModal();
            //this.$emit('toggle-show');
        },
        closeModal() {
            //console.log(this.name)
            // this.$emit('toggle-show');
            store.isEditModal = false;
            mutations.toggleAppointmentModal();
        }

    },
    computed: {
        isEditModalToHide() {
            return store.isEditModal
        },
        isAppointmentModalOpen() {
            return store.isAppointmentModalOpen
        },
        // patient() {
        //     let patient = this.$store.state.patients.find(p=>p.name===this.editPatientName)
        //     return patient
        // },
        patients() {
            return this.$store.state.patients
        },
        appointment: {
            // getter
            get: function () {
                if(store.isEditModal) {
                    return {
                        'id': this.editId,
                        'patient': this.editPatient,
                         'description': this.editDescription,
                        'date': this.editDate

                        }
                } 
                return {
                    'id': '',
                    'patient': '',
                    'description': '',
                    'date': false
                }
            
            },
            // setter
            set: function (newValue) {
            console.log(newValue);
            }
        }
        
    }
}
</script>
<style>
.my-modal {
    position: fixed;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    z-index: 1000;
    background-color: rgb(0,0,0,.2);
    display: block;
    
}

</style>



