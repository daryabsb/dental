// import axios from '@nuxtjs/axios';
const state = () => ({
    patients: [],
    csrftoken: ''
});

const mutations = {
    'GET_PATIENTS' (state, payload) {
        state.patients = payload
    },
    'ADD_PATIENT' (state, payload) {
        state.patients.unshift(payload)
    }
};

/*
function getCookie(name) {
    var cookieValue = null;
    if (document.cookie && document.cookie != '') {
        var cookies = document.cookie.split(';');
        for (var i = 0; i < cookies.length; i++) {
            var cookie = jQuery.trim(cookies[i]);
            // Does this cookie string begin with the name we want?
            if (cookie.substring(0, name.length + 1) == (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}
var csrftoken = getCookie('csrftoken');
console.log(csrftoken)
*/


const actions = {
    async nuxtServerInit({ state, commit }, { app }) {

        state.csrftoken = app.$cookiz.get('csrftoken');
        console.log('OnLoad:', state.csrftoken);

        const options = {
            headers: {
                "Content-Type": "multipart/form-data",
                "X-CSRFToken": state.csrftoken
            }
        };
        let url = "http://127.0.0.1:8000/api/patients/";
        // console.log(url);

        try {

            const allPatients = await this.$axios.get(url, options);
            // console.log(allPatients.data)
            commit("GET_PATIENTS", allPatients.data);
            //   console.log(allPatients.data)


        } catch (err) {
            console.log(err);
        }

    },
    test({ state, commit }, app) {},
    async addPatient({ state, commit }, payload) {
        //const csrftoken = app.$cookiz.get('csrftoken');
        console.log(payload)
            // csrftoken = this.$cookie.get('csrftoken');
        console.log('csrf', state.csrftoken);
        const options = {
            headers: {
                "Content-Type": "multipart/form-data",
                "X-CSRFToken": state.csrftoken
            }
        };
        let url = "http://127.0.0.1:8000/api/patients/";
        // console.log(url);

        try {

            const newPatient = await this.$axios.post(url, payload, options);
            // console.log(allPatients.data)
            commit("ADD_PATIENT", newPatient.data);
            //   console.log(allPatients.data)


        } catch (err) {
            console.log(err);
        }

    }
    /*,
    addToCart({ commit }, payload){
        commit('ADD_TO_CART', payload)
    }*/
}

const getters = {
    patients(state) {
        return state.patients
    }

}

export default {
    state,
    mutations,
    actions,
    getters
};