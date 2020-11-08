import Vue from "vue";


export const store = Vue.observable({
    // OTHER STATES
    treatmentFiles: [],
    treatmentPdfFiles: [],
    treatmentImageFiles: [],
    // MODAL CONTROLLERS
    isEditModal: false,
    isUserNavOpen: false,
    isNotificationOpen: false,
    isAddPatientModalOpen: false,
    isLanguagesOpen: false,
    isConfirmDeleteOpen: false,
    isTreatmentOpen: false,
    isPdfOpen: false,
    isUserModalOpen: false,
    isAppointmentModalOpen: false,
    isPdfTabOpen: false,
    isPdfTabModalOpen: false,
    isImagesTabOpen: false,
    isPatientHistoryTabOpen: true,
    isSelectPatientModalOpen: false,
});

// We call toggleNav anywhere we need it in our app
export const mutations = {
    toggleUserNav() {
        store.isUserNavOpen = !store.isUserNavOpen
    },
    toggleNotification() {
        store.isNotificationOpen = !store.isNotificationOpen
    },
    toggleLanguages() {
        store.isLanguagesOpen = !store.isLanguagesOpen
    },
    toggleAddPatientModal() {
        store.isAddPatientModalOpen = !store.isAddPatientModalOpen
    },
    toggleTreatment() {
        store.isTreatmentOpen = !store.isTreatmentOpen
    },
    toggleConfirmDelete() {
        store.isConfirmDeleteOpen = !store.isConfirmDeleteOpen
    },
    togglePdfModal() {
        store.isPdfOpen = !store.isPdfOpen
    },
    toggleUserModal() {
        store.isUserModalOpen = !store.isUserModalOpen
    },
    toggleAppointmentModal() {
        store.isAppointmentModalOpen = !store.isAppointmentModalOpen
    },
    togglePdfTab(files = []) {
        store.treatmentFiles = files;
        store.isPdfTabOpen = !store.isPdfTabOpen
    },
    togglePdfTabModal() {
        store.isPdfTabModalOpen = !store.isPdfTabModalOpen
    },
    toggleImagesTab(files = []) {
        store.treatmentFiles = files;
        store.isImagesTabOpen = !store.isImagesTabOpen
    },
    togglePatientHistoryTab() {
        store.isPatientHistoryTabOpen = !store.isPatientHistoryTabOpen
    },
    toggleSelectPatientModal() {
        store.isSelectPatientModalOpen = !store.isSelectPatientModalOpen
    },

};