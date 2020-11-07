<template>
  <div class="tab-container" v-if="isPdfTabOpen">
    
    <!-- <vue-scroll :ops="ops" class="ps"> -->
      <perfect-scrollbar>
    
      <div v-for="file in files" :key="file.id" class="file-box">
        <div class="card profile-card" @click="showPdf(file)">
          <div class="card-body p-0">
            <div class="media p-3 align-items-center file-box-content">
              <pdf-view :src="file.file" class="file-box" />
              <pdf-tab-modal :pdf="src" />
              <div class="media-body ml-3 align-self-center">
                <h5 class="pro-title">{{ file.filename }}</h5>
                <p class="mb-2 text-muted">@{{patient}}</p>
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
    </perfect-scrollbar>
  </div>
</template>

<script>
import { PerfectScrollbar } from 'vue2-perfect-scrollbar';
import { store, mutations } from '../../store/utils/conf';
export default {
  props: ["files", "patient"],
  components: {
        PerfectScrollbar
    },
  data() {
    return {
      src:[],
      ops: {
        bar: {
          background: 'rgb(24, 144, 255)'
        },
        rail: {
          border: '1px solid #cecece',
          size: '20px'
        },
        scrollButton: {
          enable: true,
          background: '#cecece'
        }
      }
    };
  },
  methods: {
    showPdf(file) {
      this.src = file;
      mutations.togglePdfTabModal()
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
.ps {
  height: 42rem;
}
</style>