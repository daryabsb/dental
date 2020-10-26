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
            <perfect-scrollbar>
<pdf-view
        class="pdf"
       
        :src="require('../../../media/upload_files/AXIS_-_Qirga_-_20-20_pzbG9eX.pdf')"
        

        :page="1"
      />

 </perfect-scrollbar>
          </div>
         
        </div>
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</template>

<script>
import { PerfectScrollbar } from 'vue2-perfect-scrollbar';

import { store, mutations } from "../../store/utils/conf";

export default {
  props: ["url", "page"],
  components: {
    PerfectScrollbar
    },
  data() {
    return {
      title: "",
      description: "",
    };
  },
  methods: {
    closeModal() {
      //console.log(this.name)
      // this.$emit('toggle-show');
      // store.isPdfOpen = false;
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
<style lang="css" scoped>

.pdf {
  border: 1px solid red;
  width: 1000px;
  /* height: 100%; */
}
</style>