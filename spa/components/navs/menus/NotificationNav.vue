<template>
    <div 
    @click="closeNotifications" 
    class="dropdown-menu dropdown-menu-right dropdown-lg" 
    v-if="isNotificationOpen">
                            <!-- item-->
                            
                            <h6 class="dropdown-item-text">
                                Appointments ({{numAppointments}})
                            </h6>
                            <div class="slimscroll notification-list">
                                <!-- item-->
                                <a class="dropdown-item notify-item active" v-for="appointment in appointments" :key="appointment.id">
                                    <div class="notify-icon bg-success"><i class="mdi mdi-account-clock-outline"></i></div>
                                    <p class="notify-details">{{patient(appointment).name}}<small class="text-muted">{{appointment.description}} - {{$moment(appointment.date).format('DD/MM/yyyy')}}</small></p>
                                </a>
                                
                            </div>
                            <!-- All-->
                            <a class="dropdown-item text-center text-primary">
                                View all <i class="fi-arrow-right"></i>
                            </a>
                        </div>
</template>

<script>
import {mapGetters} from 'vuex';
import { store, mutations } from '../../../store/utils/conf'
export default {
    
    methods: {
    closeNotifications() {
      // CLOSE MENU
      mutations.toggleNotification();
      // this.$emit('toggle-show');
    },
     patient(appointment) {
        //  console.log(this.patientsData.results)
        //  console.log(appointment.patient)
            let patient = this.patientsData.results
            .find(p=>p.id===appointment.patient)
            return patient
        },
    },
    computed: {
        isNotificationOpen() {
            return store.isNotificationOpen
        },
       
        appointments() {
            let apps = this.$store.state.appointments.results
            // .filter(apps=>{
            //     new Date(apps.date) > new Date()
            //     });
            return apps;
        },
        numAppointments() {
            return this.$store.state.appointments.results.length
        },
    ...mapGetters(['patientsData'])
    }
}
</script>