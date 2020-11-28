<template>
  <div>
    <!-- <select id="sel2" class="form-control">
        <option
        v-for="d in allData.CLASS_CHOICES"
        :key="d.value"
        :value="d.value">{{d.display}}</option>
      </select>
		-->

    
      
    <!-- <b-button id="toggle-btn" size="sm" @click="toggleModal">Toggle Modal</b-button> -->

    
      <!-- <pre>{{classChoices}}</pre> -->

      <client-only>
        <form-wizard
          shape="tab"
		  title=""
		  subtitle=""
          @on-complete="onComplete"
          ref="wizard"
          color="#4d79f6"
        >
          <tab-content title="Personal details" icon="ti-user">
            <b-form @submit="onSubmit" @reset="onReset" v-if="show" row>
              <b-row>
                <b-col cols="4">
                  <b-form-group
                    class="form-group py-0"
                    id="input-group-1"
                    label="Patient's name:"
                    label-for="input-name"
                    cols="3"
                  >
                    <b-form-input
                      class="form-control py-0"
                      id="input-name"
                      v-model="patient.name"
                      type="text"
                      placeholder="Enter patient's name"
                    ></b-form-input>
                  </b-form-group>
                </b-col>
                <b-col cols="4">
                  <b-form-group
                    id="input-group-phone"
                    label="Phone Number:"
                    label-for="input-phone"
                  >
                    <b-form-input
                      id="input-phone"
                      v-model="patient.phone"
                      placeholder="Ex: 0770 XXX XXXX"
                      type="text"
                    ></b-form-input>
                  </b-form-group>
                </b-col>
                <b-col cols="4">
                  <b-form-group
                    id="input-group-email"
                    label="Email:"
                    label-for="input-email"
                  >
                    <b-form-input
                      id="input-email"
                      v-model="patient.email"
					            type="email"
                      placeholder="foo@gmail.com"
                    ></b-form-input>
                  </b-form-group>
                </b-col>
              </b-row>
			  <b-row>
				   <b-col cols="4">
                  <b-form-group
                    class="form-group py-0"
                    id="input-group-doctor"
                    label="Doctor:"
                    label-for="input-doctor"
                    description="Doctor Handren is selected by default."
                    cols="3"
                  >
                    <b-form-select
                      id="input-doctor"
                      class="form-control py-0"
                      v-model="patient.doctor"
                      size="sm"
                      :options="ops.DOCTOR_CHOICES"
                    ></b-form-select>
                  </b-form-group>
                </b-col>
				 <b-col cols="4">
                  <b-form-group
                    class="form-group py-0"
                    id="input-group-1"
                    label="Gender:"
                    label-for="input-gender"
                  >
                    <b-form-select
                      id="input-gender"
                      class="form-control py-0"
                      v-model="patient.gender"
                      size="sm"
                      :options="ops.GENDER"
                    ></b-form-select>
                  </b-form-group>
                </b-col>
				<b-col cols="4">
					<b-form-group
                    class="form-group py-0"
                    id="input-group-1"
                    label="DOB:"
                    size="sm"
                    label-for="input-dob"
                    cols="3"
                  >
                    <b-form-datepicker
                      v-model="patient.dob"
                      class="py-2"
                     
                      :date-format-options="{
                        year: 'numeric',
                        month: '2-digit',
                        day: '2-digit',
                      }"
                    ></b-form-datepicker>
                  </b-form-group>
				</b-col>
			  </b-row>
              <b-row>
				<b-col cols="12">
                  <b-form-group
                    id="input-group-2"
                    label="Description:"
                    label-for="input-2"
                  >
                    <b-form-textarea
                      id="input-2"
                      v-model="patient.description"
                      placeholder="Describe your patient"
                    ></b-form-textarea rows="3">
                  </b-form-group>
                </b-col>
              </b-row>

              <b-form-group id="input-group-4">
                  <b-form-checkbox v-model="patient.status"
                    >Activate</b-form-checkbox
                  >
              </b-form-group>

              <!-- <b-button type="submit" variant="primary">Submit</b-button> -->
              <!-- <b-button type="reset" variant="outline-danger">Reset</b-button> -->
            </b-form>
            <!-- :style="{opacity: 0, display: 'none'}" -->

          </tab-content>
          <tab-content title="Clinical Examinations" icon="ti-heart">
			  <!-- FIRST FORM ROW -->
			  <b-form-row>
				 <!-- first -->
				  <b-col cols="2" class="mr-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Skeletal:"
                    label-for="input-skeletal"
                  >
                    <b-form-select
                      id="input-skeletal"
                      class="form-control"
                      v-model="patient.examinations.skeletal_class"
                      size="sm"
                      :options="ops.CLASS_CHOICES"
                    ></b-form-select>
                  </b-form-group>
				  </b-col>
			  
			  <!-- second -->
			   <b-col cols="3" class="mx-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Nasolabial Angle:"
                    label-for="input-nasolabial"
                  >
                    <b-form-select
                      id="input-nasolabial"
                      class="form-control"
                      v-model="patient.examinations.nasolabial_angle"
                      :options="ops.NASOLABIAL_ANGLE"
                    ></b-form-select>
                  </b-form-group>
				  </b-col>
				  <!-- third -->
				   <b-col cols="3" class="mx-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Nasolabial Sulcus:"
                    label-for="input-sulcus"
                  >
                    <b-form-select
                      id="input-sulcus"
                      class="form-control"
                      v-model="patient.examinations.nasolabial_sulcus"
                      :options="ops.NASOLABIAL_SULCUS"
                    ></b-form-select>
                  </b-form-group>
				  </b-col>
				  <!-- fourth -->
				   <b-col class="ml-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Overjet:"
                    label-for="input-overjet"
                  >
                    <b-form-textarea
					            id="input-overjet"
                      class="form-control"
                      v-model="patient.examinations.overjet"
                    ></b-form-textarea>
                  </b-form-group>
				  </b-col>
            </b-form-row>
			<!-- SECOND FORM ROW -->
			<b-form-row>
				 <!-- first -->
				  <b-col cols="2" class="mr-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="O-Hygiene:"
                    label-for="input-ohygiene"
                  >
                    <b-form-select
                      id="input-ohygiene"
                      class="form-control"
                      v-model="patient.examinations.oral_hygiene"
                      size="sm"
                      :options="ops.ORAL_HYGIENE"
                    ></b-form-select>
                  </b-form-group>
				  </b-col>
			  
			  <!-- second -->
			   <b-col cols="3" class="mx-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Lip Competency:"
                    label-for="input-lip"
                  >
                    <b-form-select
                      id="input-lip"
                      class="form-control"
                      v-model="patient.examinations.lip_competency"
                      :options="ops.LIP_COMPETENCY"
                    ></b-form-select>
                  </b-form-group>
				  </b-col>
				  <!-- third -->
				   <b-col cols="3" class="mx-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Face Form:"
                    label-for="input-face"
                  >
                    <b-form-select
                      id="input-face"
                      class="form-control"
                      v-model="patient.examinations.face_form"
                      :options="ops.FACE_FORM"
                    ></b-form-select>
                  </b-form-group>
				  </b-col>
				  <!-- fourth -->
				   <b-col class="ml-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Habit:"
                    label-for="input-habit"
                  >
                    <b-form-textarea
					            id="input-habit"
                      class="form-control"
                      v-model="patient.examinations.habit"
                    ></b-form-textarea>
                  </b-form-group>
				  </b-col>
            </b-form-row>
			<!-- THIRD FORM ROW -->
			<b-form-row>
				   <!-- first -->
				  <b-col cols="2" class="mr-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Treated Arch:"
                    label-for="input-tarch"
                  >
                    <b-form-select
                      id="input-tarch"
                      class="form-control"
                      v-model="patient.examinations.treated_arch"
                      size="sm"
                      :options="ops.TREATED_ARCH"
                    ></b-form-select>
                  </b-form-group>
				  </b-col>
			  
			  <!-- second -->
			   <b-col cols="3" class="mx-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Molar Class Left:"
                    label-for="input-mocleft"
                  >
                    <b-form-select
                      id="input-mocleft"
                      class="form-control"
                      v-model="patient.examinations.molar_class_left"
                      :options="ops.CLASS_CHOICES"
                    ></b-form-select>
                  </b-form-group>
				  </b-col>
				  <!-- third -->
				   <b-col cols="3" class="mx-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Molar Class Right:"
                    label-for="input-mocright"
                  >
                    <b-form-select
                      id="input-mocright"
                      class="form-control"
                      v-model="patient.examinations.molar_class_right"
                      :options="ops.CLASS_CHOICES"
                    ></b-form-select>
                  </b-form-group>
				  </b-col>
				  <!-- fourth -->
				   <b-col class="ml-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Tongue Size:"
                    label-for="input-tongue"
                  >
                    <b-form-textarea
					id="input-overjet"
                      class="form-tongue"
                      v-model="patient.examinations.tongue_size"
                    ></b-form-textarea>
                  </b-form-group>
				  </b-col>
            </b-form-row>
			<!-- FOURTH FORM ROW -->
			<b-form-row>
				   <!-- first -->
				  <b-col cols="2" class="mr-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Bracket Sys.:"
                    label-for="input-brastem"
                  >
                    <b-form-select
                      id="input-brastem"
                      class="form-control"
                      v-model="patient.examinations.bracket_system"
                      size="sm"
                      :options="ops.CLASS_CHOICES"
                    ></b-form-select>
                  </b-form-group>
				  </b-col>
			  
			  <!-- second -->
			   <b-col cols="3" class="mx-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Midline Upper:"
                    label-for="input-mupper"
                  >
                    <b-form-select
                      id="input-mupper"
                      class="form-control"
                      v-model="patient.examinations.midline_upper"
                      :options="ops.MIDLINE_CHOICES"
                    ></b-form-select>
                  </b-form-group>
				  </b-col>
				  <!-- third -->
				   <b-col cols="3" class="mx-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Midline Lower:"
                    label-for="input-mower"
                  >
                    <b-form-select
                      id="input-mower"
                      class="form-control"
                      v-model="patient.examinations.midline_lower"
                      :options="ops.MIDLINE_CHOICES"
                    ></b-form-select>
                  </b-form-group>
				  </b-col>
				  <!-- fourth -->
				   <b-col class="ml-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Slot:"
                    label-for="input-slot"
                  >
                    <b-form-textarea
					            id="input-slot"
                      class="form-control"
                      v-model="patient.examinations.slot"
                    ></b-form-textarea>
                  </b-form-group>
				  </b-col>
            </b-form-row>

          <!-- FIFTH FORM ROW -->
			<b-form-row>
				   <!-- first -->
				  <b-col cols="2" class="mr-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Extraction Upper:"
                    label-for="input-extupper"
                  >
                    <b-form-select
                      id="input-extupper"
                      class="form-control"
                      v-model="patient.examinations.extraction_upper"
                      size="sm"
                      :options="ops.CLASS_CHOICES"
                    ></b-form-select>
                  </b-form-group>
				  </b-col>
			  
			  <!-- second -->
			   <b-col cols="3" class="mx-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Extraction Lower:"
                    label-for="input-extower"
                  >
                    <b-form-select
                      id="input-extower"
                      class="form-control"
                      v-model="patient.examinations.extraction_lower"
                      :options="ops.CLASS_CHOICES"
                    ></b-form-select>
                  </b-form-group>
				  </b-col>
				  <!-- third -->
				   <b-col cols="3" class="mx-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Anchorage Upper:"
                    label-for="input-anchoper"
                  >
                    <b-form-select
                      id="input-anchoper"
                      class="form-control"
                      v-model="patient.examinations.anchorage_upper"
                      :options="ops.CLASS_CHOICES"
                    ></b-form-select>
                  </b-form-group>
				  </b-col>
				  <!-- fourth -->
				   <b-col class="ml-1">
					  <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Treatment Plan:"
                    label-for="input-treaplan"
                  >
                    <b-form-textarea
					            id="input-treaplan"
                      class="form-control"
                      v-model="patient.examinations.treatment_plan"
                    ></b-form-textarea>
                  </b-form-group>
				  </b-col>
            </b-form-row>
            
          </tab-content>
          <tab-content title="Medical Examinations" icon="ti-heart">
           <b-form-row>
             <b-col>
               <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Physical Restrictions:"
                    label-for="input-physical"
                  >
                    <b-form-select
					            id="input-physical"
                      class="form-control"
                      v-model="patient.medicals.physical_restrictions"
                      :options="ops.MEDICALS"
                    ></b-form-select>
                  </b-form-group>
             </b-col>
             <b-col>
               <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Sinus Infections:"
                    label-for="input-physical"
                  >
                    <b-form-select
					            id="input-physical"
                      class="form-control"
                      v-model="patient.medicals.sinus_infections"
                      :options="ops.MEDICALS"
                    ></b-form-select>
                  </b-form-group>
             </b-col>
             <b-col>
               <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Diabetes:"
                    label-for="input-physical"
                  >
                    <b-form-select
					            id="input-physical"
                      class="form-control"
                      v-model="patient.medicals.diabetes"
                      :options="ops.MEDICALS"
                    ></b-form-select>
                  </b-form-group>
             </b-col>
           </b-form-row>
           <!-- MEDICALS SECOND ROW -->
           <b-form-row>
             <b-col>
               <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Heart Problems:"
                    label-for="input-physical"
                  >
                    <b-form-select
					            id="input-physical"
                      class="form-control"
                      v-model="patient.medicals.heart_problem"
                      :options="ops.MEDICALS"
                    ></b-form-select>
                  </b-form-group>
             </b-col>
             <b-col>
               <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Kidney Illness:"
                    label-for="input-physical"
                  >
                    <b-form-select
					            id="input-physical"
                      class="form-control"
                      v-model="patient.medicals.kidney_illness"
                      :options="ops.MEDICALS"
                    ></b-form-select>
                  </b-form-group>
             </b-col>
             <b-col>
               <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Emotional Difficulties:"
                    label-for="input-physical"
                  >
                    <b-form-select
					            id="input-physical"
                      class="form-control"
                      v-model="patient.medicals.emotional_difficulties"
                      :options="ops.MEDICALS"
                    ></b-form-select>
                  </b-form-group>
             </b-col>
             <!-- MEDICALS THIRD ROW -->
          </b-form-row>
           <b-form-group
                    class="form-group"
                    id="input-group-1"
                    label="Other Diseasses:"
                    label-for="input-otherDs"
                  >
                    <b-form-textarea
					            id="input-otherDs"
                      class="form-control"
                      v-model="patient.medicals.other_diseasses"
                      rows="3"
                    ></b-form-textarea>
                  </b-form-group>
          <b-form-row>
            <b-col>

            </b-col>
          </b-form-row>
          </tab-content>
          <tab-content title="Last step" icon="ti-check"
            >This patient is ready to be added... click DONE!</tab-content
          >

          <template slot="footer" slot-scope="props">
            <div class="wizard-footer-left">
              <wizard-button
                v-if="props.activeTabIndex > 0 && !props.isLastStep"
                @click.native="props.prevTab()"
                :style="props.fillButtonStyle"
                >Previous</wizard-button
              >
              <!-- {{props.activeTabIndex}} - {{props.isLastStep}} -->
            </div>

            <div class="wizard-footer-right">
              <wizard-button
                v-if="!props.isLastStep"
                @click.native="props.nextTab()"
                class="wizard-footer-right"
                :style="props.fillButtonStyle"
                >Next</wizard-button
              >

              <wizard-button
                v-else
                @click.native="done('Done')"
                class="wizard-footer-right finish-button"
                :style="props.fillButtonStyle"
                >{{ props.isLastStep ? "Done" : "Next" }}</wizard-button
              >
            </div>
          </template>
        </form-wizard>
      </client-only>

      <!-- <b-button class="mt-3" variant="outline-danger" block @click="hideModal">Close Me</b-button> -->
      <!-- <b-button class="mt-2" variant="outline-warning" block @click="toggleModal">Toggle Me</b-button> -->
   
  </div>
