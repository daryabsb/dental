<template>
   <b-card>
       <b-form-group class="text-left" label="Patient Name">
           <b-form-select 
            :options="patients"
            value-field="id"
            text-field="name"
            v-model="appointment.patient"
            ></b-form-select> 
       </b-form-group>
       <b-form-group>
           <b-input v-model="appointment.description"></b-input>
       </b-form-group>
      <b-input-group class="mb-3">
           <b-form-datepicker 
           v-model="appointment.date"
           :date-format-options="{
                        year: 'numeric',
                        month: '2-digit',
                        day: '2-digit',
                      }"
            class="mr-3"
           ></b-form-datepicker>    
      <b-form-input
        id="example-input"
        v-model="appointment.time"
        type="text"
        placeholder="HH:mm"
      ></b-form-input>
      <b-input-group-append>
        <b-form-timepicker
          v-model="appointment.time"
          button-only
          right
        ></b-form-timepicker>
            </b-input-group-append>
       </b-input-group>
       <b-button 
        @click="hide()" 
        variant="outline-danger"
        class="px-4 mt-0 mb-3">
        close</b-button>
       <b-button 
        @click="addNewAppointment()" 
        variant="outline-primary"
        class="px-4 mt-0 mb-3">
        Save</b-button>
   </b-card>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import { store, mutations } from '../../store/utils/conf'
export default {
    props: ['patientID', 'edit'],

    data(){
        return {
            appointment: {
                id: '',
                patient: '',
                description: '',
                date:  '',
                time: ''
            }

        }
    },
    
    methods: {
        
        addNewAppointment () {

            /* CREATE PAYLOAD FROM FORM  */
            if (this.edit) {
                 alert('You already have a patient, try to edit that one!')
                
                
        } else {

        //    console.log('edit: false')
        //    console.log('patient: ', this.appointment.patient)
                let d =`${this.appointment.date}T${this.appointment.time}`
   
                let formData = new FormData();
                formData.append('patient', this.appointment.patient);
                formData.append('description', this.appointment.description);
                formData.append('date', d);

                // console.log('From modal: ', Array.from(formData))

                this.$store.dispatch('addAppointment', formData);

                this.patient = '';
                this.description = '';
                this.date = '';
        }
        
        this.hide();

        },
        hide() {
            this.$emit('hidePatientAppointmentModal');
        },

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
            return this.patientsData.results;
        },
        // appointment() {
        //     // getter
        //     if(this.edit) {
        //         return this.getAppointments.results
        //         .find(app=>app.id === patientID)
        //     } else {
        //         return {}
        //     }
           
                 
           
        // },
        ...mapGetters(['getAppointments', 'patientsData'])
        
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



