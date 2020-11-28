<template>
    
<div>
	<!-- <a class="btn" @click="toggleShow">set avatar</a> -->
	<my-upload field="img"
        @crop-success="cropSuccess"
        @crop-upload-success="cropUploadSuccess"
        @crop-upload-fail="cropUploadFail"
        
        langType="en"
		:width="300"
		:height="300"
		:url="`/patients/${id}/image/`"
		
		img-format="png"></my-upload>
		<!-- v-model="show" -->
	<!-- <img :src="imgDataUrl"> -->
    <!-- :params="params" -->
</div>
</template>

<script>
import {store, mutations} from '../store/utils/conf';
import {mapGetters} from 'vuex'
export default {
    props: ['id'],
    data() {
            return {
                
			// show: false,
			// params: {
			// 	token: '123456798',
			// 	name: 'avatar'
			// },
			
            imgDataUrl: '' // the datebase64 url of created image
            
            
            }
		},
		// components: {
		// 	'my-upload': myUpload
		// },
		methods: {
			toggleShow() {
				this.$store.conf.dispatch('toggleImageUploadOpen')
			},
			cropSuccess(imgDataUrl, field){
				console.log('-------- crop success --------');
				this.imgDataUrl = imgDataUrl;
			},
			cropUploadSuccess(jsonData, field){
				console.log('-------- upload success --------');
				console.log(jsonData);
				console.log('field: ' + field);
			},
			cropUploadFail(status, field){
				console.log('-------- upload fail --------');
				console.log(status);
				console.log('field: ' + field);
			}
		},
		computed: {
			// show() {
			// 	return this.$store.state.isImageUploadOpen
			// }
			
		},  


}
</script>




