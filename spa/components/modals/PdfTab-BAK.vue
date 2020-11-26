<template>
<div class="tab-container"  v-if="isPdfTabOpen">
         <div
         v-for="url in urls"
          :key="url"
          style="display: inline-block; width: 25%">
            <ul class="pagination justify-content-center">
                                            <li class="page-item" :class="{disabled: prevDisabled}">
                                                <a class="page-link" @click="goPrevPage">Previous</a>
                                            </li>
                                            <li class="page-item"><span class="page-link">{{ currentPage }}</span></li>
                                            <li class="page-item"><span class="page-link">of</span>
                                            <li class="page-item"><span class="page-link">{{ pageCount }}</span></li>
                                            <li class="page-item" :class="{disabled: nextDisabled}">
                                                <a class="page-link" @click="goNextPage">Next</a>
                                            </li>
                                        </ul>
            <!-- <button @click="goPrevPage" type="button" class="close">
              <i class="fas fa-arrow-left"></i>
            </button>
            <p>{{ currentPage }} / {{ pageCount }}</p>
            <button @click="goNextPage" type="button" class="close">
              <i class="fas fa-arrow-right"></i>
            </button> -->
            <!-- <pre>{{urls}}</pre> -->
         
          <v-bar
            wrapper="wrapper"
            vBar="verticalBarClass"
            vBarInternal="verticalBarInternalClass"
            hBar="horizontalBarClass"
            hBarInternal="horizontalBarInternalClass"
          >
            <div class="row">
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
</template>

<script>
import { store, mutations } from "../../store/utils/conf";

export default {
  props: ["urls", "page"],
  data() {
    return {
      currentPage: 0,
      pageCount: 0,
      p: 1,
      prevDisabled: false,
      nextDisabled: false,
    
    };
  },
  methods: {
    goPrevPage() {
      nextDisabled: false
      if (this.currentPage > 1) {
        prevDisabled: false
        this.currentPage--;
        this.p = this.currentPage;
      } else {
        this.prevDisabled = true
      }
    },
    goNextPage() {
      prevDisabled: false
      if (this.currentPage < this.pageCount) {
        nextDisabled: false
        this.currentPage++;
        this.p = this.currentPage;
      } else {
        this.nextDisabled = true
      }
    },
    closeModal() {
      mutations.togglePdfModal();
    },
  },
  computed: {
    isPdfTabOpen() {
      return store.isPdfTabOpen;
    },
  },
};
</script>
<style>
.pdf {
  /* border: 1px solid red; */
  width: 100%;
  min-height: 50rem;
}
.wrapper {
  height: 70rem;
  /* width: 100%; */
}
</style>