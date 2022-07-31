<template>
  <div class="col-lg-12 mb-1">
    <div class="form-group">
      <!-- <Dropit  
				module="$store.state.files"
				moduleName="'attachments'"
			/> -->
      <b-input-group label="Attach you PDFs here" class="mt-3">
        <b-form-file size="lg" :file-name-formatter="formatPdfNames" @change="onFileSelected('pdf')" accept="application/pdf"></b-form-file>
        <b-input-group-append>
          <b-button size="sm" variant="outline-success" @click="uploadFile">Upload</b-button>
        </b-input-group-append>
      </b-input-group>

      <b-input-group label="Attach you PDFs here" class="mt-3">
        <b-form-file size="lg" :file-name-formatter="formatImageNames" @change="onFileSelected('image')" accept=".jpg,.jpeg,.png,.bmp"></b-form-file>
        <b-input-group-append>
          <b-button size="sm" variant="outline-success" @click="uploadFile">Upload</b-button>
        </b-input-group-append>
      </b-input-group>
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
      pdfName: '',
      imageName: '',
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
      this.pdfName = '';
      this.imageName = '';
      this.selectedFile = null;
    },
    onFileSelected(fileType) {
      this.selectedFile = event.target.files[0];
      //   console.log(this.selectedFile);
      if (fileType === 'pdf') {
        this.pdfName = event.target.files[0].name;
      } else {
        this.imageName = event.target.files[0].name;
      }
      this.fileName = event.target.files[0].name;
      //   console.log(this.fileName);
      this.fileType = fileType;
    },

    deleteAttached(id) {
      this.$store.dispatch("deleteAttached", id);
    },
    formatPdfNames(files) {
        return files.length === 1 ? this.pdfName : "No file selected!";
      },
      formatImageNames(files) {
        return files.length === 1 ? this.imageName : "No file selected!";
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
