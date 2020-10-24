<template>
    <div class="my-modal" v-if="isTreatmentOpen" >
                                        <div class="modal-dialog modal-xl">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title mt-0" id="myModalLabel">Modal Heading</h5>
                                                    <button @click="closeModal" type="button" class="close">×</button>
                                                </div>
                                                <div class="modal-body">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                 <div class="input-group mb-1">
                                    <!-- <div class="alert alert-outline-danger">
                                    <p class="alert-heading font-12">Lorem ipsum dolor sit amet consectetur adipisicing elit.</p>
                                </div> -->

                                </div>
                                <div class="input-group mb-1 ">                                
                                    <label for="title" class="inline mr-3"><h4>TITLE: </h4></label>
                                    <input v-model="title" name="title" class="form-control" />
                                </div>
                                 <div class="form-group mb-1">
                                            <label for="exampleFormControlTextarea1">Description</label>
                                            <textarea v-model="description" class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
                                        </div>
                                <div class="input-group mb-3">
                                    <!-- VUE UPLOAD AGENT -->
                                
                                <Dropzone />
                                </div>
                                   
                    
                <button type="button" @click="closeModal" class="btn btn-secondary waves-effect">Close</button> 
                <button @click="onSaveTreatment" type="button" class="btn btn-primary waves-effect waves-light">Save changes</button>     
                                </div>
                                             
 
                            </div>
                             <div class="modal-footer">
                          
            </div>
                        </div>
                    </div>
                </div>
                                                    
                                                </div>
                                               
                                            </div><!-- /.modal-content -->
                                        </div><!-- /.modal-dialog -->
</template>

<script>

import { store, mutations } from '../../store/utils/conf';

export default {
    props: ['patientId'],
    data() {
        return {
            title: '',
            description: '',
        }
    },
    methods: {
        onSaveTreatment() {

            //console.log(this.$auth.user)
            
            let files = this.$store.state.files.map(file=>file.id);

            console.log(files)
            
            let formData = new FormData();
            formData.append('user', this.$auth.user.id);
            formData.append('patient', this.patientId);
            formData.append('title', this.title);
            formData.append('description', this.description);
            formData.append('files', this.$store.state.files);

            this.$store.dispatch('addNewTreatment', formData);
            this.closeModal()
        },
        closeModal() {
            //console.log(this.name)
            // this.$emit('toggle-show');
            store.isEditModal = false;
            mutations.toggleTreatment();
        },
    },
    computed: {
        pId() {
            return this.patientId
        },
        isTreatmentOpen() {
            return store.isTreatmentOpen
        }
    }
}
</script>