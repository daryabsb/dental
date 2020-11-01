<template>
  <div class="my-modal" v-if="isPdfOpen">
    <div class="modal-dialog modal-xl">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title mt-0" id="myModalLabel">Modal Heading</h5>
          <button @click="closeModal" type="button" class="close">×</button>
        </div>
        <div class="modal-body">
          <div class="row">
           <button @click="goPrevPage" type="button" class="close"><i class="fas fa-arrow-left"></i></button>
         <p>{{currentPage}} / {{pageCount}}</p>
         <button @click="goNextPage" type="button" class="close"><i class="fas fa-arrow-right"></i></button>
          </div>
   <v-bar
      wrapper="wrapper"
      vBar="verticalBarClass"
      vBarInternal="verticalBarInternalClass"
      hBar="horizontalBarClass"
      hBarInternal="horizontalBarInternalClass"
    > 
 
        
          <div class="row pdf-container"> 
    <!-- :src="require('../../../media/upload_files/AXIS_-_Qirga_-_20-20_pzbG9eX.pdf')" -->
  <!-- <canvas width="200" height="500"> -->
 <pdf-view 
  class="pdf" 
  :src="url" 
  :page="p"
    @num-pages="pageCount = $event"
    @page-loaded="currentPage = $event"
  />
  <!-- </canvas> -->
 
 </div>
</v-bar>   
         
        </div>
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</template>

<script>
import { store, mutations } from "../../store/utils/conf";

export default {
  props: ["url", "page"],
  data() {
    return {
      currentPage: 0,
      pageCount: 0,
      p:1
    }
  },
  methods: {
    goPrevPage() {
      if(this.currentPage>1) {
        this.currentPage-=1
        this.p=this.currentPage 
      }
      
    },
    goNextPage() {
      if(this.currentPage <this.pageCount) {
        this.currentPage+=1
        this.p=this.currentPage 
      }
    },
    closeModal() {
      mutations.togglePdfModal();
    },
  },
  computed: {
    isPdfOpen() {
      return store.isPdfOpen;
    },
  },
};
</script>
<style>

.pdf {
  /* border: 1px solid red; */
  width: 100%;
  min-height: 500px;
}
.wrapper {
  height: 45rem;
  /* width: 100%; */
    }
</style>