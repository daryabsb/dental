<template>
  <div>
    <VueGallery :images="images" :index="index" @close="index = null" />
    <div
      class="image"
      v-for="(image, imageIndex) in images"
      :key="imageIndex"
      @click="index = 1"
      :style="{ backgroundImage: 'url(' + image + ')', width: '300px', height: '200px' }"
    ></div>
  </div>
</template>

<script>
  // import VueGallery from 'vue-gallery';
  
  export default {
    props: ['images', 'index'],
    data: function () {
      return {
        
      };
    },

    components: {
      // 'gallery': VueGallery
    },
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
