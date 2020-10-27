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
                                    <p class="notify-details">{{appointment.patientName}}<small class="text-muted">{{appointment.description}} - {{$moment(appointment.date).format('DD/MM/yyyy')}}</small></p>
                                </a>
                                
                            </div>
                            <!-- All-->
                            <a class="dropdown-item text-center text-primary">
                                View all <i class="fi-arrow-right"></i>
                            </a>
                        </div>
</template>

<script>
import { store, mutations } from '../../../store/utils/conf'
export default {
    
    methods: {
    closeNotifications() {
      // CLOSE MENU
      mutations.toggleNotification();
      // this.$emit('toggle-show');
    }
    },
    computed: {
        isNotificationOpen() {
            return store.isNotificationOpen
        },
        appointments() {
            return this.$store.state.appointments
        },
        numAppointments() {
            return this.$store.state.appointments.length
        }
    }
}
</script>