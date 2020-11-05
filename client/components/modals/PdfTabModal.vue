<template>
    <div class="my-modal" v-show="isPdfTabModalOpen">
    <!-- <button type="button" @click="alertIt()" class="close text-white m-4">×</button> -->
   
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <!-- {{pageCount}} -->
  <v-bar
      wrapper="wrapper"
      vBar="verticalBarClass"
      vBarInternal="verticalBarInternalClass"
      hBar="horizontalBarClass"
      hBarInternal="horizontalBarInternalClass"
    >        

<!-- <div v-for="i in pageCount" :key="i" >
                {{i}}
                
            </div> -->

<pdf-view
                
            ref="thisPdf" 
            :src="src" 
            @num-pages="pageCount = $event"
             ></pdf-view>

  

  </v-bar>
             

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
      // pageCount: 0,
      // pdfList: this.PDFs,
      // src:'',
      page: 1,
      isMounted: false
      
    }
  },
  methods: {
      closeTab() {
        // store.isPdfTabModalOpen = false;
      
      // 
    },
    alertIt() {
      
    // alert(this.numPages) 
  // store.isPdfTabModalOpen = false;
    },
     
  },
  computed: {
      isPdfTabModalOpen() {
          return store.isPdfTabModalOpen
      },
      src() {
        
        return this.PDFs.file
      },
      // pageCount(){
      //   let count = 0;
      //   this.$refs.thisPdf.pdf.forEachPage(page=> this.count+=page);
      //   return count;
      // },
  },
  mounted() {
    this.$refs.thisPdf.pdf.forEachPage(page=>console.log(page))
  },

}
</script>