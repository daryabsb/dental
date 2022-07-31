<template>
  <div @click="closeMenu()" class="dropdown-menu dropdown-menu-right" v-if="isUserNavOpen">
    <a class="dropdown-item"
      ><i class="dripicons-user text-muted mr-2"></i> Profile</a
    >
    <nuxt-link to="/register" class="dropdown-item"
      ><i class="dripicons-wallet text-muted mr-2"></i> Add Staff</nuxt-link
    >
    <a class="dropdown-item"
      ><i class="dripicons-gear text-muted mr-2"></i> Settings</a
    >
    <a class="dropdown-item"
      ><i class="dripicons-lock text-muted mr-2"></i> Lock screen</a
    >
    <div class="dropdown-divider"></div>
    <a class="dropdown-item" @click="onLogout()"
      ><i class="dripicons-exit text-muted mr-2"></i> Logout</a
    >
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import { store, mutations } from "../../../store/utils/conf";
export default {
  methods: {
    onLogout() {
      this.$auth.logout();
    },
    closeMenu() {
      // CLOSE MENU
      mutations.toggleUserNav();
      // this.$emit('toggle-show');
    },
  },
  computed: {
    isUserNavOpen() {
      return store.isUserNavOpen;
    },
  },
};
</script>
