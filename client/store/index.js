// import axios from '@nuxtjs/axios';
// import conf from './conf';
const state = () => ({
    users: [],
    patients: [],
    patient: [],
    treatments: [],
    appointments: [],
    attachments: [],
    curTreats: [],
    patientPdfFiles: [],
    hasPDF: false,
    hasIMAGES: false,
    patientImageFiles: [],
    files: [],
    csrftoken: "",
    progress: 0,
    isImageUploadOpen: false,
    patientHasImage: false,
    pid: 0,
    /* 
    TEMPORARILY HOLDS 
    CURRENT PATIENT's IMAGE*/
    pimage: '',

});

// const modules = {
//     conf
// }

const mutations = {
    GET_PATIENTS(state, payload) {
        state.patients = payload;
    },
    SET_PATIENT_DATA(state, payload) {

        // console.log(payload[2]);
        state.patientPdfFiles = [];
        state.hasPDF = false;
        state.hasIMAGES = false;
        state.patientImageFiles = [];

        state.patient = payload[0];

        if (payload[0].image != '') {
            state.patientHasImage = true;

        }

        if (payload[1].length != 0) {
            state.hasPDF = true;
        }
        if (payload[2].length != 0) {
            state.hasIMAGES = true;
            // state.patientImageFiles = payload[2];

        }
        // // let list = []
        // this.patientImageFiles.forEach(pdf => console.log(pdf) /*list.push(pdf)*/ );



        // console.log(state.patient);
    },
    'SET_PATIENT_PDFS' (state, payload) {
        state.patientPdfFiles = payload;
    },
    GET_USERS(state, payload) {
        // console.log(payload)
        state.users = payload;
    },
    GET_TREATMENTS(state, payload) {
        payload.forEach(treat => {
            let patient = state.patients.find(p => p.id === treat.patient);
            treat.patientName = patient.name;
        });
        state.treatments = payload;
    },

    GET_ATTACHMENTS(state, payload) {
        payload.forEach(att => {
            let patient = state.patients.find(p => p.id === att.patient);
            att.patientName = patient.name;
        });
        state.attachments = payload;
    },
    GET_APPOINTMENTS(state, payload) {
        payload.forEach(appointment => {
            let patient = state.patients.find(p => p.id === appointment.patient);
            state.treatments.forEach(t => {
                if (t.patient === appointment.patient) {
                    t.appointment = `${appointment.description} - ${this.$moment(appointment.date).format('DD/MM/yyyy')}`
                };
            });
            appointment.patientName = patient.name;
        });
        let today = new Date();

        today.setHours(0, 0, 0, 0);

        state.appointments = payload.filter(appointment => {

            return Date.parse(appointment.date) >= Date.parse(today);
        });

        // console.log(state.appointments);
    },
    GET_PATIENT_TREATMENTS(state, id) {
        // console.log(state.treatments)
        state.curTreats = state.treatments.filter(treat => treat.patient === id);
    },
    // 'GET_PATIENT_TREATS' (state, payload) {
    //     const curPatient = state.patients
    //         .filter(patient => patient.id === payload.id)
    //     state.curTreats = curPatient.treatments
    //     console.log(state.curTreats)
    // },
    ADD_USER(state, payload) {
        state.users.unshift(payload);
    },
    ADD_PATIENT(state, payload) {
        state.patients.unshift(payload);
        console.log('From Payload: ', payload);
        console.log('From state: ', state.patients);
    },
    ADD_NEW_APPOINTMENT(state, payload) {
        let patient = state.patients.find(p => p.id === payload.patient);
        let today = new Date();
        payload.patientName = patient.name;
        if (Date.parse(payload.date) >= Date.parse(today)) {
            state.appointments.unshift(payload);
        }

    },
    EDIT_USER(state, payload) {
        // FIND ITEM AND PLACE IN STATE
        const editedUser = state.users.find(user => user.id === payload.id);
        let indexOfUser = state.users.indexOf(editedUser);

        // REPLACE EDITED ITEM WITH NEW INFO
        state.users.splice(indexOfUser, 1, payload);
    },
    EDIT_PATIENT(state, payload) {
        // FIND ITEM AND PLACE IN STATE
        const editedPatient = state.patients.find(
            patient => patient.id === payload.id
        );
        let indexOfPatient = state.patients.indexOf(editedPatient);

        // REPLACE EDITED ITEM WITH NEW INFO
        state.patients.splice(indexOfPatient, 1, payload);
    },
    DELETE_ITEM(state, payload) {
        let item = payload.module.find(item => item.id === payload.id);
        let indexOfModule = payload.module.indexOf(item);
        // console.log(patient, indexOfPatient);

        payload.module.splice(indexOfModule, 1);
    },
    DELETE_PATIENT(state, id) {
        let patient = state.patients.find(patient => patient.id === id);
        let indexOfPatient = state.patients.indexOf(patient);
        // console.log(patient, indexOfPatient);

        state.patients.splice(indexOfPatient, 1);
    },
    PUSH_NEW_FILES(state, payload) {
        state.files.push(payload);
    },
    REMOVE_ATTACHED_FILE(state, id) {
        let fileToFind = state.files.find(file => file.id === id);
        let indexOfFile = state.files.indexOf(fileToFind);
        state.files.splice(indexOfFile, 1);
    },

    /* CHECK THE CODE BELOW*/
    ADD_NEW_TREATMENT(state, payload) {
        state.treatments.unshift(payload);
        state.treatments[0].files = [];
        state.treatments[0].files = state.files;
        state.files = [];
        // console.log(payload)
    },
    PATIENT_PDF_FILES(state, payload) {
        state.patientPdfFiles = payload;
    },
    PATIENT_IMAGE_FILES(state, payload) {
        state.patientImageFiles = payload;
    },
    'SET_PATIENT_ID' (state, payload) {
        state.pid = payload;
    },
    'SET_PIMAGE' (state, image) {
        state.pimage = image;
    },
    PUSH_IMAGE(state, payload) {

        // console.log(payload);
        let patient = state.patients.find(p => p.id === payload.id)
        state.pimage = payload.image;
        // let indexOfPatient = state.patients.indexOf(patient)
        // console.log(state.patient[indexOfPatient])
        // state.patients.splice(indexOfPatient, 1, patient)
    },
    updateUploadProgress(state, payload) {
        state.progress = payload;
    },
    toggleImageUploadOpen(state) {
        state.isImageUploadOpen = !state.isImageUploadOpen
    },
};



