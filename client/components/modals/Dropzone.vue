<template>
	<div class="col-lg-12 mb-1">
		<div class="form-group">
			<label for="exampleInputPassword1">Attach</label>
			<div class="input-group mb-3">
				<div class="custom-file">
					<input
						type="file"
						class="custom-file-input"
						id="inputGroupFile04"
						@change="onFileSelected"
					/>
					<label class="custom-file-label" for="inputGroupFile04">{{
						fileName
					}}</label>
				</div>
				<div class="input-group-append">
					<button
						@click="uploadFile"
						class="btn btn-outline-light"
						type="button"
					>
						Upload
					</button>
				</div>
			</div>
			<div class="form-group">
				<div
					class="alert icon-custom-alert alert-light fade show"
					role="alert"
					v-for="file in files"
					:key="file.id"
				>
					<div class="alert-text">
						<strong>{{ file.filename }}</strong>
					</div>

					<div class="alert-close">
						<button
							type="button"
							class="close"
							@click="deleteAttached(file.id)"
						>
							<span aria-hidden="true"
								><i class="mdi mdi-close text-info"></i
							></span>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
import { store, mutations, actions } from "../../store/treatment";
let uuid = require("uuid");
export default {
	//props: ['id']
	data() {
		return {
			selectedFile: null,
			fileId: "",
			fileName: "",
		};
	},

	methods: {
		async uploadFile() {
			let formData = new FormData();
			formData.append("filename", this.fileName);
			formData.append("file", this.selectedFile, this.fileName);

			this.$store.dispatch("onUploadFile", formData);

			this.fileName = "";
			this.selectedFile = null;
		},
		onFileSelected(event) {
			this.selectedFile = event.target.files[0];
			//   console.log(this.selectedFile);
			this.fileName = event.target.files[0].name;
			//   console.log(this.fileName);
		},
		
        deleteAttached(id) {
        this.$store.dispatch('deleteAttached', id);
        }
	},
	computed: {
		files() {
			return this.$store.state.files;
		},
	},
};
</script>

<style scoped>
</style>
