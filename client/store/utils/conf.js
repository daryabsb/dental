import Vue from "vue";

export const store = Vue.observable({
    isEditModal: false,
    isUserNavOpen: false,
    isNotificationOpen: false,
    isAddPatientModalOpen: false,
    isLanguagesOpen: false,
    isConfirmDeleteOpen: false
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
    toggleConfirmDelete() {
        store.isConfirmDeleteOpen = !store.isConfirmDeleteOpen
    },
};