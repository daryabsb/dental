<template>
  <div class="tab-container" v-if="isPdfTabOpen">
    <v-bar
      wrapper="wrapper"
      vBar="verticalBarClass"
      vBarInternal="verticalBarInternalClass"
      hBar="horizontalBarClass"
      hBarInternal="horizontalBarInternalClass"
    >
      <div v-for="file in files" :key="file.id" class="file-box">
        <div class="card profile-card">
          <div class="card-body p-0">
            <div class="media p-3 align-items-center file-box-content">
              <pdf-view :src="file.file" class="file-box" />

              <div class="media-body ml-3 align-self-center">
                <h5 class="pro-title">{{ file.filename }}</h5>
                <p class="mb-2 text-muted">@SaraHopkins.com</p>
                <ul class="list-inline list-unstyled profile-socials mb-0">
                  <li class="list-inline-item">
                    <a href="#" class=""
                      ><i class="fab fa-facebook-f bg-soft-primary"></i
                    ></a>
                  </li>
                  <li class="list-inline-item">
                    <a href="#" class=""
                      ><i class="fab fa-twitter bg-soft-secondary"></i
                    ></a>
                  </li>
                  <li class="list-inline-item">
                    <a href="#" class=""
                      ><i class="fab fa-dribbble bg-soft-pink"></i
                    ></a>
                  </li>
                </ul>
              </div>
              <div class="action-btn">
                <button class="mr-1 btn btn-sm btn-soft-info">
                  <i class="fas fa-pen"></i>
                </button>
                <button class="btn btn-sm btn-soft-danger">
                  <i class="far fa-trash-alt"></i>
                </button>
              </div>
            </div>
          </div>
          <!--end card-body-->
        </div>
      </div>
    </v-bar>
  </div>
</template>

<script>
import { store, mutations } from "../../store/utils/conf";

export default {
  props: ["files", "page"],
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
      nextDisabled: false;
      if (this.currentPage > 1) {
        prevDisabled: false;
        this.currentPage--;
        this.p = this.currentPage;
      } else {
        this.prevDisabled = true;
      }
    },
    goNextPage() {
      prevDisabled: false;
      if (this.currentPage < this.pageCount) {
        nextDisabled: false;
        this.currentPage++;
        this.p = this.currentPage;
      } else {
        this.nextDisabled = true;
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
<style scoped>
.wrapper {
  height: 40rem;
  /* width: 100%; */
}
</style>
