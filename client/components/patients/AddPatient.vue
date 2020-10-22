<template>
   
<div class="my-modal" v-if="isAddPatientModalOpen">   
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title mt-0" >Add a New Patient</h5>
                <button type="button" @click="closeModal()" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="PatientName">Patient Name</label>
                                <input v-model="patient.name" type="text" name="name" class="form-control" required="">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="PatientName_select" class="mr-2">Doctor Name</label>
                                <select v-model="patient.doctor"  class="form-control">
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
                                <input type="date" name="dob" class="form-control"  v-model="patient.dob">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="gender">Gender</label>
                                <select v-model="patient.gender" name="gender" class="custom-select" >
                                    <option value="male">Male</option>
                                    <option value="female">Female</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="phone">Phone</label>
                                <input type="text" v-model="patient.phone" name="phone" class="form-control"  required="">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="text" v-model="patient.email" name="email" class="form-control"  required="">
                            </div>
                        </div>
                       
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="note">Note</label>
                                <textarea name="note" v-model="patient.description" rows="5" class="form-control" ></textarea>
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
import { store, mutations } from '../../store/utils/conf'
export default {
    props: ['editId', 'editUser', 'editName', 'editDoctor', 'editDob', 'editGender', 'editPhone', 'editEmail', 'editDescription', 'editStatus'],

    data(){
        return {
            //patient: [],
            name: '',
            doctor: [{'id':1, 'name': 'Handren Ameer Kurda'}],
            selDoctor:  '',
            dob: '',
            gender: [
                {'male': 'Male'}, 
                {'female': 'Femal'}
                ],
            selGender: '',
            description: '',
            phone: '',
            email: '',
            state:  '',
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
            if (!this.editId) {
                let formData = new FormData();
                formData.append('id', this.patient.id);
                formData.append('user', this.patient.user);
                formData.append('name', this.patient.name);
                //formData.append('address', 1);
                //formData.append('age', 0);
                formData.append('doctor', this.patient.doctor);
                formData.append('dob', this.patient.dob);
                formData.append('gender', this.patient.gender);
                formData.append('description', this.patient.description);
                formData.append('phone', this.patient.phone);
                formData.append('email', this.patient.email);
                formData.append('status', this.patient.status);

            /* DISPATCH ACTION @STORE */
            this.$store.dispatch('addPatient', formData);
            
            // clearing the form
            formData.reset();



            } else {
                let data = {  
                    "id": this.patient.id,
                    "user": this.patient.user,
                    "name": this.patient.name,
                    "doctor": this.patient.doctor,
                    "dob": this.patient.dob,
                    "gender": this.patient.gender,
                    "description": this.patient.description,
                    "phone": this.patient.phone,
                    "email": this.patient.email,
                    "status": this.patient.status  
                }

                this.$store.dispatch('editPatient', data);
               
            }
            
            // CLOSE FORM
            // this.closeModal();
            store.isEditModal = false;
            mutations.toggleAddPatientModal();
            //this.$emit('toggle-show');
        },
        closeModal() {
            //console.log(this.name)
            // this.$emit('toggle-show');
            store.isEditModal = false;
            mutations.toggleAddPatientModal();
        }

    },
    computed: {
        isAddPatientModalOpen() {
            return store.isAddPatientModalOpen
        },
        patient: {
            // getter
            get: function () {
                if(store.isEditModal) {
                    return {
                        'id': this.editId,
                        'user': this.editUser,
                        'name': this.editName,
                        'doctor': this.editDoctor,
                        'dob': this.editDob,
                        'description': this.editDescription,
                        'phone': this.editPhone,
                        'email': this.editEmail,
                        'gender': this.editGender,
                        'status': this.editStatus

                        }
                } 
                return {}
            
            },
            // setter
            set: function (newValue) {
            console.log(newValue);
            }
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
    display: block;
    
}

</style>



