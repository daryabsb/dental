<template>
  <div class="col-lg-12 mb-1">
    <div class="form-group">
      <!-- <Dropit  
				module="$store.state.files"
				moduleName="'attachments'"
			/> -->
      <label for="exampleInputPassword1">Attach Your PDFs here</label>
      <div class="input-group mb-3">
        <div class="custom-file">
          <input
            type="file"
            accept="application/pdf"
            class="custom-file-input"
            id="inputGroupFile04"
            @change="onFileSelected('pdf')"
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
      <label for="exampleInputPassword1">Attach Your Pictures here</label>
      <div class="input-group mb-3">
        <div class="custom-file">
          <input
            type="file"
            accept=".jpg,.jpeg,.png,.bmp"
            class="custom-file-input"
            id="inputGroupFile04"
            @change="onFileSelected('image')"
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
  props: ["ID"],
  data() {
    return {
      selectedFile: null,
      fileId: "",
      fileName: "",
      fileType: "",
    };
  },

  methods: {
    async uploadFile() {
      // console.log(this.ID);

      let formData = new FormData();
      formData.append("patient", this.ID);
      formData.append("filename", this.fileName);
      formData.append("file_type", this.fileType);
      formData.append("file", this.selectedFile, this.fileName);

      this.$store.dispatch("onUploadFile", formData);

      this.fileName = "";
      this.selectedFile = null;
    },
    onFileSelected(fileType) {
      this.selectedFile = event.target.files[0];
      //   console.log(this.selectedFile);
      this.fileName = event.target.files[0].name;
      //   console.log(this.fileName);
      this.fileType = fileType;
    },

    deleteAttached(id) {
      this.$store.dispatch("deleteAttached", id);
    },
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
