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

                                <div class="input-group mb-3">
                                    <!-- VUE UPLOAD AGENT -->
                                <vue-dropzone ref="myVueDropzone" id="dropzone" :options="dropzoneOptions"></vue-dropzone>
                                </div>
                                    <!-- :accept="'image/*,.zip'" -->
                                </div>

                                <!-- <div class="bd-example"> -->


                                <div class="input-group mb-3 ">
                                    
                                    <h4>SOMETHING HERE</h4>
                                </div>


                                <!-- FILE WILL BE DROPPED HERE -->
                                <div id="attached-list">
                                    SOMETHING ELSE HERE

                                </div>

                                <!-- FILE DROP END -->
                                <div role="alert" class="alert alert-light mb-0">
                                    <h4 class="alert-heading font-18">title</h4>
                                    <ul>

                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                                    
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" @click="closeModal" class="btn btn-secondary waves-effect" data-dismiss="modal">Close</button>
                                                    <button type="button" class="btn btn-primary waves-effect waves-light">Save changes</button>
                                                </div>
                                            </div><!-- /.modal-content -->
                                        </div><!-- /.modal-dialog -->
                                    </div>
</template>

<script>

import { store, mutations } from '../../store/utils/conf';
import vue2Dropzone from 'vue2-dropzone'
import 'vue2-dropzone/dist/vue2Dropzone.min.css'

export default {
    components: {
    vueDropzone: vue2Dropzone
    },
    data () {
      return {
          dropzoneOptions: {
          url: 'http://127.0.0.1:8000/patients/26/attachments/create/',
          thumbnailWidth: 150,
          maxFilesize: 100,
          headers: { "Content-Type": "multipart/form-data" }
      }
     
      };
    },

    methods: {
        
        closeModal() {
            //console.log(this.name)
            // this.$emit('toggle-show');
            store.isEditModal = false;
            mutations.toggleTreatment();
        },
        
     
    
    },
    
    computed: {
        isTreatmentOpen() {
            return store.isTreatmentOpen
        }
    }
}
</script>


  components: {
    vueDropzone: vue2Dropzone
  },
  data: function () {
    return {
      dropzoneOptions: {
          url: 'https://httpbin.org/post',
          thumbnailWidth: 150,
          maxFilesize: 0.5,
          headers: { "My-Awesome-Header": "header value" }
      }
    }
  }