const actions = {

    // async nuxtServerInit({ state, commit }, { req }) {

    //     console.log('Wait a second')
    // },



    async loadData({ state, commit }) {
        //state.csrftoken = app.$cookiz.get('csrftoken');
        // console.log('OnLoad: this will run regardless of login with 0, ', payload);

        let patientUrl = "/patients/";
        let treatmentUrl = "/treatments/";
        let usersUrl = "/users/";
        let appointmentUrl = "/appointments/";
        let attachmentsUrl = "/attachments/";
        // console.log(url);

        try {
            const allPatients = await this.$axios.get(patientUrl);
            const allTreatments = await this.$axios.get(treatmentUrl);
            const allUsers = await this.$axios.get(usersUrl);
            const allAppointments = await this.$axios.get(appointmentUrl);
            const allAttachments = await this.$axios.get(attachmentsUrl);

            commit("GET_PATIENTS", allPatients.data);
            commit("GET_USERS", allUsers.data);
            commit("GET_TREATMENTS", allTreatments.data);
            commit("GET_APPOINTMENTS", allAppointments.data);
            commit("GET_ATTACHMENTS", allAttachments.data);
            //   console.log(allPatients.data)

        } catch (err) {
            console.log(err);
        }
    },
    async loadPatientData({ state, commit }, id) {

        console.log('Function is loaded and the ID is: ', id);
        commit('SET_PATIENT_ID', id)
        let patientsURL = '/patients'
        let attachmentsURL = '/attachments'


        try {
            let singlePatient = await this.$axios.$get(`${patientsURL}/${id}/`);
            let singlePatientPdfs = await this.$axios.$get(`${attachmentsURL}/?p=${id}&type=pdf`);
            let singlePatientImages = await this.$axios.$get(`${attachmentsURL}/?p=${id}&type=image`);

            // let thisPatient = {}
            let thisPatient = []

            thisPatient = await Promise.all([singlePatient, singlePatientPdfs, singlePatientImages]);
            // console.log(thisPatient)
            commit('SET_PATIENT_DATA', thisPatient);


        } catch (err) {
            console.log(err);
        }




    },
    async loadPatientPdfs({ state, commit }) {

        let id = state.pid;
        let attachmentsURL = '/attachments'


        try {

            let singlePatientPdfs = await this.$axios.$get(`${attachmentsURL}/?p=${id}&type=pdf`);

            commit('SET_PATIENT_PDFS', singlePatientPdfs.data);


        } catch (err) {
            console.log(err);
        }




    },
    async addUser({ state, commit }, payload) {
        // console.log('Payload: ', payload)
        const options = {
            headers: {
                "Content-Type": "multipart/form-data"
                    // "X-CSRFToken": state.csrftoken
            }
        };
        let url = "/user/create/";
        // console.log(url);

        try {
            const newUser = await this.$axios.post(url, payload, options);
            // console.log(allPatients.data)
            commit("ADD_USER", newUser.data);
            console.log("Created: ", newUser.data);
        } catch (err) {
            console.log(err);
        }
    },
    async editUser({ state, commit }, payload) {
        const id = payload.id;

        // console.log(payload.id)

        let url = `/users/${id}/`;
        // console.log(url);

        try {
            const newUser = await this.$axios.put(url, payload);
            //console.log("Updated Response: ", newPatient.data)

            commit("EDIT_USER", newUser.data);
            //   console.log(allPatients.data)
        } catch (err) {
            console.log(err);
        }
    },
    async addPatient({ state, commit }, payload) {
        // const options = {
        //   headers: {
        //     "Content-Type": "multipart/form-data"
        //   }
        // };
        let url = "/patients/";

        try {
            const newPatient = await this.$axios.post(url, payload);
            commit("ADD_PATIENT", newPatient.data);
        } catch (err) {
            console.log(err);
        }
    },
    async editPatient({ state, commit }, payload) {
        const id = payload.id;

        let url = `/patients/${id}/`;
        // console.log(url);

        try {
            const newPatient = await this.$axios.put(url, payload);

            commit("EDIT_PATIENT", newPatient.data);
        } catch (err) {
            console.log(err);
        }
    },
    async onDelete({ state, commit }, payload) {
        // console.log('moduleName: ', payload.moduleName)
        // console.log('module: ', payload.module)
        // console.log('id: ', payload.id)

        try {
            await this.$axios.delete(
                `/${payload.moduleName}/${payload.id}/`
            );
            commit("DELETE_ITEM", payload);
        } catch (error) {
            console.log(error);
        }
    },
    async onDeleteUser({ state, commit }, id) {
        try {
            await this.$axios.delete(`/patients/${id}/`);
            commit("DELETE_PATIENT", id);
        } catch (error) {
            console.log(error);
        }
    },

    async onDeletePatient({ state, commit }, id) {
        try {
            await this.$axios.delete(`/patients/${id}/`);
            commit("DELETE_PATIENT", id);
        } catch (error) {
            console.log(error);
        }
    },
    async onUploadFile({ state, commit }, payload) {
        try {
            let url = "/attachments/";

            let res = await this.$axios.post(url, payload);
            // console.log(res.data)
            commit("PUSH_NEW_FILES", res.data);
        } catch (error) {
            console.log(error);
        }
    },
    async deleteAttached({ state, commit }, id) {
        let url = `/attachments/${id}/`;
        // console.log(url);
        try {
            await this.$axios.delete(url);

            commit("REMOVE_ATTACHED_FILE", id);
        } catch (error) {
            console.log(error);
        }
    },
    async addNewTreatment({ state, commit }, payload) {
        let url = "/treatments/";

        try {
            // console.log(Array.from(payload));
            const newTreatment = await this.$axios.post(url, payload);
            commit("ADD_NEW_TREATMENT", newTreatment.data);
        } catch (err) {
            console.log(err);
        }
    },
    async addAppointment({ state, commit }, payload) {

        let url = "/appointments/";

        try {
            // console.log(Array.from(payload));
            const newTreatment = await this.$axios.post(url, payload);
            commit("ADD_NEW_APPOINTMENT", newTreatment.data);
        } catch (err) {
            console.log(err);
        }

    },
    async uploadImage({ state, commit }, payload) {
        // console.log(payload)
        let id = payload.id;
        let frmData = payload.frmData;
        let url = payload.url;

        const imageResponse = await this.$axios.put(url, frmData);

        // console.log(imageResponse.data)

        commit('PUSH_IMAGE', imageResponse.data)
    },
    async onFilter({ state, commit }, payload) {

        let url = payload.url;
        let query = '';



        if (payload.date.dq === 'none') {

            query = `?input=${payload.searchInput}`;

        } else if (payload.date.dq === 'custom' && payload.date.date != '') {

            query = `?input=${payload.searchInput}&dq=${payload.date.dq}&date=${payload.date.date}`;

        } else if (payload.date.dq != '' || payload.date.dq != 'custom') {

            query = `?input=${payload.searchInput}&dq=${payload.date.dq}`

        } else {

            return

        }

        let filterUrl = `${url}${query}`

        // console.log(filterUrl)

        try {
            // console.log(Array.from(payload));
            const filterData = await this.$axios.get(filterUrl);
            commit(`GET_${payload.module}`, filterData.data);
        } catch (err) {
            console.log(err);
        }

    },
    async filterAppointments({ state, commit }, payload) {

        let url = "/appointments/";
        let query = '';

        if (payload.dq === 'none') {
            query = '';
        } else if (payload.dq === 'custom' && payload.date != '') {
            query = `?dq=${payload.dq}&date=${payload.date}`
        } else if (!payload.dq != '' || payload.dq != 'custom') {
            query = `?dq=${payload.dq}`
        } else {
            return
        }

        let filterUrl = `${url}${query}`

        try {
            // console.log(Array.from(payload));
            const allAppointments = await this.$axios.get(filterUrl);
            commit("GET_APPOINTMENTS", allAppointments.data);
        } catch (err) {
            console.log(err);
        }

    },
    getPatientTreats({ state, commit }, id) {
        commit("GET_PATIENT_TREATMENTS", id);
    },
    toggleImageUploadOpen({ commit }) {
        commit('toggleImageUploadOpen');
    },
    setPimage({ commit }, image) {
        commit('SET_PIMAGE', image);
    },
};

const getters = {
    patients(state) {
        return state.patients;
    },
    isAuthenticated(state) {
        return state.auth.loggedIn;
    },

    loggedInUser(state) {
        return state.auth.user;
    },
    getTreatments(state) {
        return state.treatments;
    },
    // GET PATIENT RELATED DATA
    getPatient(state) {
        return state.patient;
    },
    getPatientPDFs(state) {
        return state.patientPdfFiles;
    },
    getPatientImages(state) {
        return state.patientImageFiles;
    },
    getAppointments(state) {
        return state.appointments;
    },
    hasPDF(state) {
        return state.hasPDF;
    },
    hasIMAGES(state) {
        return state.hasIMAGES;
    },
    progress(state) {
        return state.progress;
    },
    show(state) {
        return state.isImageUploadOpen;
    },
    patientHasImage(state) {
        return state.patientHasImage
    },
    pimage(state) {
        return state.pimage;
    },
    pid(state) {
        return state.pid;
    },
};

export default {
    state,
    mutations,
    actions,
    getters
};