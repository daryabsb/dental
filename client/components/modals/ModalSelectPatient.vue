<template>
  <div class="my-modal fade bs-example-modal-center show" style="display: block;" v-if="isSelectPatientModalOpen">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 id="exampleModalLabel" class="modal-title mt-0">Add a new treatment</h5>
          <button
            type="button"
           @click="close"
            class="close"
          >
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="form-group">
            <label class="form-label"> Select a Patient </label>
            <select class="form-control" v-model="patientID">
              <option 
              v-for="patient in patients" 
              :key="patient.id"
              :value="patient.id"
              >{{patient.name}}</option>
            </select>
          </div>
          <button class="btn btn-danger btn-small">
            <a @click="selectPatient(patientID)">Select</a>
          </button>
          
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import { mapActions, mapGetters } from "vuex";
import { store, mutations } from '../../store/utils/conf'
export default {
 
  data() {
      return {
        patientID: ''
      };
  },
  methods: {
    selectPatient(id) {
      // mutations.toggleTreatment();
      // console.log(id)
      this.$emit("selectPatient", id);
      this.patientID = '';
       mutations.toggleSelectPatientModal();
       
    },
    close() {
        mutations.toggleSelectPatientModal();
    }
  },
  computed: {
    isSelectPatientModalOpen() {
        return store.isSelectPatientModalOpen
    },

    ...mapGetters(['patients'])
  }
};
</script>
