<template>
   
<div class="my-modal" v-if="isUserModalOpen">   
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title mt-0" >Add a New User</h5>
                <button type="button" @click="closeModal()" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                
                <div class="col-12 align-self-center">
                <div class="auth-page">
                    <div class="card auth-card shadow-lg">
                        <div class="card-body">
                            <div class="px-3">
                                <div class="auth-logo-box align-items-center text-center">
                                    <a href="../analytics/analytics-index.html" class="logo logo-admin"><img src="~assets/images/logo-sm-2.png" height="55" alt="logo" class="auth-logo"></a>
                                </div><!--end auth-logo-box-->
        
                                    <div class="form-group">
                                        <label for="username">Email</label>
                                        <div class="input-group mb-3">
                                            <span class="auth-form-icon mr-3">
                                                <i class="dripicons-mail"></i> 
                                            </span>                                                                                                              
                                            <input v-model="user.email" type="email" class="form-control"  placeholder="Enter a valid email">
                                        </div>                                    
                                    </div><!--end form-group--> 

                                    <div class="form-group">
                                        <label for="username">Full Name</label>
                                        <div class="input-group mb-3">
                                            <span class="auth-form-icon  mr-3">
                                                <i class="dripicons-user"></i> 
                                            </span>                                                                                                              
                                            <input  v-model="user.name" type="text" class="form-control"  placeholder="Enter Full Name">
                                        </div>                                    
                                    </div><!--end form-group--> 

                                    <div class="form-group" v-if="!isEditModalToHide">
                                        <label for="userpassword">Password</label>                                            
                                        <div class="input-group mb-3"> 
                                            <span class="auth-form-icon">
                                                <i class="dripicons-lock mr-3"></i> 
                                            </span>                                                       
                                            <input v-model="user.password" type="password" class="form-control" placeholder="Enter password">
                                        </div>                               
                                    </div><!--end form-group--> 

        
                                    <div class="form-group row mt-4">
                                        <div class="col-sm-12">
                                            <div class="custom-control custom-switch switch-success">
                                                <input v-model="user.isStaff" type="checkbox" class="custom-control-input mr-3" id="isStaff">
                                                <label class="custom-control-label text-muted" for="isStaff">Add this user as an ADMIN</label>
                                            </div>
                                        </div><!--end col-->                                             
                                    </div><!--end form-group--> 
        
                                    <div class="form-group mb-0 row">
                                        <div class="col-6 mt-2">

                                            <button 
                                                class="btn btn-primary btn-round btn-block waves-effect waves-light"  
                                                @click="addNewUser()"
                                                v-if="!isEditModalToHide"
                                            >Register <i class="fas fa-sign-in-alt ml-1"></i>
                                            </button>
                                            <button 
                                                class="btn btn-primary btn-round btn-block waves-effect waves-light"  
                                                @click="addNewUser()"
                                                v-else
                                            >Update <i class="fas fa-sign-in-alt ml-1"></i>
                                            </button>

                                        </div><!--end col--> 
                                        <div class="col-6 mt-2">
                                            <button class="btn btn-primary btn-round btn-block waves-effect waves-light" @click="closeModal()">Cancel <i class="fas fa-sign-in-alt ml-1"></i></button>
                                        </div><!--end col--> 
                                    </div> <!--end form-group-->                           
                               
                            </div><!--end /div-->
                
                        </div><!--end card-body-->
                    </div>
                </div></div>
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
            isStaff:  false,

        }
    },
    
    methods: {
        
        addNewUser () {

            /* CREATE PAYLOAD FROM FORM  */
            if (!this.editId) {
                console.log(this.user)
   
                let formData = new FormData();
                formData.append('email', this.user.email);
                formData.append('password', this.user.password);
                formData.append('name', this.user.name);
                // formData.append('password2', this.password2);
                formData.append('is_staff', this.user.isStaff);

                console.log(Array.from(formData))

            /* DISPATCH ACTION @STORE */
            this.$store.dispatch('addUser', formData);
          
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
                        'isStaff': this.editIsStaff

                        }
                } 
                return {
                    'id': '',
                        'name': '',
                         'email': '',
                        'isStaff': false
                }
            
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



