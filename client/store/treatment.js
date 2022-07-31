import Vue from "vue";

export const store = Vue.observable({
    files: []
});

// We call toggleNav anywhere we need it in our app
export const mutations = {
    pushNewFiles(payload) {
        store.files.push(payload)
    }
};

export const actions = {



};