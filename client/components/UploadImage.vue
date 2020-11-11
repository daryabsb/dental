<template>
    
<div>
	<!-- <a class="btn" @click="toggleShow">set avatar</a> -->
	<my-upload field="img"
        @crop-success="cropSuccess"
        @crop-upload-success="cropUploadSuccess"
        @crop-upload-fail="cropUploadFail"
        v-model="show"
        langType="en"
		:width="300"
		:height="300"
		:url="`http://127.0.0.1:8000/api/patients/${id}/image/`"
		
		
		img-format="png"></my-upload>
	<img :src="imgDataUrl">
    <!-- :params="params" -->
</div>
</template>

<script>
export default {
    props: ['id', 'show'],
    data() {
            return {
                
			// show: false,
			// params: {
			// 	token: '123456798',
			// 	name: 'avatar'
			// },
			headers: {
				smail: '*_~'
			},
            imgDataUrl: '' // the datebase64 url of created image
            
            
            }
		},
		// components: {
		// 	'my-upload': myUpload
		// },
		methods: {
			toggleShow() {
				this.show = !this.show;
			},
            /**
			 * crop success
			 *
			 * [param] imgDataUrl
			 * [param] field
			 */
			cropSuccess(imgDataUrl, field){
				console.log('-------- crop success --------');
				this.imgDataUrl = imgDataUrl;
			},
			/**
			 * upload success
			 *
			 * [param] jsonData  server api return data, already json encode
			 * [param] field
			 */
			cropUploadSuccess(jsonData, field){
				console.log('-------- upload success --------');
				console.log(jsonData);
				console.log('field: ' + field);
			},
			/**
			 * upload fail
			 *
			 * [param] status    server api return error status, like 500
			 * [param] field
			 */
			cropUploadFail(status, field){
				console.log('-------- upload fail --------');
				console.log(status);
				console.log('field: ' + field);
			}
		}    


}
</script>