</template>
<script>
// import VueFormGenerator from 'vue-form-generator'
// import 'vue-form-generator/dist/vfg.css'
// import { patientOptions, examinations } from "../../static/data/choices";
import { choices, mutateChoices } from "../../store/utils/choices";
export default {
  props: ["editPatient", "edit"],
  created() {
    // console.log('CREATED ', this.patient)
    if (this.edit) {
       this.patient = Object.assign({}, this.$store.state.currentPatient);
    this.patient.examinations = Object.assign({}, this.$store.state.currentPatient.examinations);
    this.patient.medicals = Object.assign({}, this.$store.state.currentPatient.medicals);
    } else {
      this.patient = choices.patient;
    }
   
    // console.log('Left ', this.patient)

  },
  data() {
    return {
      show: true,
      formatted: "",
      patient: {},
    }
  },
  methods: {
    onComplete: function () {
      alert("Yay. Done!");
    },
    showModal() {
      this.$refs["my-modal"].show();
    },
    hideModal() {
      this.$refs["my-modal"].hide();
    },
    toggleModal() {
      // We pass the ID of the button that we want to return focus to
      // when the modal has hidden
      this.$refs["my-modal"].toggle("#toggle-btn");
    },
    isLastStep() {
      if (this.$refs.wizard) {
        return this.$refs.wizard.isLastStep;
      }
      return false;
    },
    done(msg) {
      // alert(msg);
      let formData = new FormData();
      // formData.append('id', this.patient.id);
      // formData.append('user', this.patient.user);
      formData.append('name', this.name);
      //formData.append('address', 1);
      //formData.append('age', 0);
      formData.append('doctor', this.doctor);
      formData.append('dob', this.dob);
      formData.append('gender', this.gender);
      formData.append('description', this.description);
      formData.append('phone', this.phone);
      formData.append('email', this.email);
      formData.append('examinations', this.examinations);
      formData.append('medicals', this.medicals);
      formData.append('status',this.status);

      // --------------------
        let data = {
        
        "name": this.name,
        "doctor": this.doctor,
        "dob": this.dob,
        "gender": this.gender,
        "description": this.description,
        "phone": this.phone,
        "email": this.email,        
        "examinations": this.examinations,
        "medicals": this.medicals,
        "status": this.status
    }




      // --------------------

      // console.log(this.patient)

      /* DISPATCH ACTION @STORE */
      if(this.patient.id === undefined) {
        console.log('ADD PATIENT')
        this.$store.dispatch('addPatient', {vm : this, payload : this.patient});
        
      } else {
        console.log('EDIT PATIENT')
        
        this.$store.dispatch('editPatient', this.patient);
      }
      
      this.hide();
      

    },
    hide() {
      this.show = !this.show
      this.$emit('hideModal');
    },
    onSubmit(evt) {
      evt.preventDefault();
      alert(JSON.stringify(this.form));
    },
    onReset(evt) {
      evt.preventDefault();
      // Reset our form values
      this.form.email = "";
      this.form.name = "";
      this.form.food = null;
      this.form.checked = [];
      // Trick to reset/clear native browser form validation state
      this.show = false;
      this.$nextTick(() => {
        this.show = true;
      });
    },
  },
  computed: {
    ops() {
      return choices;
    },
    patiented() {
      // get() {
        return this.editPatient
      // return this.$store.state.currentPatient;
      // },
      // set (value) {
      // console.log(value);
      // this.$store.dispatch('updateCurrentPatientState', value);
    
      
    },
    
  },
};
</script>
