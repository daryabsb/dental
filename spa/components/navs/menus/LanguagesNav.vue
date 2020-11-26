<template>
    <div 
    @click="closeLanguages" 
    class="dropdown-menu dropdown-menu-right" 
    v-if="isLanguagesOpen">
                            <a class="dropdown-item" href="javascript: void(0);"><span> German </span><img src="~assets/images/flags/germany_flag.jpg" alt="" class="ml-2 float-right" height="14"/></a>
                            <a class="dropdown-item" href="javascript: void(0);"><span> Italian </span><img src="~assets/images/flags/italy_flag.jpg" alt="" class="ml-2 float-right" height="14"/></a>
                            <a class="dropdown-item" href="javascript: void(0);"><span> French </span><img src="~assets/images/flags/french_flag.jpg" alt="" class="ml-2 float-right" height="14"/></a>
                            <a class="dropdown-item" href="javascript: void(0);"><span> Spanish </span><img src="~assets/images/flags/spain_flag.jpg" alt="" class="ml-2 float-right" height="14"/></a>
                            <a class="dropdown-item" href="javascript: void(0);"><span> Russian </span><img src="~assets/images/flags/russia_flag.jpg" alt="" class="ml-2 float-right" height="14"/></a>
                        </div>
    
</template>

<script>
import { store, mutations } from '../../../store/utils/conf'
export default {
    
    methods: {
    closeLanguages() {
      // CLOSE MENU
      mutations.toggleLanguages();
      // this.$emit('toggle-show');
    }
    },
    computed: {
        isLanguagesOpen() {
            return store.isLanguagesOpen
        }
    }
}
</script>