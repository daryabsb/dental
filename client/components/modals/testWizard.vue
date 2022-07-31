<template>
<div>
  <client-only>
   <form-wizard @on-complete="onComplete" 
                      shape="tab"
                      color="#4d79f6">
            <tab-content title="Personal details"
                         icon="ti-user">
              My first tab content
            </tab-content>
            <tab-content title="Additional Info"
                         icon="ti-settings">
              My second tab content
            </tab-content>
            <tab-content title="Last step"
                         icon="ti-check">
              Yuhuuu! This seems pretty damn simple
            </tab-content>
        </form-wizard>
        </client-only>
    </div>
</template>
<script>
// import VueFormGenerator from 'vue-form-generator'
// import 'vue-form-generator/dist/vfg.css'

export default {
    props: ['patientID'],
    data(){
      return {
        
      }
   
 },
 methods: {
  onComplete: function(){
      alert('Yay. Done!');
   },
  }
}
</script>
<style>
pre {
	overflow: auto;
}
	pre .string { color: #885800; }
	pre .number { color: blue; }
	pre .boolean { color: magenta; }
	pre .null { color: red; }
	pre .key { color: green; }  
</style>