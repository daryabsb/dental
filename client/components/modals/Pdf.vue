<template>
  <pdf :src="link" v-if="isPdfOpen"></pdf>
</template>
 
<script>
import pdf from 'vue-pdf'
import { store, mutations } from "../../store/utils/conf"
 
export default {
    props: ['link'],
    data(){
      return {
          
      } 
    },
  components: {
    pdf
  },
  computed: {
    isPdfOpen () {
       
        return store.isPdfOpen
    }
    }

}
</script>