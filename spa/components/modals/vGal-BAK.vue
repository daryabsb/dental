<template>
  <div>
    <gallery :images="images" :index="index" @close="index = null" />
    <!-- <img v-for="(image, iIndex) in images" :src="image" :key="iIndex" alt="img"> -->
    <div
      class="image"
      v-for="(image, imageIndex) in images"
      :key="imageIndex"
      @click="index = imageIndex"
      :style="{ backgroundImage: 'url(' + image.file + ')', width: '50px', height: '30px' }"
    ></div>
  </div>
</template>

<script>
  // import VueGallery from 'vue-gallery';
  
  export default {
    props: ['images', 'index'],
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
</style>
