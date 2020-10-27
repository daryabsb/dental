<template>
   
<div class="my-modal" v-if="isUserModalOpen">   
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title mt-0" >Add a New User</h5>
                <button type="button" @click="closeModal()" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="PatientName">User Full Name</label>
                                <input v-model="user.name" type="text" name="name" class="form-control" required="">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" v-model="user.email" name="email" class="form-control"  required="">
                            </div>
                        </div>
                       
                    </div>
                    <div class="row" v-if="!isEditModalToHide">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" v-model="user.password" name="password" class="form-control"  required="">
                            </div>
                        </div>
                       
                    </div>
                     <div class="row" v-if="!isEditModalToHide">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="password">Confirm Password</label>
                                <input type="password" v-model="password2" name="password" class="form-control"  required="">
                            </div>
                        </div>
                       
                    </div>
                   
                    <button type="button" @click="addNewUser()" class="btn btn-sm btn-primary">Save</button>
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
    props: ['editId', 'editName', 'editEmail', 'editIsStaff'],

    data(){
        return {
            name: '',
           password: '',
           password2: '',
            email: '',
            isStaff:  '',

        }
    },
    
    methods: {
        
        addNewUser () {

            /* CREATE PAYLOAD FROM FORM  */
            if (!this.editId) {
                let formData = new FormData();
                formData.append('name', this.user.name);
                formData.append('email', this.user.email);
                formData.append('password', this.user.password);
                formData.append('is_staff', this.user.isStaff);

            /* DISPATCH ACTION @STORE */
            this.$store.dispatch('addUser', formData);
            
            // clearing the form
            formData.reset();



            } else {
                let data = {  
                    "id": this.user.id,
                    "name": this.user.name,
                    "email": this.user.email,
                    "is_staff": this.user.isStaff  
                }

                this.$store.dispatch('editUser', data);
               
            }
            
            // CLOSE FORM
            // this.closeModal();
            store.isEditModal = false;
            mutations.toggleUserModal();
            //this.$emit('toggle-show');
        },
        closeModal() {
            //console.log(this.name)
            // this.$emit('toggle-show');
            store.isEditModal = false;
            mutations.toggleUserModal();
        }

    },
    computed: {
        isEditModalToHide() {
            return store.isEditModal
        },
        isUserModalOpen() {
            return store.isUserModalOpen
        },
        user: {
            // getter
            get: function () {
                if(store.isEditModal) {
                    return {
                        'id': this.editId,
                        'name': this.editName,
                         'email': this.editEmail,
                        'status': this.editIsStaff

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
<style>
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



