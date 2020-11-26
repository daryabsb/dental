const state = () => ({
    isImageUploadOpen: false,
});

const mutations = () => ({

    toggleImageUploadOpen(state) {
        state.isImageUploadOpen = !state.isImageUploadOpen
    },
    
});

const actions = () => ({
    toggleImageUploadOpen({state, commit}) {
        commit('toggleImageUploadOpen');
    }
});
const getters = () => ({
    show(state) {
        return state.isImageUploadOpen
    }
});
export default {
    state, mutations, actions, getters
};