<template>
  <div>
    <button
      @click="showPatientTreatmentModal()"
      type="button"
      class="btn btn-primary btn-outline-white px-4 mt-0 mb-3"
    >
      <i class="mdi mdi-plus-circle-outline mr-2"></i>Add New Treatment
    </button>
    <b-modal
      variant="primary"
      size="lg"
      ref="p-treatment-modal"
      hide-footer
      title="Add a new treatment"
    >
      <add-new-treatment
        @hidePatientTreatmentModal="hidePatientTreatmentModal"
        :patientID="patient.id"
      ></add-new-treatment>
    </b-modal>
    <div class="activity">
      <!-- <pre>{{ patient.treatments }}</pre> -->
      <template>
          <div class="treatments-activity">
        <div v-for="treat in patient.treatments" :key="treat.id">
          <i class="mdi mdi-ambulance icon-success"></i>
          <div class="time-item">
            <div class="item-info">
              <div class="d-flex justify-content-between align-items-center">
                <h6 class="m-0">{{ treat.title }}</h6>
                <span class="text-muted">{{
                  $moment(treat.created).format("DD/MM/yyy")
                }}</span>
              </div>
              <p class="text-muted mt-3">
                {{ treat.description }}
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
        </div>
      </template>
    </div>
    <!--end activity-->
  </div>
</template>

<script>
export default {
  props: ["patient"],
  methods: {
    showPatientTreatmentModal() {
      this.$refs["p-treatment-modal"].show();
    },
    hidePatientTreatmentModal() {
      this.$refs["p-treatment-modal"].hide();
    },
  },
};
</script>
<style>

.treatments-activity {
    max-height: 35rem;
    overflow-y: auto;
}

</style>