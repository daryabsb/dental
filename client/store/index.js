// import axios from '@nuxtjs/axios';
const state = () => ({
  users: [],
  patients: [],
  treatments: [],
  appointments: [],
  curTreats: [],
  files: [],
  csrftoken: ""
});

const mutations = {
  GET_PATIENTS(state, payload) {
    state.patients = payload;
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
  GET_APPOINTMENTS(state, payload) {
    payload.forEach(appointment => {
      let patient = state.patients.find(p => p.id === appointment.patient);
      appointment.patientName = patient.name;
    });
    let today = new Date();

    state.appointments = payload.filter(appointment => {
      return Date.parse(appointment.date) >= Date.parse(today);
    });

    console.log(state.appointments);
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
  ADD_NEW_TREATMENT(state, payload) {
    state.treatments.unshift(payload);
    state.treatments[0].files = [];
    state.treatments[0].files = state.files;
    state.files = [];
    // console.log(payload)
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
    let treatmentUrl = "http://127.0.0.1:8000/api/treatments/";
    let usersUrl = "http://127.0.0.1:8000/api/users/";
    let appointmentUrl = "http://127.0.0.1:8000/api/appointments/";
    // console.log(url);

    try {
      const allPatients = await this.$axios.get(url);
      const allTreatments = await this.$axios.get(treatmentUrl);
      const allUsers = await this.$axios.get(usersUrl);
      const allAppointments = await this.$axios.get(appointmentUrl);

      commit("GET_PATIENTS", allPatients.data);
      commit("GET_USERS", allUsers.data);
      commit("GET_TREATMENTS", allTreatments.data);
      commit("GET_APPOINTMENTS", allAppointments.data);
      //   console.log(allPatients.data)
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
    let url = "http://127.0.0.1:8000/api/user/create/";
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

    let url = `http://127.0.0.1:8000/api/users/${id}/`;
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
    let url = "http://127.0.0.1:8000/api/patients/";

    try {
      const newPatient = await this.$axios.post(url, payload);
      commit("ADD_PATIENT", newPatient.data);
    } catch (err) {
      console.log(err);
    }
  },
  async editPatient({ state, commit }, payload) {
    const id = payload.id;

    let url = `http://127.0.0.1:8000/api/patients/${id}/`;
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
        `http://127.0.0.1:8000/api/${payload.moduleName}/${payload.id}/`
      );
      commit("DELETE_ITEM", payload);
    } catch (error) {
      console.log(error);
    }
  },
  async onDeleteUser({ state, commit }, id) {
    try {
      await this.$axios.delete(`http://127.0.0.1:8000/api/patients/${id}/`);
      commit("DELETE_PATIENT", id);
    } catch (error) {
      console.log(error);
    }
  },

  async onDeletePatient({ state, commit }, id) {
    try {
      await this.$axios.delete(`http://127.0.0.1:8000/api/patients/${id}/`);
      commit("DELETE_PATIENT", id);
    } catch (error) {
      console.log(error);
    }
  },
  async onUploadFile({ state, commit }, payload) {
    try {
      let url = "http://127.0.0.1:8000/api/attachments/";

      let res = await this.$axios.post(url, payload);
      // console.log(res.data)
      commit("PUSH_NEW_FILES", res.data);
    } catch (error) {
      console.log(error);
    }
  },
  async deleteAttached({ state, commit }, id) {
    let url = `http://127.0.0.1:8000/api/attachments/${id}/`;
    // console.log(url);
    try {
      await this.$axios.delete(url);

      commit("REMOVE_ATTACHED_FILE", id);
    } catch (error) {
      console.log(error);
    }
  },
  async addNewTreatment({ state, commit }, payload) {
    let url = "http://127.0.0.1:8000/api/treatments/";

    try {
      // console.log(Array.from(payload));
      const newTreatment = await this.$axios.post(url, payload);
      commit("ADD_NEW_TREATMENT", newTreatment.data);
    } catch (err) {
      console.log(err);
    }
  },
  getPatientTreats({ state, commit }, id) {
    commit("GET_PATIENT_TREATMENTS", id);
  }
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
  }
};

export default {
  state,
  mutations,
  actions,
  getters
};
