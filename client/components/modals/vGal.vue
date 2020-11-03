<template>
  <div>
    <gallery :images="imageUrls" :index="index" @close="index = null" />
    <!-- <img v-for="(image, iIndex) in images" :src="image" :key="iIndex" alt="img"> -->
    <v-bar
      wrapper="wrapper"
      vBar="verticalBarClass"
      vBarInternal="verticalBarInternalClass"
      hBar="horizontalBarClass"
      hBarInternal="horizontalBarInternalClass"
    >
   <div
      class="file-box"
      v-for="(image, imageIndex) in images"
      :key="imageIndex - 1"
      @click="index = image.id"
    >

<div class="card profile-card">
          <div class="card-body p-0">
            <div class="media p-3 align-items-center file-box-content">
              <img :src="image.file" :alt="image.filename" class="file-box" >
              <div class="media-body ml-3 align-self-center">
                <h5 class="pro-title">{{ image.filename }}</h5>
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
     </v-bar>
  </div>
</template>

<script>
  // import VueGallery from 'vue-gallery';
  
  export default {
    props: ['images', 'index', 'patient'],
    data: function () {
      return {
        // images: [
        //   'https://dummyimage.com/800/ffffff/000000',
        //   'https://dummyimage.com/1600/ffffff/000000',
        //   'https://dummyimage.com/1280/000000/ffffff',
        //   'https://dummyimage.com/400/000000/ffffff',
        //   'http://127.0.0.1:8000/media/upload_files/Lox_CataloguePrint.pdf'
        // ],
        // index: null
      };
    },
    computed: {
      imageUrls() {
        return this.images.map(image=>image.file);
      }
    },
    

    // components: {
    //   'gallery': VueGallery
    // },
  }
</script> 

<style scoped>
  .image {
    float: left;
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center center;
    border: 1px solid #ebebeb;
    margin: 5px;
  }
.wrapper {
  height: 40rem;
  /* width: 100%; */
}
</style>
