<template>
  <div>
    <!-- <select id="sel2" class="form-control">
        <option
        v-for="d in allData.CLASS_CHOICES"
        :key="d.value"
        :value="d.value">{{d.display}}</option>
      </select>
		-->

    <b-button
      variant="primary"
      id="show-btn"
      size="md"
      class="mb-3"
      @click="showModal"
    >
      <i class="mdi mdi-plus-circle-outline mr-2"></i>Add New Patient
    </b-button>
    <!-- <b-button id="toggle-btn" size="sm" @click="toggleModal">Toggle Modal</b-button> -->

    <b-modal
      variant="primary"
      size="lg"
      ref="my-modal"
      hide-footer
      title="Add a new patient"
    >
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
                    label-for="input-1"
                    cols="3"
                  >
                    <b-form-input
                      class="form-control py-0"
                      id="input-1"
                      v-model="name"
                      type="text"
                      placeholder="Enter patient's name"
                    ></b-form-input>
                  </b-form-group>
                </b-col>
                <b-col cols="4">
                  <b-form-group
                    id="input-group-2"
                    label="Phone Number:"
                    label-for="input-2"
                  >
                    <b-form-input
                      id="input-2"
                      v-model="phone"
                      placeholder="Ex: 0770 XXX XXXX"
                    ></b-form-input>
                  </b-form-group>
                </b-col>
                <b-col cols="4">
                  <b-form-group
                    id="input-group-2"
                    label="Email:"
                    label-for="input-2"
                  >
                    <b-form-input
                      id="input-2"
                      v-model="email"
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
                    id="input-group-1"
                    label="Doctor:"
                    label-for="input-doctor"
                    description="Doctor Handren is selected by default."
                    cols="3"
                  >
                    <b-form-select
                      id="input-doctor"
                      class="form-control py-0"
                      v-model="doctor"
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
                      v-model="gender"
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
                      v-model="dob"
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
                      v-model="description"
                      placeholder="Describe your patient"
                    ></b-form-textarea rows="3">
                  </b-form-group>
                </b-col>
              </b-row>

              <b-form-group id="input-group-4">
                <b-form-checkbox-group id="checkboxes-4">
                  <b-form-checkbox v-model="status"
                    >Check me out</b-form-checkbox
                  >
                </b-form-checkbox-group>
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
                      v-model="examinations.skeletal_class"
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
                      v-model="examinations.nasolabial_angle"
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
                      v-model="examinations.nasolabial_sulcus"
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
                      v-model="examinations.overjet"
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
                      v-model="examinations.oral_hygiene"
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
                    label="Nasolabial Angle:"
                    label-for="input-nasolabial"
                  >
                    <b-form-select
                      id="input-nasolabial"
                      class="form-control"
                      v-model="examinations.nasolabial_angle"
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
                      v-model="examinations.nasolabial_sulcus"
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
                      v-model="examinations.overjet"
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
                      v-model="examinations.treated_arch"
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
                    label="Nasolabial Angle:"
                    label-for="input-nasolabial"
                  >
                    <b-form-select
                      id="input-nasolabial"
                      class="form-control"
                      v-model="examinations.nasolabial_angle"
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
                      v-model="examinations.nasolabial_sulcus"
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
                      v-model="examinations.overjet"
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
                    label="Skeletal:"
                    label-for="input-skeletal"
                  >
                    <b-form-select
                      id="input-skeletal"
                      class="form-control"
                      v-model="examinations.skeletal_class"
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
                      v-model="examinations.nasolabial_angle"
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
                      v-model="examinations.nasolabial_sulcus"
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
                      v-model="examinations.overjet"
                    ></b-form-textarea>
                  </b-form-group>
				  </b-col>
            </b-form-row>
            
          </tab-content>
          <tab-content title="Additional Info" icon="ti-heart">
            <h2>MEDICAL EXAMINATIONS</h2>
          </tab-content>
          <tab-content title="Last step" icon="ti-check"
            >Yuhuuu! This seems pretty damn simple</tab-content
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
    </b-modal>
  </div>
</template>
<script>
// import VueFormGenerator from 'vue-form-generator'
// import 'vue-form-generator/dist/vfg.css'
// import { patientOptions, examinations } from "../../static/data/choices";
import { choices } from "../../store/utils/choices";
export default {
  props: ["patientID"],
  data() {
    return {
      name: "",
      doctor: 1,
      dob: "",
      gender: null,
      description: "",
      phone: "",
      email: "",
      status: true,

      examinations: {
        patient: null,
        skeletal_class: null,
        nasolabial_angle: null,
        nasolabial_sulcus: null,
        lip_competency: null,
        face_form: null,
        molar_class_left: null,
        molar_class_right: null,
        midline_upper: null,
        midline_lower: null,
        overjet: "",
        oral_hygiene: null,
        treatment_plan: "",
        slot: "normal",
        treated_arch: "max",
        bracket_system: "steel",
        extraction_upper: "normal",
        extraction_lower: "normal",
        anchorage_upper: "normal",
      },
      show: true,
      formatted: "",
    };
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
      alert(msg);
      this.hideModal();
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
    doctorList() {
      return choices.DOCTOR_CHOICES;
    },
  },
};
</script>
