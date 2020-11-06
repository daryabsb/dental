<template>
    <div class="my-modal" v-show="isPdfTabModalOpen">
        <!-- <button type="button" @click="alertIt()" class="close text-white m-4">×</button> -->
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="card">
                    <div class="card-body">
                    <v-bar
                        wrapper="wrapper"
                        vBar="verticalBarClass"
                        vBarInternal="verticalBarInternalClass"
                        hBar="horizontalBarClass"
                        hBarInternal="horizontalBarInternalClass"
                    >
                        <div v-for="i in pageCount" :key="i" >
                            <pdf-view :src="src" :page="i"></pdf-view>
                        </div> 
                    </v-bar>
                    </div>
                </div>  
            </div>
        </div>       
    </div>
</template>
<script>

import { store, mutations } from "../../store/utils/conf";

export default {
    props: ['pdf'],
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