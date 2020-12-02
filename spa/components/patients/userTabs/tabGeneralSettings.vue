<template>
<b-row>
    <b-col lg="12">
  <vue-cal-local :user="user"></vue-cal-local>
  </b-col>
</b-row>
</template>

<script>
import VueCalLocal from '../../VueCalLocal.vue'
export default {
  components: { VueCalLocal },
    props: ['settings', 'user']
}
</script>