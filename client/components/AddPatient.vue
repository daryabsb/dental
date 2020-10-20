<template>
    <div class="my-modal"  >
        
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            {{editPatient}}
            <div class="modal-header">
                <h5 class="modal-title mt-0" >Add a New Patient</h5>
                <button type="button" @click="closeModal()" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="PatientName">Patient Name</label>
                                <input v-model="name" type="text" name="name" class="form-control" required="">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="PatientName_select" class="mr-2">Doctor Name</label>
                                <select  class="form-control">
                                    <option selected="">-- Select --</option>
                              <option
                                v-for="d in doctor"
                                :key="d.id"
                                :value="d.id"
                                :selected="onChangeDoctor(d.id)"
                              >{{d.name}}</option>
                            </select>
                                        </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="PatientName">DOB</label>
                                <input type="date" name="dob" class="form-control"  v-model="dob">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="gender">Gender</label>
                                <select v-model="selGender" name="gender" class="custom-select" >
                                    <option value="male">Male</option>
                                    <option value="female">Female</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="phone">Phone</label>
                                <input type="text" v-model="phone" name="phone" class="form-control"  required="">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="text" v-model="email" name="email" class="form-control"  required="">
                            </div>
                        </div>
                       
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="note">Note</label>
                                <textarea name="note" v-model="description" rows="5" class="form-control" ></textarea>
                            </div>
                        </div>
                    </div>
                    <button type="button" @click="addNewPatient()" class="btn btn-sm btn-primary">Save</button>
                    <button type="button" @click="closeModal()" class="btn btn-sm btn-danger">Delete</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
    </div>


    
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default {
    props: ['editPatient'],
    data(){
        return {
            name: 'this.editPatient.name',
            doctor: [{'id':1, 'name': 'Handren Ameer Kurda'}],
            selDoctor:  'this.editPatient.doctor',
            dob: 'this.editPatient.dob',
            gender: [
                {'male': 'Male'}, 
                {'female': 'Femal'}
                ],
            selGender: 'this.editPatient.gender',
            description: 'this.editPatient.description',
            phone: 'this.editPatient.phone',
            email: 'this.editPatient.email',
            state:  'this.editPatient.state',
            status: [
                {'active': 'true'},
                {'inactive': 'false'}
                ]

        }
    },
    
    methods: {
        onChangeDoctor(id) {
            this.selDoctor = id
        },
        addNewPatient () {

            /* CREATE PAYLOAD FROM FORM  */

            let formData = new FormData();
            formData.append('user', 1);
            formData.append('name', this.name);
            formData.append('doctor', this.selDoctor);
            formData.append('dob', this.dob);
            formData.append('gender', this.selGender);
            formData.append('description', this.description);
            formData.append('phone', this.phone);
            formData.append('email', this.email);
            formData.append('status', this.state);

            console.log(Array.from(formData))

            /* DISPATCH ACTION @STORE */
            this.$store.dispatch('addPatient', formData);

            // CLOSE FORM
            this.closeModal()
            //this.$emit('toggle-show');
        },
        closeModal() {
            this.$emit('toggle-show');
        }

    }
}
</script>
<style scoped>
.my-modal {
    position: fixed;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    z-index: 1000;
    background-color: rgb(0,0,0,.2);
    display: none;
    
}
.show {
    display: block;
}

</style>



