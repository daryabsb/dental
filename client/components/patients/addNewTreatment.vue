<template>
  
          <div class="row">
            <div class="col-lg-12">
              <div class="card">
                <div class="card-body">
                  <div class="input-group mb-1">
                    <b-form-group inline>
      <b-form-radio  v-model="selected" name="some-radios" value="options">Select an option</b-form-radio>
      <b-form-radio v-model="selected" name="some-radios" value="custom">Custom treatment</b-form-radio>
    </b-form-group>
                    <!-- <h1>this {{ patientID }} that</h1> -->
                  </div>
                  <div class="input-group mb-1">
                   <b-form-select 
                   v-model="title" 
                   :options="treatChoices" 
                   @change="setTreatDetail($event)"
                   v-if="selected === 'options'"
                   
                    text-field="value"
                   ></b-form-select>
                    <input v-model="title" name="title" class="form-control" v-if="selected === 'custom'" />
                  </div>
                  <div class="form-group mb-1">
                    <label for="exampleFormControlTextarea1">Description</label>
                    <textarea
                      v-model="description"
                      class="form-control"
                      id="exampleFormControlTextarea1"
                      rows="3"
                    ></textarea>
                  </div>
                  <div class="input-group mb-3 row">
                    <!-- VUE UPLOAD AGENT -->

                    <Dropzone :ID="patientID" />
                  </div>

                  <button
                    type="button"
                    @click="hide"
                    class="btn btn-secondary waves-effect"
                  >
                    Close
                  </button>
                  <button
                    @click="onSaveTreatment"
                    type="button"
                    class="btn btn-primary waves-effect waves-light"
                  >
                    Save changes
                  </button>
                </div>
              </div>
              <div class="modal-footer"></div>
            </div>
          </div>
      
</template>

<script>
import { store, mutations } from "../../store/utils/conf";
import { choices } from "../../store/utils/choices";

export default {
  props: ["patientID"],
  data() {
    return {
      title: "",
      description: "",
      show: true,
      selected: '',
    };
  },
  methods: {
    onSaveTreatment() {
      //console.log(this.$auth.user)

      let files = this.$store.state.files.map((file) => parseInt(file.id));

      //    console.log(this.patientID)

      let formData = new FormData();

      // formData.append('user', this.$auth.user.id);
      formData.append("patient", this.patientID);
      formData.append("title", this.title);
      formData.append("description", this.description);
      formData.append("files", files);

    //   console.log(Array.from(formData));

      let data = {
        // "user": this.$auth.user.id,
        patient: this.patientID,
        title: this.title,
        description: this.description,
        files: files,
      };
      // console.log(data)

      this.$store.dispatch("addNewTreatment", data);

      this.title = "";
      this.description = "";

      this.hide();
    },
    closeModal() {
     
    //   this.show = !this.show
      
    },
    hide() {
      this.$emit('hidePatientTreatmentModal');
    },
    setTreatDetail(event) {
        
        let option = choices.treatmentPlans.find(treat=>treat.value === event)
        // console.log(text)
        this.description = option.text;
        },
  },
  computed: {
    isTreatmentOpen() {
      return store.isTreatmentOpen;
    },
    treatChoices() {
        return choices.treatmentPlans;
    },
    // treatDetails() {
    //     return choices.treatmentPlans.find(treat=>);
    // },
  },
};
</script>