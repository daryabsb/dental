<template>
    <div class="my-modal" v-show="isPdfTabModalOpen">
        <!-- <button type="button" @click="alertIt()" class="close text-white m-4">×</button> -->
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="card">
                    <div class="card-body ps">
                        <client-only>
                   <perfect-scrollbar>
                            <pdf-view
                            
                            v-for="i in pageCount" 
                            :key="i"
                            :src="src" 
                            :page="i"
                             />
                   </perfect-scrollbar>
                    </client-only>
                    </div>
                </div>  
            </div>
        </div>       
    </div>
</template>
<script>
import { PerfectScrollbar } from 'vue2-perfect-scrollbar';
import { store, mutations } from "../../store/utils/conf";

export default {
    props: ['pdf'],
    components: {
        PerfectScrollbar
    },
    methods: {
    alertIt() {},
  },
  computed: {
      isPdfTabModalOpen() {
          return store.isPdfTabModalOpen
      },
      src() {
        return this.pdf.file
      },
      pageCount(){
          console.log(this.pdf.page_count)
        return this.pdf.page_count
      },
  },
}
</script>
<style scoped>
.ps {
  height: 90vh;
}
</style>
