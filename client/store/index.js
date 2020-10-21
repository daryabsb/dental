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
    },
    "DELETE_PATIENT" (state, id) {
        let patient = state.patients.find(patient => patient.id === id);
        let indexOfPatient = state.patients.indexOf(patient)
        console.log(patient, indexOfPatient);

        ;
        state.patients.splice(indexOfPatient, 1);
    }
};


const actions = {
    async nuxtServerInit({ state, commit }, { app }) {

        //state.csrftoken = app.$cookiz.get('csrftoken');
        //console.log('OnLoad:', state.csrftoken);

        const options = {
            headers: {
                "Content-Type": "multipart/form-data"
                    //"X-CSRFToken": state.csrftoken
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
    async addPatient({ state, commit }, payload) {
        //const csrftoken = app.$cookiz.get('csrftoken');
        console.log(payload)
            // csrftoken = this.$cookie.get('csrftoken');
            //console.log('csrf', state.csrftoken);
        const options = {
            headers: {
                "Content-Type": "multipart/form-data"
                    // "X-CSRFToken": state.csrftoken
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

    },
    async editPatient(state, payload) {

        console.log(payload);
        const id = payload[1];
        const patient = payload[0];



        const options = {
            headers: {
                "Content-Type": "multipart/form-data"
                    // "X-CSRFToken": state.csrftoken
            }
        };
        let url = `http://127.0.0.1:8000/api/patients/${id}/`;
        // console.log(url);

        try {

            const newPatient = await this.$axios.put(url, patient, options);
            console.log(newPatient.data)
                //commit("EDIT_PATIENT", newPatient.data);
                //   console.log(allPatients.data)


        } catch (err) {
            console.log(err);
        }

    },
    async onDeletePatient({ state, commit }, id) {

        try {

            await this.$axios.delete(`http://127.0.0.1:8000/api/patients/${id}/`);
            commit("DELETE_PATIENT", id);

        } catch (error) {
            console.log(error)
        }

    }

}

const getters = {
    patients(state) {
        return state.patients
    },
    isAuthenticated(state) {
        return state.auth.loggedIn
    },

    loggedInUser(state) {
        return state.auth.user
    }

}

export default {
    state,
    mutations,
    actions,
    getters
};