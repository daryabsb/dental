<template>
<div>
    
 <b-button id="show-btn" size="sm" @click="showModal">Open Modal</b-button>
    <b-button id="toggle-btn" size="sm" @click="toggleModal">Toggle Modal</b-button>

    <b-modal size="lg" ref="my-modal" hide-footer title="Using Component Methods">
        <client-only>
   <form-wizard 
          shape="square" 
          @on-complete="onComplete" 
          ref="wizard" color="#4ac7ec"
          >
      <tab-content title="Personal details" icon="ti-user">
        
        
        
        
        <b-form @submit="onSubmit" @reset="onReset" v-if="show">
      <b-form-group
        id="input-group-1"
        label="Email address:"
        label-for="input-1"
        description="We'll never share your email with anyone else."
      >
        <b-form-input
          id="input-1"
          v-model="form.email"
          type="email"
          required
          placeholder="Enter email"
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-2" label="Your Name:" label-for="input-2">
        <b-form-input
          id="input-2"
          v-model="form.name"
          required
          placeholder="Enter name"
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-3" label="Food:" label-for="input-3">
        <b-form-select
          id="input-3"
          v-model="form.food"
          :options="foods"
          required
        ></b-form-select>
      </b-form-group>

      <b-form-group id="input-group-4">
        <b-form-checkbox-group v-model="form.checked" id="checkboxes-4">
          <b-form-checkbox value="me">Check me out</b-form-checkbox>
          <b-form-checkbox value="that">Check that out</b-form-checkbox>
        </b-form-checkbox-group>
      </b-form-group>

      <!-- <b-button type="submit" variant="primary">Submit</b-button> -->
      <b-button type="reset" variant="outline-danger">Reset</b-button>
    </b-form>
    <b-card class="mt-3" :style="{opacity: 0, display: 'none'}" header="Form Data Result">
      <pre class="m-0">{{ form }}</pre>
    </b-card>



      </tab-content>
      <tab-content title="Additional Info" icon="ti-heart">
        <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="PatientName">Patient Name</label>
                                <input  type="text" name="name" class="form-control" required="">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="PatientName_select" class="mr-2">Doctor Name</label>
                                <select  class="form-control">
                              
                            </select>
                                        </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="PatientName">DOB</label>
                                <input type="date" name="dob" class="form-control">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="gender">Gender</label>
                                <select  name="gender" class="custom-select" >
                                    <option value="male">Male</option>
                                    <option value="female">Female</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="phone">Phone</label>
                                <input type="text"  name="phone" class="form-control"  required="">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="text"  name="email" class="form-control"  required="">
                            </div>
                        </div>
                       
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="note">Note</label>
                                <textarea name="note"  rows="5" class="form-control" ></textarea>
                            </div>
                        </div>
                    </div>
      </tab-content>
      <tab-content title="Additional Info" icon="ti-heart">
        <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="PatientName">Patient Name</label>
                                <input  type="text" name="name" class="form-control" required="">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="PatientName_select" class="mr-2">Doctor Name</label>
                                <select  class="form-control">
                              
                            </select>
                                        </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="PatientName">DOB</label>
                                <input type="date" name="dob" class="form-control">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="gender">Gender</label>
                                <select  name="gender" class="custom-select" >
                                    <option value="male">Male</option>
                                    <option value="female">Female</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="phone">Phone</label>
                                <input type="text"  name="phone" class="form-control"  required="">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="text"  name="email" class="form-control"  required="">
                            </div>
                        </div>
                       
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="note">Note</label>
                                <textarea name="note"  rows="5" class="form-control" ></textarea>
                            </div>
                        </div>
                    </div>
      </tab-content>
      <tab-content title="Last step" icon="ti-check">
        Yuhuuu! This seems pretty damn simple
      </tab-content>
      
      
      <template slot="footer" slot-scope="props">
       <div class=wizard-footer-left>
           <wizard-button  v-if="props.activeTabIndex > 0 && !props.isLastStep" @click.native="props.prevTab()" :style="props.fillButtonStyle">Previous</wizard-button>
           <!-- {{props.activeTabIndex}} - {{props.isLastStep}} -->
        </div>



        <div class="wizard-footer-right">
          <wizard-button v-if="!props.isLastStep" @click.native="props.nextTab()" class="wizard-footer-right" :style="props.fillButtonStyle">Next</wizard-button>
          
          <wizard-button 
          v-else @click.native="done('Done')" class="wizard-footer-right finish-button" :style="props.fillButtonStyle">{{props.isLastStep ? 'Done' : 'Next'}}</wizard-button>
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

export default {
    props: ['patientID'],
    data(){
      return {
       
       form: {
          email: '',
          name: '',
          food: null,
          checked: []
        },
        foods: [{ text: 'Select One', value: null }, 'Carrots', 'Beans', 'Tomatoes', 'Corn'],
        show: true
        
  
      }
   
 },
 methods: {
  onComplete: function(){
      alert('Yay. Done!');
   },
   showModal() {
        this.$refs['my-modal'].show()
      },
      hideModal() {
        this.$refs['my-modal'].hide()
      },
      toggleModal() {
        // We pass the ID of the button that we want to return focus to
        // when the modal has hidden
        this.$refs['my-modal'].toggle('#toggle-btn')
      },
      isLastStep() {
      if (this.$refs.wizard) {

        return this.$refs.wizard.isLastStep
      }
      return false
    },
    done(msg) {
      alert(msg)
      this.hideModal()
    },
    onSubmit(evt) {
        evt.preventDefault()
        alert(JSON.stringify(this.form))
      },
      onReset(evt) {
        evt.preventDefault()
        // Reset our form values
        this.form.email = ''
        this.form.name = ''
        this.form.food = null
        this.form.checked = []
        // Trick to reset/clear native browser form validation state
        this.show = false
        this.$nextTick(() => {
          this.show = true
        })
      }
    
   
   
  }
}
</script>

<style>
* { 
  margin: 0;
  padding: 0;
}
</style>