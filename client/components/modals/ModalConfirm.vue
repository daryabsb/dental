<template>
  <div class="modal fade bs-example-modal-center show" style="display: block;" v-if="isConfirmDeleteOpen">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 id="exampleModalLabel" class="modal-title mt-0">{{ title }}</h5>
          <button
            type="button"
           @click="close"
            class="close"
          >
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="toast-body">
            Are you sure you want to delete {{ name }}?
          </div>
          <button class="btn btn-danger btn-small">
            <a @click="deletePatient(id)">Confirm</a>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import { store, mutations } from '../../store/utils/conf'
export default {
  props: ["title", "module", "moduleName", "name", "id"],
  methods: {
    deletePatient(id) {
      let payload = {
        id: id,
        module: this.module,
        moduleName: this.moduleName
      }
      this.$store.dispatch("onDelete", payload);
      mutations.toggleConfirmDelete();
    },
    close() {
        mutations.toggleConfirmDelete();
    }
  },
  computed: {
    isConfirmDeleteOpen() {
        return store.isConfirmDeleteOpen
    }
    }
};
</script>
