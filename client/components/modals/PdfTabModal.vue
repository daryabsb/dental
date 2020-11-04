<template>
    <div class="my-modal" v-if="isPdfTabModalOpen">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                 <div class="modal-header">
                <h5 class="modal-title mt-0" >Add a New User</h5>
                <button type="button" @click="closeTabModal()" class="close">×</button>
            </div>
         
             <client-only>
  <v-bar
      wrapper="wrapper"
      vBar="verticalBarClass"
      vBarInternal="verticalBarInternalClass"
      hBar="horizontalBarClass"
      hBarInternal="horizontalBarInternalClass"
    >        

    <pdf-view 
    v-if="show" 
    ref="pdf" 
    :src="PDFs.file" 
    :page="page" @num-pages="numPages = $event" 
    @link-clicked="page = $event"></pdf-view>

  </v-bar>
              </client-only> 

        </div>
        </div>
    </div>
</template>
<script>

import { store, mutations } from "../../store/utils/conf";

export default {
    props: ['PDFs'],
    data() {
    return {
      currentPage: 0,
      pageCount: 0,
      show: true,
      pdfList: this.PDFs,
            src:'',
            page: 1,
            numPages: 0,
      
    }
  },
  methods: {
      closeTabModal() {
      mutations.togglePdfTabModal();
    },
  },
  computed: {
      isPdfTabModalOpen() {
          return store.isPdfTabModalOpen
      }
  }

}
</script>